import 'package:keqr/keqr.dart';

void main() {
  // NOTE: The following testQr string has been sanitized to remove PII.
  // The CRC is intentionally invalidated ('XXXX') because changing the content
  // requires a new CRC to be calculated. As a result, the parsing logic
  // in the `try` block is expected to fail with a CRC mismatch error.
  final testQr =
      '00020101021228230008ke.go.qr0107987654329120008ke.go.qr5204000053034045802KE5921Jane Elizabeth Doe_Po610200620605020182320008ke.go.qr0116343122025 04124283380010m-pesa.com0102020305000020405000006304XXXX';

  print('''--- Attempting to parse provided QR code string ---''');
  print(testQr);

  try {
    var parsedPayload = QrCodeParser.parse(testQr);
    // This part is not expected to be reached due to the invalid CRC.
    print('\nSuccessfully parsed QR Code String:');
    print('  Payload Format Indicator: ${parsedPayload.payloadFormatIndicator}');
    print(
        '  Point of Initiation Method: ${parsedPayload.pointOfInitiationMethod}');
    print(
        '  Merchant Category Code: ${parsedPayload.merchantCategoryCode ?? "N/A"}');
    print('  Transaction Currency: ${parsedPayload.transactionCurrency}');
    print('  Transaction Amount: ${parsedPayload.transactionAmount ?? "N/A"}');
    print('  Country Code: ${parsedPayload.countryCode}');
    print('  Merchant Name: ${parsedPayload.merchantName}');
    print('  Merchant City: ${parsedPayload.merchantCity ?? "N/A"}');
  } catch (e) {
    print('\nError parsing QR code (as expected due to invalid CRC):');
    print(e);
  }

  print('\n--- Attempting to generate a new QR code string ---');
  // Create a KeqrPayload object for generation
  var payloadToGenerate = KeqrPayload(
    payloadFormatIndicator: '01',
    pointOfInitiationMethod: '12', // '11' for static, '12' for dynamic
    merchantAccountInformation: [
      MerchantAccountInformation(
        fieldId: '28', // PSP merchant account identifier
        globallyUniqueIdentifier: 'com.examplepsp.payments',
        paymentNetworkSpecificData: {
          '01': 'MERCHANT789012', // Payment network specific merchant ID
        },
      ),
    ],
    merchantCategoryCode: '4111', // Transportation (Optional now)
    transactionCurrency: '404', // Kenyan Shilling (ISO 4217 code)
    transactionAmount: '100.00', // Conditional
    countryCode: 'KE',
    merchantName: 'Generated Merchant',
    merchantCity: 'Nairobi', // Optional now
    merchantUssdInformation: MerchantUssdInformation(
      globallyUniqueIdentifier: 'com.examplepsp.ussd',
      paymentNetworkSpecificData: {
        '01': '*123#',
      },
    ),
    qrTimestampInformation: QrTimestampInformation(
      globallyUniqueIdentifier: 'com.examplepsp.timestamp',
      timestampData: {
        '01': '20231210103000',
      },
    ),
    additionalData: AdditionalData(
      billNumber: 'BILL123',
      purposeOfTransaction: 'Payment',
    ),
  );

  try {
    var generatedQrCode = QrCodeGenerator.generate(payloadToGenerate);
    print('\nGenerated QR Code String:');
    print(generatedQrCode);

    // Also attempt to parse the generated QR code to verify
    var parsedGeneratedPayload = QrCodeParser.parse(generatedQrCode);
    print('\nSuccessfully parsed GENERATED QR Code String:');
    print('  Merchant Name: ${parsedGeneratedPayload.merchantName}');
    print('  Transaction Amount: ${parsedGeneratedPayload.transactionAmount}');
    if (parsedGeneratedPayload.merchantUssdInformation != null) {
      print('  Merchant USSD Information:');
      print(
          '    Globally Unique ID: ${parsedGeneratedPayload.merchantUssdInformation!.globallyUniqueIdentifier}');
      print(
          '    USSD Code: ${parsedGeneratedPayload.merchantUssdInformation!.paymentNetworkSpecificData['01']}');
    }
    if (parsedGeneratedPayload.qrTimestampInformation != null) {
      print('  QR Timestamp Information:');
      print(
          '    Globally Unique ID: ${parsedGeneratedPayload.qrTimestampInformation!.globallyUniqueIdentifier}');
      print(
          '    Timestamp: ${parsedGeneratedPayload.qrTimestampInformation!.timestampData['01']}');
    }
  } catch (e) {
    print('\nError generating or parsing generated QR code: $e');
  }
}
