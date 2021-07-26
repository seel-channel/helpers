import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({
    Key? key,
    required this.carousel,
    this.aspectRatio = 1.0,
    this.padding = const Margin.all(0),
  }) : super(key: key);

  final EdgeInsets padding;
  final double aspectRatio;
  final Widget Function(double viewportFraction) carousel;

  @override
  Widget build(BuildContext context) {
    final BuildMedia media = context.media;
    final double width = media.width;
    final double viewportFraction = (width - padding.horizontal) / width;

    return SizedBox(
      width: width,
      height: (width / aspectRatio) * viewportFraction,
      child: OverflowBox(
        maxWidth: width,
        child: carousel(viewportFraction),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  Carousel({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    CarouselController? controller,
    this.minScale = 0.68,
    this.onPageChanged,
    this.isInfinite = false,
    this.parallaxEffect = false,
    this.curve = Curves.ease,
    this.viewportFraction = 1.0,
    this.scrollDirection = Axis.horizontal,
    this.physics = const BouncingScrollPhysics(),
  })  : controller = controller ?? CarouselController(),
        super(key: key);

  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(int index)? onPageChanged;
  final CarouselController controller;
  final Curve curve;
  final bool isInfinite;
  final int itemCount;
  final double minScale;
  final bool parallaxEffect;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final double viewportFraction;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _itemCount = 0;
  late PageController _pageController;

  @override
  void didUpdateWidget(covariant Carousel oldWidget) {
    if (oldWidget.viewportFraction != widget.viewportFraction ||
        oldWidget.itemCount != widget.itemCount) {
      _setController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.controller._addState(this);
    _setController();
    super.initState();
  }

  void _setController() {
    _pageController = PageController(viewportFraction: widget.viewportFraction);
    _itemCount = widget.itemCount;
  }

  void _onPageChanged(int index) {
    widget.onPageChanged?.call(index % widget.itemCount);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final Size size = constraints.biggest;
      final double height = size.height;

      return PageView.builder(
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
      );
    });
  }
}

class CarouselController {
  _CarouselState? _carouselState;

  // ignore: use_setters_to_change_properties
  void _addState(_CarouselState state) => _carouselState = state;

  _CarouselState get _state {
    assert(isAttached);
    return _carouselState!;
  }

  int get itemCount => _state._itemCount;

  bool get isAttached => _carouselState != null;

  int _toRelativePage(int page) => page % itemCount;

  PageController get pageController {
    assert(isAttached);
    return _state._pageController;
  }

  double get page {
    return pageController.page! % itemCount;
  }

  /// Animates the controlled [PageView] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
  }) {
    return pageController.animateToPage(
      _toRelativePage(page),
      duration: duration,
      curve: curve,
    );
  }

  /// Changes which page is displayed in the controlled [PageView].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  void jumpToPage(int page) {
    pageController.jumpToPage(_toRelativePage(page));
  }

  /// Animates the controlled [PageView] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> nextPage({
    required Duration duration,
    required Curve curve,
  }) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  /// Animates the controlled [PageView] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> previousPage({
    required Duration duration,
    required Curve curve,
  }) {
    return pageController.previousPage(duration: duration, curve: curve);
  }
}
