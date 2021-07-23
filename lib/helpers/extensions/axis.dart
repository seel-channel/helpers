import 'package:flutter/painting.dart';

extension AxisHelperExtension on Axis {
  bool get isHorizontal => this == Axis.horizontal;
  bool get isVertical => this == Axis.vertical;
}
