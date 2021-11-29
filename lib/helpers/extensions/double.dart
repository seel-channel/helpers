extension DoubleHelperExtension on double {
  double get decimals {
    return this - floor();
  }
}

extension DoubleNullExtension on double? {
  double? get decimals {
    final double? value = this;
    return value?.decimals;
  }
}
