enum EmvDataType {
  numeric,
  alphanumeric,
  string,
  ans, // Alphanumeric Special
  undefined,
}

class EmvTagDefinition {
  final String id;
  final EmvDataType type;
  final int? minLength;
  final int? maxLength;
  final bool mandatory;
  final Pattern? pattern;

  const EmvTagDefinition({
    required this.id,
    required this.type,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.mandatory = false,
  });

  @override
  String toString() {
    return 'EmvTagDefinition(id: $id, type: $type, minLength: $minLength, maxLength: $maxLength, mandatory: $mandatory, pattern: $pattern)';
  }
}
