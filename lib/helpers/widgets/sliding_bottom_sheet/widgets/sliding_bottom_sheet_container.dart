import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class SlidingBottomSheetContainer extends StatefulWidget {
  ///Useful for entering content to the SlidingBottomSheetPage [builder]
  ///
  /// ```dart
  ///return ClipRRect(
  ///   borderRadius: borderRadius,
  ///   child: Container(
  ///     height: height,
  ///     width: double.infinity,
  ///     child: child,
  ///     padding: padding,
  ///     decoration: BoxDecoration(boxShadow: boxShadow,color: color),
  ///   ),
  ///);
  /// ```
  const SlidingBottomSheetContainer({
    Key? key,
    this.padding = const Margin.all(20.0),
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(20.0)),
    this.margin = const Margin.vertical(20.0),
    this.animatedSizeCurve = Curves.decelerate,
    this.animatedSizeDuration = const Duration(milliseconds: 400),
    this.boxShadow,
    this.chevron = const SlidingBottomSheetChevron(),
    this.child,
    this.children,
    this.color = Colors.white,
    this.controller,
    this.height,
    this.scrollPhysics,
    this.scrollToBottom = true,
    this.clipper,
  }) : super(key: key);

  final Curve animatedSizeCurve;
  final Duration animatedSizeDuration;

  ///The border radius of the rounded corners.
  ///Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///
  ///Default:
  /// ```dart
  ///const BorderRadius.vertical(top: Radius.circular(20.0))
  /// ```
  final BorderRadius borderRadius;

  ///A list of shadows cast by this box behind the box.
  ///The shadow follows the [shape] of the box.
  final List<BoxShadow>? boxShadow;

  ///The Widget over the [builder]
  final Widget? chevron;

  /// The [child] contained by the container.
  final Widget? child;

  final List<Widget>? children;

  /// The color to paint behind the [child].
  final Color color;

  final ScrollController? controller;

  ///Creates a widget that combines common painting, positioning, and sizing widgets.
  ///The height value include the padding.
  final double? height;

  final EdgeInsetsGeometry margin;

  ///Empty space to inscribe inside the [decoration].
  ///The [child], if any, is placed inside this padding.
  ///
  ///Default:
  /// ```dart
  ///const EdgeInsets.all(20.0),
  /// ```
  final EdgeInsetsGeometry padding;

  final ScrollPhysics? scrollPhysics;

  final bool scrollToBottom;

  final Widget Function(BuildContext context, Widget child)? clipper;

  @override
  _SlidingBottomSheetContainerState createState() =>
      _SlidingBottomSheetContainerState();
}

class _SlidingBottomSheetContainerState
    extends State<SlidingBottomSheetContainer> {
  final ValueNotifier<double> _chevronHeight = ValueNotifier(0);
  final GlobalKey _chevronKey = GlobalKey();

  @override
  void dispose() {
    _chevronHeight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Misc.onLayoutRendered(() {
      if (widget.chevron != null) {
        final ScrollController? controller = widget.controller;
        final double? height = _chevronKey.context?.height;
        if (height != null) _chevronHeight.value = height;
        if (widget.scrollToBottom && controller != null) {
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = Stack(children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: SlidingBottomSheetController.of(context).close,
          child: Container(color: Colors.transparent),
        ),
      ),
      Padding(
        padding: widget.margin,
        child: Builder(builder: (context) {
          final Widget card = Container(
            padding: widget.padding,
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
              color: widget.color,
            ),
            child: AnimatedSize(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              curve: widget.animatedSizeCurve,
              duration: widget.animatedSizeDuration,
              reverseDuration: widget.animatedSizeDuration,
              child: widget.child,
            ),
          );
          if (widget.clipper != null) return widget.clipper!(context, card);
          return ClipRRect(borderRadius: widget.borderRadius, child: card);
        }),
      ),
      if (widget.chevron != null)
        TopCenterAlign(
          child: ValueListenableBuilder<double>(
            valueListenable: _chevronHeight,
            builder: (context, value, child) {
              return Transform.translate(
                key: _chevronKey,
                offset: Offset(0, value),
                child: widget.chevron,
              );
            },
          ),
        ),
      if (widget.children != null)
        ...widget.children!.map(
          (e) => Padding(padding: widget.margin, child: e),
        ),
    ]);

    return widget.controller != null
        ? SingleChildScrollView(
            controller: widget.controller,
            physics: widget.scrollPhysics,
            child: child,
          )
        : child;
  }
}
