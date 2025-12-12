import 'package:kenya_quick_response/src/models/emv_tag.dart';

const Map<String, EmvTagDefinition> emvTagDefinitions = {
  // ID 00: Payload Format Indicator (Mandatory)
  '00': EmvTagDefinition(
    id: '00',
    type: EmvDataType.numeric,
    minLength: 2,
    maxLength: 2,
    mandatory: true,
  ),

  // ID 01: Point of Initiation Method (Mandatory)
  '01': EmvTagDefinition(
    id: '01',
    type: EmvDataType.numeric,
    minLength: 2,
    maxLength: 2,
    mandatory: true,
  ),

  // ID 02-51: Merchant Account Information (Mandatory)
  // These tags are composite TLV containers with a maximum length of 99.
  // Type: string (no format validation on the container, validation happens on nested tags)
  '02': EmvTagDefinition(
    id: '02',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '03': EmvTagDefinition(
    id: '03',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '04': EmvTagDefinition(
    id: '04',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '05': EmvTagDefinition(
    id: '05',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '06': EmvTagDefinition(
    id: '06',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '07': EmvTagDefinition(
    id: '07',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '08': EmvTagDefinition(
    id: '08',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '09': EmvTagDefinition(
    id: '09',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '10': EmvTagDefinition(
    id: '10',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '11': EmvTagDefinition(
    id: '11',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '12': EmvTagDefinition(
    id: '12',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '13': EmvTagDefinition(
    id: '13',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '14': EmvTagDefinition(
    id: '14',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '15': EmvTagDefinition(
    id: '15',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '16': EmvTagDefinition(
    id: '16',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '17': EmvTagDefinition(
    id: '17',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '18': EmvTagDefinition(
    id: '18',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '19': EmvTagDefinition(
    id: '19',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '20': EmvTagDefinition(
    id: '20',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '21': EmvTagDefinition(
    id: '21',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '22': EmvTagDefinition(
    id: '22',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '23': EmvTagDefinition(
    id: '23',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '24': EmvTagDefinition(
    id: '24',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '25': EmvTagDefinition(
    id: '25',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '26': EmvTagDefinition(
    id: '26',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '27': EmvTagDefinition(
    id: '27',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '28': EmvTagDefinition(
    id: '28',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '29': EmvTagDefinition(
    id: '29',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '30': EmvTagDefinition(
    id: '30',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '31': EmvTagDefinition(
    id: '31',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '32': EmvTagDefinition(
    id: '32',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '33': EmvTagDefinition(
    id: '33',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '34': EmvTagDefinition(
    id: '34',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '35': EmvTagDefinition(
    id: '35',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '36': EmvTagDefinition(
    id: '36',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '37': EmvTagDefinition(
    id: '37',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '38': EmvTagDefinition(
    id: '38',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '39': EmvTagDefinition(
    id: '39',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '40': EmvTagDefinition(
    id: '40',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '41': EmvTagDefinition(
    id: '41',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '42': EmvTagDefinition(
    id: '42',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '43': EmvTagDefinition(
    id: '43',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '44': EmvTagDefinition(
    id: '44',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '45': EmvTagDefinition(
    id: '45',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '46': EmvTagDefinition(
    id: '46',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '47': EmvTagDefinition(
    id: '47',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '48': EmvTagDefinition(
    id: '48',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '49': EmvTagDefinition(
    id: '49',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '50': EmvTagDefinition(
    id: '50',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),
  '51': EmvTagDefinition(
    id: '51',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),

  // ID 52: Merchant Category Code (Optional)
  '52': EmvTagDefinition(
    id: '52',
    type: EmvDataType.numeric,
    minLength: 4,
    maxLength: 4,
  ),

  // ID 53: Transaction Currency (Mandatory)
  '53': EmvTagDefinition(
    id: '53',
    type: EmvDataType.numeric,
    minLength: 3,
    maxLength: 3,
    mandatory: true,
  ),

  // ID 54: Transaction Amount (Optional) - Numeric with decimal support
  '54': EmvTagDefinition(id: '54', type: EmvDataType.numeric, maxLength: 14),

  // ID 55: Tip or Convenience Indicator (Optional)
  '55': EmvTagDefinition(
    id: '55',
    type: EmvDataType.numeric,
    minLength: 2,
    maxLength: 2,
  ),

  // ID 56: Value of Convenience Fee Fixed (Optional) - Numeric with decimal support
  '56': EmvTagDefinition(id: '56', type: EmvDataType.numeric, maxLength: 13),

  // ID 57: Value of Convenience Fee Percentage (Optional) - Numeric with decimal support
  '57': EmvTagDefinition(id: '57', type: EmvDataType.numeric, maxLength: 5),

  // ID 58: Country Code (Mandatory)
  '58': EmvTagDefinition(
    id: '58',
    type: EmvDataType.alphanumeric,
    minLength: 2,
    maxLength: 2,
    mandatory: true,
  ),

  // ID 59: Merchant Name (Mandatory) - ANS to support spaces and special characters
  '59': EmvTagDefinition(
    id: '59',
    type: EmvDataType.ans,
    maxLength: 25,
    mandatory: true,
  ),

  // ID 60: Merchant City (Optional) - ANS to support spaces
  '60': EmvTagDefinition(id: '60', type: EmvDataType.ans, maxLength: 15),

  // ID 61: Postal Code (Optional)
  '61': EmvTagDefinition(
    id: '61',
    type: EmvDataType.alphanumeric,
    minLength: 2,
    maxLength: 2,
  ),

  // ID 62: Additional Data Field (Optional)
  '62': EmvTagDefinition(id: '62', type: EmvDataType.string, maxLength: 99),

  // ID 63: CRC (Cyclic Redundancy Check) (Mandatory - already handled)
  '63': EmvTagDefinition(
    id: '63',
    type: EmvDataType.alphanumeric,
    minLength: 4,
    maxLength: 4,
    mandatory: true,
  ),

  // ID 65-79: Reserved for EMVCo (Optional)
  '65': EmvTagDefinition(id: '65', type: EmvDataType.string, maxLength: 99),
  '66': EmvTagDefinition(id: '66', type: EmvDataType.string, maxLength: 99),
  '67': EmvTagDefinition(id: '67', type: EmvDataType.string, maxLength: 99),
  '68': EmvTagDefinition(id: '68', type: EmvDataType.string, maxLength: 99),
  '69': EmvTagDefinition(id: '69', type: EmvDataType.string, maxLength: 99),
  '70': EmvTagDefinition(id: '70', type: EmvDataType.string, maxLength: 99),
  '71': EmvTagDefinition(id: '71', type: EmvDataType.string, maxLength: 99),
  '72': EmvTagDefinition(id: '72', type: EmvDataType.string, maxLength: 99),
  '73': EmvTagDefinition(id: '73', type: EmvDataType.string, maxLength: 99),
  '74': EmvTagDefinition(id: '74', type: EmvDataType.string, maxLength: 99),
  '75': EmvTagDefinition(id: '75', type: EmvDataType.string, maxLength: 99),
  '76': EmvTagDefinition(id: '76', type: EmvDataType.string, maxLength: 99),
  '77': EmvTagDefinition(id: '77', type: EmvDataType.string, maxLength: 99),
  '78': EmvTagDefinition(id: '78', type: EmvDataType.string, maxLength: 99),
  '79': EmvTagDefinition(id: '79', type: EmvDataType.string, maxLength: 99),

  // ID 80: Merchant Premises Location (Composite TLV container)
  '80': EmvTagDefinition(id: '80', type: EmvDataType.string, maxLength: 99),

  // ID 81: Merchant USSD Information (Composite TLV container)
  '81': EmvTagDefinition(
    id: '81',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),

  // ID 82: QR Timestamp Information (Composite TLV container)
  '82': EmvTagDefinition(
    id: '82',
    type: EmvDataType.string,
    maxLength: 99,
    mandatory: true,
  ),

  // ID 83: Reserved for Safaricom. This field shall be moved to field 29 in the future
  '83': EmvTagDefinition(id: '83', type: EmvDataType.string, maxLength: 99),

  // ID 84-99: Unreserver templates
  '84': EmvTagDefinition(id: '84', type: EmvDataType.string, maxLength: 99),
  '85': EmvTagDefinition(id: '85', type: EmvDataType.string, maxLength: 99),
  '86': EmvTagDefinition(id: '86', type: EmvDataType.string, maxLength: 99),
  '87': EmvTagDefinition(id: '87', type: EmvDataType.string, maxLength: 99),
  '88': EmvTagDefinition(id: '88', type: EmvDataType.string, maxLength: 99),
  '89': EmvTagDefinition(id: '89', type: EmvDataType.string, maxLength: 99),
  '90': EmvTagDefinition(id: '90', type: EmvDataType.string, maxLength: 99),
  '91': EmvTagDefinition(id: '91', type: EmvDataType.string, maxLength: 99),
  '92': EmvTagDefinition(id: '92', type: EmvDataType.string, maxLength: 99),
  '93': EmvTagDefinition(id: '93', type: EmvDataType.string, maxLength: 99),
  '94': EmvTagDefinition(id: '94', type: EmvDataType.string, maxLength: 99),
  '95': EmvTagDefinition(id: '95', type: EmvDataType.string, maxLength: 99),
  '96': EmvTagDefinition(id: '96', type: EmvDataType.string, maxLength: 99),
  '97': EmvTagDefinition(id: '97', type: EmvDataType.string, maxLength: 99),
  '98': EmvTagDefinition(id: '98', type: EmvDataType.string, maxLength: 99),
  '99': EmvTagDefinition(id: '99', type: EmvDataType.string, maxLength: 99),
};

const Map<String, Map<String, EmvTagDefinition>> emvNestedTagDefinitions = {
  // Sub-tags for Merchant Account Information Template (IDs 02-51)
  // These all use the same sub-tags, so we define a common set
  // This map will be dynamically accessed by parent ID (e.g., '26', '27', etc.)
  'merchantAccountSubTags': {
    // Sub-tag '00' for Globally Unique Identifier (ans, variable length)
    '00': EmvTagDefinition(
      id: '00',
      type: EmvDataType.ans,
      maxLength: 32, // Common GUID length
    ),
    // Additional Payment Network Specific Data (sub-tags 01 and beyond)
    // These are typically ans, up to 99 length.
    '01': EmvTagDefinition(id: '01', type: EmvDataType.ans, maxLength: 99),
    '02': EmvTagDefinition(id: '02', type: EmvDataType.ans, maxLength: 99),
    '03': EmvTagDefinition(id: '03', type: EmvDataType.ans, maxLength: 99),
    '04': EmvTagDefinition(id: '04', type: EmvDataType.ans, maxLength: 99),
    '05': EmvTagDefinition(id: '05', type: EmvDataType.ans, maxLength: 99),
    '06': EmvTagDefinition(id: '06', type: EmvDataType.ans, maxLength: 99),
    '07': EmvTagDefinition(id: '07', type: EmvDataType.ans, maxLength: 99),
    '08': EmvTagDefinition(id: '08', type: EmvDataType.ans, maxLength: 99),
    '09': EmvTagDefinition(id: '09', type: EmvDataType.ans, maxLength: 99),
    '10': EmvTagDefinition(id: '10', type: EmvDataType.ans, maxLength: 99),
    '11': EmvTagDefinition(id: '11', type: EmvDataType.ans, maxLength: 99),
    '12': EmvTagDefinition(id: '12', type: EmvDataType.ans, maxLength: 99),
    '13': EmvTagDefinition(id: '13', type: EmvDataType.ans, maxLength: 99),
    '14': EmvTagDefinition(id: '14', type: EmvDataType.ans, maxLength: 99),
    '15': EmvTagDefinition(id: '15', type: EmvDataType.ans, maxLength: 99),
    '16': EmvTagDefinition(id: '16', type: EmvDataType.ans, maxLength: 99),
    '17': EmvTagDefinition(id: '17', type: EmvDataType.ans, maxLength: 99),
    '18': EmvTagDefinition(id: '18', type: EmvDataType.ans, maxLength: 99),
    '19': EmvTagDefinition(id: '19', type: EmvDataType.ans, maxLength: 99),
    '20': EmvTagDefinition(id: '20', type: EmvDataType.ans, maxLength: 99),
    '21': EmvTagDefinition(id: '21', type: EmvDataType.ans, maxLength: 99),
    '22': EmvTagDefinition(id: '22', type: EmvDataType.ans, maxLength: 99),
    '23': EmvTagDefinition(id: '23', type: EmvDataType.ans, maxLength: 99),
    '24': EmvTagDefinition(id: '24', type: EmvDataType.ans, maxLength: 99),
    '25': EmvTagDefinition(id: '25', type: EmvDataType.ans, maxLength: 99),
    '26': EmvTagDefinition(id: '26', type: EmvDataType.ans, maxLength: 99),
    '27': EmvTagDefinition(id: '27', type: EmvDataType.ans, maxLength: 99),
    '28': EmvTagDefinition(id: '28', type: EmvDataType.ans, maxLength: 99),
    '29': EmvTagDefinition(id: '29', type: EmvDataType.ans, maxLength: 99),
    '30': EmvTagDefinition(id: '30', type: EmvDataType.ans, maxLength: 99),
    '31': EmvTagDefinition(id: '31', type: EmvDataType.ans, maxLength: 99),
  },

  // ID 62: Additional Data Field Template
  '62': {
    '01': EmvTagDefinition(
      id: '01',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Bill Number
    '02': EmvTagDefinition(
      id: '02',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Mobile Number
    '03': EmvTagDefinition(
      id: '03',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Store Label
    '04': EmvTagDefinition(
      id: '04',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Loyalty Number
    '05': EmvTagDefinition(
      id: '05',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Reference Label
    '06': EmvTagDefinition(
      id: '06',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Customer Label
    '07': EmvTagDefinition(
      id: '07',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Terminal Label
    '08': EmvTagDefinition(
      id: '08',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Purpose of Transaction
    '09': EmvTagDefinition(
      id: '09',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Additional Consumer Data Request
    '10': EmvTagDefinition(
      id: '10',
      type: EmvDataType.alphanumeric,
      maxLength: 20,
    ), // Merchant Tax ID
    '11': EmvTagDefinition(
      id: '11',
      type: EmvDataType.numeric,
      minLength: 3,
      maxLength: 3,
    ), // Merchant Channel
  },

  // ID 64: Merchant Information Language Template
  '64': {
    '00': EmvTagDefinition(
      id: '00',
      type: EmvDataType.alphanumeric,
      minLength: 2,
      maxLength: 5,
    ), // Language Preference
    '01': EmvTagDefinition(
      id: '01',
      type: EmvDataType.ans,
      maxLength: 25,
    ), // Merchant Name (Alternate)
    '02': EmvTagDefinition(
      id: '02',
      type: EmvDataType.ans,
      maxLength: 15,
    ), // Merchant City (Alternate)
  },

  // ID 80: Merchant Premises Location
  '80': {
    '01': EmvTagDefinition(
      id: '01',
      type: EmvDataType.numeric,
      minLength: 2,
      maxLength: 2,
    ), // Location Data Provider
    '02': EmvTagDefinition(
      id: '02',
      type: EmvDataType.string,
      maxLength: 99,
    ), // Location Data
    '03': EmvTagDefinition(
      id: '03',
      type: EmvDataType.numeric,
      maxLength: 99,
    ), // Location Accuracy
  },

  // ID 81: Merchant USSD Information
  '81': {
    '00': EmvTagDefinition(
      id: '00',
      type: EmvDataType.ans,
      maxLength: 32,
    ), // Globally Unique Identifier
    // Payment Network Specific Data (sub-tags 01 and beyond)
    '01': EmvTagDefinition(id: '01', type: EmvDataType.ans, maxLength: 99),
    '02': EmvTagDefinition(id: '02', type: EmvDataType.ans, maxLength: 99),
    '03': EmvTagDefinition(id: '03', type: EmvDataType.ans, maxLength: 99),
    '04': EmvTagDefinition(id: '04', type: EmvDataType.ans, maxLength: 99),
    '05': EmvTagDefinition(id: '05', type: EmvDataType.ans, maxLength: 99),
    '06': EmvTagDefinition(id: '06', type: EmvDataType.ans, maxLength: 99),
    '07': EmvTagDefinition(id: '07', type: EmvDataType.ans, maxLength: 99),
    '08': EmvTagDefinition(id: '08', type: EmvDataType.ans, maxLength: 99),
    '09': EmvTagDefinition(id: '09', type: EmvDataType.ans, maxLength: 99),
    '10': EmvTagDefinition(id: '10', type: EmvDataType.ans, maxLength: 99),
    '11': EmvTagDefinition(id: '11', type: EmvDataType.ans, maxLength: 99),
    '12': EmvTagDefinition(id: '12', type: EmvDataType.ans, maxLength: 99),
    '13': EmvTagDefinition(id: '13', type: EmvDataType.ans, maxLength: 99),
    '14': EmvTagDefinition(id: '14', type: EmvDataType.ans, maxLength: 99),
    '15': EmvTagDefinition(id: '15', type: EmvDataType.ans, maxLength: 99),
    '16': EmvTagDefinition(id: '16', type: EmvDataType.ans, maxLength: 99),
    '17': EmvTagDefinition(id: '17', type: EmvDataType.ans, maxLength: 99),
    '18': EmvTagDefinition(id: '18', type: EmvDataType.ans, maxLength: 99),
    '19': EmvTagDefinition(id: '19', type: EmvDataType.ans, maxLength: 99),
    '20': EmvTagDefinition(id: '20', type: EmvDataType.ans, maxLength: 99),
    '21': EmvTagDefinition(id: '21', type: EmvDataType.ans, maxLength: 99),
    '22': EmvTagDefinition(id: '22', type: EmvDataType.ans, maxLength: 99),
    '23': EmvTagDefinition(id: '23', type: EmvDataType.ans, maxLength: 99),
    '24': EmvTagDefinition(id: '24', type: EmvDataType.ans, maxLength: 99),
    '25': EmvTagDefinition(id: '25', type: EmvDataType.ans, maxLength: 99),
    '26': EmvTagDefinition(id: '26', type: EmvDataType.ans, maxLength: 99),
    '27': EmvTagDefinition(id: '27', type: EmvDataType.ans, maxLength: 99),
    '28': EmvTagDefinition(id: '28', type: EmvDataType.ans, maxLength: 99),
    '29': EmvTagDefinition(id: '29', type: EmvDataType.ans, maxLength: 99),
    '30': EmvTagDefinition(id: '30', type: EmvDataType.ans, maxLength: 99),
    '31': EmvTagDefinition(id: '31', type: EmvDataType.ans, maxLength: 99),
  },

  // ID 82: QR Timestamp Information
  '82': {
    '00': EmvTagDefinition(
      id: '00',
      type: EmvDataType.ans,
      maxLength: 32,
    ), // Globally Unique Identifier
    // Timestamp data can be ans (e.g., specific date/time formats)
    '01': EmvTagDefinition(id: '01', type: EmvDataType.ans, maxLength: 99),
    '02': EmvTagDefinition(id: '02', type: EmvDataType.ans, maxLength: 99),
    // ... potentially more timestamp sub-tags
  },

  // IDs 84-99: Additional Unreserved Templates
  // Each of these can contain sub-tags, similar to Merchant Account Information
  'additionalTemplates': {
    '00': EmvTagDefinition(
      id: '00',
      type: EmvDataType.ans,
      maxLength: 32,
    ), // Globally Unique Identifier
    // Generic sub-tags for templates
    '01': EmvTagDefinition(id: '01', type: EmvDataType.ans, maxLength: 99),
    '02': EmvTagDefinition(id: '02', type: EmvDataType.ans, maxLength: 99),
    // ... up to '99'
  },
};
