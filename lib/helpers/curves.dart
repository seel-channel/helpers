import 'dart:math';

import 'package:flutter/material.dart';

class SineCurve extends Curve {
  const SineCurve({this.count = 1});

  final int count;

  @override
  double transformInternal(double t) {
    return sin(count * t * pi);
  }
}
