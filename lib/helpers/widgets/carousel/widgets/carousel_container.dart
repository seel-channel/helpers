import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({
    Key? key,
    required this.carousel,
    this.aspectRatio,
    this.height,
    this.padding,
  }) : super(key: key);

  final Widget Function(double viewportFraction) carousel;
  final double? aspectRatio;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final BuildMedia media = context.media;
    final double width = media.width;
    final double viewportFraction =
        (width - (padding?.horizontal ?? 0)) / width;

    return SizedBox(
      width: width,
      height: height ??
          (aspectRatio != null
              ? ((width / aspectRatio!) * viewportFraction)
              : null),
      child: OverflowBox(
        maxWidth: width,
        child: carousel(viewportFraction),
      ),
    );
  }
}
