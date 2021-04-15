import 'package:flutter/material.dart';

extension HexColorHelperExtension on Color {
  /// String is in the format "RRGGBB" or "AARRGGBB" with an optional hash sing "#".
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// **hashSing:**
  ///  - True = #AARRGGBB;
  ///  - False = AARRGGBB
  ///
  /// **alphaValue:**
  ///  - True = #AARRGGBB;
  ///  - False = #RRGGBB
  String toHex({bool hashSing = true, bool alphaValue = false}) =>
      '${hashSing ? '#' : ''}'
      '${alphaValue ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
