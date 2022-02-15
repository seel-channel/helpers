import 'package:flutter/material.dart';

extension HSLColorExtension on HSLColor {
  HSLColor withRelativeLightness(double lightness) {
    return withLightness(this.lightness * lightness);
  }
}

extension ColorExtension on Color {
  /// String is in the format "RRGGBB" or "AARRGGBB" with an optional hash sing "#".
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Returns a new color that matches this color with the alpha channel
  /// replaced with the given `opacity` (which ranges from 0.0 to 1.0).
  ///
  /// Out of range values will have unexpected effects.
  Color withRelativeOpacity(double opacity) {
    return withOpacity(this.opacity * opacity);
  }

  Color toComplementary() {
    final HSLColor color = toHSL();
    double hue = color.hue + 180;
    if (hue > 360) hue -= 360;
    return HSLColor.fromAHSL(
      color.alpha,
      hue,
      color.saturation,
      color.lightness,
    ).toColor();
  }

  HSLColor toHSL() => HSLColor.fromColor(this);

  HSVColor toHSV() => HSVColor.fromColor(this);

  /// **hashSing:**
  ///  - true: #AARRGGBB;
  ///  - false: AARRGGBB
  ///
  /// **alphaValue:**
  ///  - true: #AARRGGBB;
  ///  - false: #RRGGBB
  String toHex({bool hashSing = true, bool alphaValue = false}) =>
      '${hashSing ? '#' : ''}'
      '${alphaValue ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
