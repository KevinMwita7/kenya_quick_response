import 'dart:convert';
import 'package:crclib/catalog.dart';
import 'package:kenya_quick_response/src/emv_config.dart';
import 'package:kenya_quick_response/src/models/emv_tag.dart';
import '../models/additional_data.dart';
import '../models/kenya_quick_response_payload.dart';
import '../models/merchant_account_information.dart';
import '../models/merchant_information_language_template.dart';
import '../models/merchant_premises_location.dart';
import '../models/merchant_ussd_information.dart';
import '../models/qr_timestamp_information.dart';
import '../models/template_information.dart';
import '../models/tip_or_convenience_indicator.dart';

class QrCodeParser {
  static KenyaQuickResponsePayload parse(String qrCode) {
    // Check for minimum length (e.g., Payload Format Indicator + CRC)
    if (qrCode.length < 12) {
      // 000201 + 6304XXXX
      throw ArgumentError('QR code string is too short to be valid.');
    }

    final payloadWithoutCrc = qrCode.substring(0, qrCode.length - 8);
    final crcData = qrCode.substring(qrCode.length - 8);

    if (crcData.substring(0, 2) != '63' || crcData.substring(2, 4) != '04') {
      throw ArgumentError('Invalid CRC tag or length for the CRC block.');
    }

    final crcValue = crcData.substring(4);

    var calculatedCrc = Crc16CcittFalse().convert(
      utf8.encode('${payloadWithoutCrc}6304'),
    );
    var calculatedCrcString = calculatedCrc
        .toRadixString(16)
        .toUpperCase()
        .padLeft(4, '0');

    if (calculatedCrcString != crcValue) {
      throw ArgumentError(
        'CRC mismatch: Expected $calculatedCrcString, got $crcValue',
      );
    }

    var data = _parseTlv(payloadWithoutCrc);

    // Parse Merchant Account Information (Fields 02-51)
    // According to KE-QR Standard Table 7.3, at least one MUST be present
    var merchantAccountInformation = <MerchantAccountInformation>[];
    for (var i = 2; i <= 51; i++) {
      var fieldId = i.toString().padLeft(2, '0');
      if (data.containsKey(fieldId)) {
        var merchantAccountData = _parseTlv(
          data[fieldId]!,
          parentTag: 'merchantAccountSubTags',
        );
        merchantAccountInformation.add(
          MerchantAccountInformation(
            fieldId: fieldId,
            globallyUniqueIdentifier: merchantAccountData['00'],
            paymentNetworkSpecificData: Map.from(merchantAccountData)
              ..remove('00'),
          ),
        );
      }
    }

    // Validate that at least one merchant account field is present
    if (merchantAccountInformation.isEmpty) {
      throw ArgumentError(
        'At least one Merchant Account Information field (02-51) must be present according to KE-QR Standard Table 7.3.',
      );
    }

    TipOrConvenienceIndicator? tipOrConvenienceIndicator;
    if (data.containsKey('55')) {
      switch (data['55']) {
        case '01':
          tipOrConvenienceIndicator =
              TipOrConvenienceIndicator.promptToEnterTip;
          break;
        case '02':
          tipOrConvenienceIndicator =
              TipOrConvenienceIndicator.fixedConvenienceFee;
          break;
        case '03':
          tipOrConvenienceIndicator =
              TipOrConvenienceIndicator.percentageConvenienceFee;
          break;
        default:
          throw ArgumentError(
            'Invalid TipOrConvenienceIndicator value: ${data['55']}',
          );
      }
    }

    AdditionalData? additionalData;
    if (data.containsKey('62')) {
      var additionalDataMap = _parseTlv(data['62']!, parentTag: '62');
      additionalData = AdditionalData(
        billNumber: additionalDataMap['01'],
        mobileNumber: additionalDataMap['02'],
        storeLabel: additionalDataMap['03'],
        loyaltyNumber: additionalDataMap['04'],
        referenceLabel: additionalDataMap['05'],
        customerLabel: additionalDataMap['06'],
        terminalLabel: additionalDataMap['07'],
        purposeOfTransaction: additionalDataMap['08'],
        additionalConsumerDataRequest: additionalDataMap['09'],
        merchantTaxId: additionalDataMap['10'],
        merchantChannel: additionalDataMap['11'],
      );
    }

    MerchantInformationLanguageTemplate? merchantInformationLanguageTemplate;
    if (data.containsKey('64')) {
      var merchantInfoMap = _parseTlv(data['64']!, parentTag: '64');

      merchantInformationLanguageTemplate = MerchantInformationLanguageTemplate(
        languagePreference: merchantInfoMap['00']!,
        merchantName: merchantInfoMap['01']!,
        merchantCity: merchantInfoMap['02']!,
      );
    }

    MerchantPremisesLocation? merchantPremisesLocation;
    if (data.containsKey('80')) {
      var locationMap = _parseTlv(data['80']!, parentTag: '80');
      LocationDataProvider? provider;
      if (locationMap.containsKey('01')) {
        switch (locationMap['01']) {
          case '01':
            provider = LocationDataProvider.gpsCoordinates;
            break;
          case '02':
            provider = LocationDataProvider.what3words;
            break;
          case '03':
            provider = LocationDataProvider.googlePlusCodes;
            break;
        }
      }
      merchantPremisesLocation = MerchantPremisesLocation(
        locationDataProvider: provider,
        locationData: locationMap['02'],
        locationAccuracy: locationMap['03'],
      );
    }

    // Parse Field 81: Merchant USSD Information (nested TLV)
    MerchantUssdInformation? merchantUssdInformation;
    if (data.containsKey('81')) {
      var ussdData = _parseTlv(data['81']!, parentTag: '81');
      merchantUssdInformation = MerchantUssdInformation(
        globallyUniqueIdentifier: ussdData['00'],
        paymentNetworkSpecificData: Map.from(ussdData)..remove('00'),
      );
    }

    // Parse Field 82: QR Timestamp Information (nested TLV)
    QrTimestampInformation? qrTimestampInformation;
    if (data.containsKey('82')) {
      var timestampData = _parseTlv(data['82']!, parentTag: '82');
      qrTimestampInformation = QrTimestampInformation(
        globallyUniqueIdentifier: timestampData['00'],
        timestampData: Map.from(timestampData)..remove('00'),
      );
    }

    // Parse Fields 83-99: Additional Templates (nested TLV)
    var additionalTemplates = <TemplateInformation>[];
    for (var i = 83; i <= 99; i++) {
      var fieldId = i.toString().padLeft(2, '0');
      if (data.containsKey(fieldId)) {
        var templateData = _parseTlv(data[fieldId]!, parentTag: fieldId);
        additionalTemplates.add(
          TemplateInformation(
            fieldId: fieldId,
            globallyUniqueIdentifier: templateData['00'],
            templateData: Map.from(templateData)..remove('00'),
          ),
        );
      }
    }

    return KenyaQuickResponsePayload(
      payloadFormatIndicator: data['00']!,
      pointOfInitiationMethod: data['01']!,
      merchantAccountInformation: merchantAccountInformation,
      merchantCategoryCode: data['52'], // Optional field
      transactionCurrency: data['53']!,
      transactionAmount: data['54'], // Conditional field
      tipOrConvenienceIndicator: tipOrConvenienceIndicator,
      convenienceFeeFixed: data['56'],
      convenienceFeePercentage: data['57'],
      countryCode: data['58']!,
      merchantName: data['59']!,
      merchantCity: data['60'], // Optional field
      postalCode: data['61'], // Optional field
      merchantUssdInformation: merchantUssdInformation,
      qrTimestampInformation: qrTimestampInformation,
      additionalTemplates: additionalTemplates.isNotEmpty
          ? additionalTemplates
          : null,
      additionalData: additionalData,
      merchantInformationLanguageTemplate: merchantInformationLanguageTemplate,
      merchantPremisesLocation: merchantPremisesLocation,
      crc: crcValue,
    );
  }

