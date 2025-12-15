enum PointOfInitiationMethod {
  /// Indicates a static QR code.
  staticMethod('11'),

  /// Indicates a dynamic QR code.
  dynamicMethod('12');

  final String value;

  const PointOfInitiationMethod(this.value);

  /// Returns the [PointOfInitiationMethod] corresponding to the given [value].
  ///
  /// Throws an [ArgumentError] if no matching method is found.
  factory PointOfInitiationMethod.fromValue(String value) {
    return PointOfInitiationMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () =>
          throw ArgumentError('Unknown PointOfInitiationMethod value: $value'),
    );
  }
}
