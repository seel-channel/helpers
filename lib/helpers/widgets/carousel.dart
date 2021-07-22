import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.controller,
    this.aspectRatio = 1.0,
    this.minScale = 0.68,
    this.onPageChanged,
    this.isInfinite = false,
    this.parallaxEffect = false,
    this.curve = Curves.ease,
    this.scrollDirection = Axis.horizontal,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(int index)? onPageChanged;
  final double aspectRatio;
  final PageController? controller;
  final Curve curve;
  final bool isInfinite;
  final int itemCount;
  final double minScale;
  final bool parallaxEffect;
  final Axis scrollDirection;
  final ScrollPhysics? physics;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  @override
  void didUpdateWidget(covariant Carousel oldWidget) {
    if (oldWidget.controller != widget.controller) _setController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _setController();
    super.initState();
  }

  void _setController() {
    _pageController =
        widget.controller ?? PageController(viewportFraction: 0.9999);
  }

  void _onPageChanged(int index) {
    widget.onPageChanged?.call(index % widget.itemCount);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final Size size = constraints.biggest;
      final double width = size.width * _pageController.viewportFraction;
      final double height = width / widget.aspectRatio;

      return SizedBox(
        height: height,
        width: widget.scrollDirection == Axis.vertical ? width : null,
        child: PageView.builder(
          onPageChanged: _onPageChanged,
          controller: _pageController,
          clipBehavior: Clip.none,
          physics: widget.physics,
          allowImplicitScrolling: true,
          scrollDirection: widget.scrollDirection,
          itemCount: widget.isInfinite ? null : widget.itemCount,
          itemBuilder: (_, int index) {
            final int realIndex = index % widget.itemCount;
            return AnimatedBuilder(
              animation: _pageController,
              builder: (_, Widget? child) {
                late double itemOffset;

                try {
                  itemOffset = (_pageController.page ?? 0.0) - index;
                } catch (_) {
                  itemOffset = 0.0 - index;
                }

                final double distortionValue = widget.curve.transform(
                  (1 - (itemOffset.abs() * (1 - widget.minScale)))
                      .clamp(0.0, 1.0)
                      .toDouble(),
                );

                final Widget sizedBox = SizedBox(
                  height: distortionValue * height,
                  child: child,
                );

                return Transform.scale(
                  scale: distortionValue,
                  child: widget.parallaxEffect
                      ? Align(
                          alignment: Alignment(distortionValue, 0.0),
                          child: sizedBox,
                        )
                      : sizedBox,
                );
              },
              child: widget.itemBuilder(_, realIndex),
            );
          },
        ),
      );
    });
  }
}
