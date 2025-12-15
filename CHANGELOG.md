## 1.0.0

- Initial version.

## 1.0.1
- Minor formatting

## 1.0.2
- Added strict field validation for all EMV tags according to KE-QR Standard
- Fixed parsing bug where tags 83-99 (Additional Templates) were not being correctly parsed due to incorrect parent tag reference
- Enhanced numeric validation to support decimal points for transaction amount fields (54, 56, 57)
- Updated field type enforcement:
  - ID 00, 01: Changed to numeric type (strict integer)
  - ID 02-51: Changed to string type (composite TLV containers)
  - ID 52, 53, 55: Numeric type (strict integer)
  - ID 54, 56, 57: Numeric type with decimal support
  - ID 59, 60: Changed to ANS type to support spaces and special characters
  - ID 61: Fixed to length 2 as per specification
  - ID 80, 81, 82: Changed to string type (composite TLV containers)

## 1.0.3
- Enumerate point of initiation method