  static Map<String, String> _parseTlv(String data, {String? parentTag}) {
    var map = <String, String>{};
    var i = 0;
    while (i < data.length) {
      if (i + 4 > data.length) {
        throw ArgumentError(
          'Malformed TLV string: Not enough characters for tag and length at index $i.',
        );
      }
      var tag = data.substring(i, i + 2);
      var lengthStr = data.substring(i + 2, i + 4);
      int length;
      try {
        length = int.parse(lengthStr);
      } catch (e) {
        throw ArgumentError(
          'Malformed TLV string: Invalid length "$lengthStr" for tag "$tag" at index $i.',
        );
      }

      if (i + 4 + length > data.length) {
        throw ArgumentError(
          'Malformed TLV string: Declared length $length for tag $tag exceeds available data at index $i. (Remaining: ${data.substring(i)})',
        );
      }
      var value = data.substring(i + 4, i + 4 + length);

      // Validate against EMV tag definitions
      Map<String, EmvTagDefinition>? definitionMap;
      if (parentTag != null) {
        definitionMap = emvNestedTagDefinitions[parentTag];
      }
      final definition = definitionMap != null
          ? definitionMap[tag]
          : emvTagDefinitions[tag];

      if (definition != null) {
        // Validate type
        switch (definition.type) {
          case EmvDataType.numeric:
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              throw ArgumentError(
                'Tag $tag (ID: ${definition.id}) value "$value" is not numeric.',
              );
            }
            break;
          case EmvDataType.alphanumeric:
            if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
              throw ArgumentError(
                'Tag $tag (ID: ${definition.id}) value "$value" is not alphanumeric.',
              );
            }
            break;
          case EmvDataType.ans:
            if (!RegExp(
              r'''^[a-zA-Z0-9!"#$%&'()*+,\-./:;<=>?@\[\\\]^_`{|}~ ]*$''',
            ).hasMatch(value)) {
              throw ArgumentError(
                'Tag $tag (ID: ${definition.id}) value "$value" is not ans.',
              );
            }
            break;
          case EmvDataType.string:
          case EmvDataType.undefined:
            // No specific regex for general string or undefined types
            break;
        }

        // Validate length
        if (definition.minLength != null &&
            value.length < definition.minLength!) {
          throw ArgumentError(
            'Tag $tag (ID: ${definition.id}) value "$value" is too short. Min length: ${definition.minLength}',
          );
        }
        if (definition.maxLength != null &&
            value.length > definition.maxLength!) {
          throw ArgumentError(
            'Tag $tag (ID: ${definition.id}) value "$value" is too long. Max length: ${definition.maxLength}',
          );
        }

        // Validate pattern if available
        if (definition.pattern != null &&
            !(definition.pattern as RegExp).hasMatch(value)) {
          throw ArgumentError(
            'Tag $tag (ID: ${definition.id}) value "$value" does not match required pattern.',
          );
        }
      }

      map[tag] = value;
      i += 4 + length;
    }
    return map;
  }
}
