import 'dart:convert';
import 'package:crclib/catalog.dart';
import 'package:kenya_quick_response/src/emv_config.dart';
import 'package:kenya_quick_response/src/models/emv_tag.dart';
import '../models/kenya_quick_response_payload.dart';

import '../models/merchant_premises_location.dart';
import '../models/tip_or_convenience_indicator.dart';

class QrCodeGenerator {
  static String generate(KenyaQuickResponsePayload payload) {
    var parts = <String>[];

    // Mandatory fields
    parts.add(_validateAndTlv('00', payload.payloadFormatIndicator));
    parts.add(_validateAndTlv('01', payload.pointOfInitiationMethod.value));

    // Merchant Account Information (Fields 02-51) - At least one MUST be present
    if (payload.merchantAccountInformation.isEmpty) {
      throw ArgumentError(
        'At least one Merchant Account Information field (02-51) must be present according to KE-QR Standard Table 7.3.',
      );
    }

    // Generate TLV for each merchant account information field
    for (var merchantAccount in payload.merchantAccountInformation) {
      var merchantAccountParts = <String>[];

      // Add globally unique identifier (sub-tag 00) if present
      if (merchantAccount.globallyUniqueIdentifier != null) {
        merchantAccountParts.add(
          _validateAndTlv(
            '00',
            merchantAccount.globallyUniqueIdentifier!,
            parentTag: 'merchantAccountSubTags',
          ),
        );
      }

      // Add payment network specific data (sub-tags 01 and beyond)
      for (var entry in merchantAccount.paymentNetworkSpecificData.entries) {
        merchantAccountParts.add(
          _validateAndTlv(
            entry.key,
            entry.value,
            parentTag: 'merchantAccountSubTags',
          ),
        );
      }

      parts.add(
        _validateAndTlv(merchantAccount.fieldId, merchantAccountParts.join()),
      );
    }

    if (payload.merchantCategoryCode != null) {
      parts.add(_validateAndTlv('52', payload.merchantCategoryCode!));
    }

    parts.add(_validateAndTlv('53', payload.transactionCurrency));

    if (payload.transactionAmount != null) {
      parts.add(_validateAndTlv('54', payload.transactionAmount!));
    }

    if (payload.tipOrConvenienceIndicator != null) {
      String indicatorValue;
      switch (payload.tipOrConvenienceIndicator!) {
        case TipOrConvenienceIndicator.promptToEnterTip:
          indicatorValue = '01';
          parts.add(_validateAndTlv('55', indicatorValue));
          break;
        case TipOrConvenienceIndicator.fixedConvenienceFee:
          indicatorValue = '02';
          parts.add(_validateAndTlv('55', indicatorValue));
          if (payload.convenienceFeeFixed != null) {
            parts.add(_validateAndTlv('56', payload.convenienceFeeFixed!));
          }
          break;
        case TipOrConvenienceIndicator.percentageConvenienceFee:
          indicatorValue = '03';
          parts.add(_validateAndTlv('55', indicatorValue));
          if (payload.convenienceFeePercentage != null) {
            parts.add(_validateAndTlv('57', payload.convenienceFeePercentage!));
          }
          break;
      }
    }

    parts.add(_validateAndTlv('58', payload.countryCode));
    parts.add(_validateAndTlv('59', payload.merchantName));

    if (payload.merchantCity != null) {
      parts.add(_validateAndTlv('60', payload.merchantCity!));
    }
    if (payload.postalCode != null) {
      parts.add(_validateAndTlv('61', payload.postalCode!));
    }

    // Field 62
    if (payload.additionalData != null) {
      var additionalDataParts = <String>[];
      if (payload.additionalData!.billNumber != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '01',
            payload.additionalData!.billNumber!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.mobileNumber != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '02',
            payload.additionalData!.mobileNumber!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.storeLabel != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '03',
            payload.additionalData!.storeLabel!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.loyaltyNumber != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '04',
            payload.additionalData!.loyaltyNumber!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.referenceLabel != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '05',
            payload.additionalData!.referenceLabel!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.customerLabel != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '06',
            payload.additionalData!.customerLabel!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.terminalLabel != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '07',
            payload.additionalData!.terminalLabel!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.purposeOfTransaction != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '08',
            payload.additionalData!.purposeOfTransaction!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.additionalConsumerDataRequest != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '09',
            payload.additionalData!.additionalConsumerDataRequest!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.merchantTaxId != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '10',
            payload.additionalData!.merchantTaxId!,
            parentTag: '62',
          ),
        );
      }
      if (payload.additionalData!.merchantChannel != null) {
        additionalDataParts.add(
          _validateAndTlv(
            '11',
            payload.additionalData!.merchantChannel!,
            parentTag: '62',
          ),
        );
      }
      parts.add(_validateAndTlv('62', additionalDataParts.join()));
    }

    // Field 64
    if (payload.merchantInformationLanguageTemplate != null) {
      var merchantInfoParts = <String>[];
      merchantInfoParts.add(
        _validateAndTlv(
          '00',
          payload.merchantInformationLanguageTemplate!.languagePreference,
          parentTag: '64',
        ),
      );
      merchantInfoParts.add(
        _validateAndTlv(
          '01',
          payload.merchantInformationLanguageTemplate!.merchantName,
          parentTag: '64',
        ),
      );
      merchantInfoParts.add(
        _validateAndTlv(
          '02',
          payload.merchantInformationLanguageTemplate!.merchantCity,
          parentTag: '64',
        ),
      );
      parts.add(_validateAndTlv('64', merchantInfoParts.join()));
    }

    // Field 80
    if (payload.merchantPremisesLocation != null) {
      var locationParts = <String>[];
      if (payload.merchantPremisesLocation!.locationDataProvider != null) {
        String providerValue;
        switch (payload.merchantPremisesLocation!.locationDataProvider!) {
          case LocationDataProvider.gpsCoordinates:
            providerValue = '01';
            break;
          case LocationDataProvider.what3words:
            providerValue = '02';
            break;
          case LocationDataProvider.googlePlusCodes:
            providerValue = '03';
            break;
        }
        locationParts.add(
          _validateAndTlv('01', providerValue, parentTag: '80'),
        );
      }
      if (payload.merchantPremisesLocation!.locationData != null) {
        locationParts.add(
          _validateAndTlv(
            '02',
            payload.merchantPremisesLocation!.locationData!,
            parentTag: '80',
          ),
        );
      }
      if (payload.merchantPremisesLocation!.locationAccuracy != null) {
        locationParts.add(
          _validateAndTlv(
            '03',
            payload.merchantPremisesLocation!.locationAccuracy!,
            parentTag: '80',
          ),
        );
      }
      if (locationParts.isNotEmpty) {
        parts.add(_validateAndTlv('80', locationParts.join()));
      }
    }

    // Field 81: Merchant USSD Information (nested TLV)
    if (payload.merchantUssdInformation != null) {
      var ussdParts = <String>[];
      if (payload.merchantUssdInformation!.globallyUniqueIdentifier != null) {
        ussdParts.add(
          _validateAndTlv(
            '00',
            payload.merchantUssdInformation!.globallyUniqueIdentifier!,
            parentTag: '81',
          ),
        );
      }
      for (var entry in payload
          .merchantUssdInformation!.paymentNetworkSpecificData.entries) {
        ussdParts.add(_validateAndTlv(entry.key, entry.value, parentTag: '81'));
      }
      parts.add(_validateAndTlv('81', ussdParts.join()));
    }

    // Field 82: QR Timestamp Information (nested TLV)
    if (payload.qrTimestampInformation != null) {
      var timestampParts = <String>[];
      if (payload.qrTimestampInformation!.globallyUniqueIdentifier != null) {
        timestampParts.add(
          _validateAndTlv(
            '00',
            payload.qrTimestampInformation!.globallyUniqueIdentifier!,
            parentTag: '82',
          ),
        );
      }
      for (var entry in payload.qrTimestampInformation!.timestampData.entries) {
        timestampParts.add(
          _validateAndTlv(entry.key, entry.value, parentTag: '82'),
        );
      }
      parts.add(_validateAndTlv('82', timestampParts.join()));
    }

    // Fields 83-99: Additional Templates (nested TLV)
    if (payload.additionalTemplates != null) {
      for (var template in payload.additionalTemplates!) {
        var templateParts = <String>[];
        if (template.globallyUniqueIdentifier != null) {
          templateParts.add(
            _validateAndTlv(
              '00',
              template.globallyUniqueIdentifier!,
              parentTag: 'additionalTemplates',
            ),
          );
        }
        for (var entry in template.templateData.entries) {
          templateParts.add(
            _validateAndTlv(
              entry.key,
              entry.value,
              parentTag: 'additionalTemplates',
            ),
          );
        }
        parts.add(_validateAndTlv(template.fieldId, templateParts.join()));
      }
    }

    var payloadString = parts.join();
    var crc = Crc16CcittFalse().convert(utf8.encode('${payloadString}6304'));
    var crcString = crc.toRadixString(16).toUpperCase().padLeft(4, '0');

    return '${payloadString}6304$crcString';
  }

  static String _validateAndTlv(
    String tag,
    String? value, {
    String? parentTag,
  }) {
    Map<String, EmvTagDefinition>? definitionMap;
    if (parentTag != null) {
      definitionMap = emvNestedTagDefinitions[parentTag];
    }
    final definition =
        definitionMap != null ? definitionMap[tag] : emvTagDefinitions[tag];

    // Handle null or empty values first
    if (value == null || value.isEmpty) {
      if (definition != null && definition.mandatory) {
        throw ArgumentError(
          'Mandatory tag $tag (parent: $parentTag) cannot have a null or empty value.',
        );
      }
      // If optional and null/empty, return empty string
      return '';
    }

    // Now 'value' is guaranteed to be non-null and non-empty
    if (definition == null) {
      // If no specific definition, assume generic alphanumeric for now
      return '$tag${value.length.toString().padLeft(2, '0')}$value';
    }

    // Validate type
    switch (definition.type) {
      case EmvDataType.numeric:
        // Support decimals for amount fields (54, 56, 57)
        final supportsDecimals = ['54', '56', '57'].contains(tag);
        final pattern = supportsDecimals ? r'^\d+(\.\d+)?$' : r'^\d+$';
        if (!RegExp(pattern).hasMatch(value)) {
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
    if (definition.minLength != null && value.length < definition.minLength!) {
      throw ArgumentError(
        'Tag $tag (ID: ${definition.id}) value "$value" is too short. Min length: ${definition.minLength}',
      );
    }
    if (definition.maxLength != null && value.length > definition.maxLength!) {
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

    // All validations passed, format as TLV
    var length = value.length.toString().padLeft(2, '0');
    return '$tag$length$value';
  }
}
