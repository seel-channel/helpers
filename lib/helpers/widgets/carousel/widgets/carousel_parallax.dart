import 'package:flutter/material.dart';

class CarouselParallax extends StatelessWidget {
  const CarouselParallax({
    Key? key,
    required this.child,
    this.curve = Curves.ease,
    required this.height,
    required this.index,
    this.minScale = 0.64,
    required this.page,
    this.parallaxEffect = false,
  }) : super(key: key);

  final Widget child;
  final Curve curve;
  final double height;
  final int index;
  final double minScale;
  final double? page;
  final bool parallaxEffect;

  @override
  Widget build(BuildContext context) {
    final double itemOffset = (page ?? 0.0) - index;

    final double distortionValue = curve.transform(
      (1 - (itemOffset.abs() * (1 - minScale))).clamp(0.0, 1.0),
    );

    final Widget sizedBox = SizedBox(
      height: distortionValue * height,
      child: child,
    );

    return Transform.scale(
      scale: distortionValue,
      child: parallaxEffect
          ? Align(
              alignment: Alignment(distortionValue, 0.0),
              child: sizedBox,
            )
          : sizedBox,
    );
  }
}
