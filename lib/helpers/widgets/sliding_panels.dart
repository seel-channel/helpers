import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';

class SlidingPanelContainer extends StatelessWidget {
  ///Useful for entering content to the SlidingPanelPage [builder]
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
  const SlidingPanelContainer({
    Key? key,
    this.child,
    this.height,
    this.boxShadow,
    this.color = Colors.white,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  })  : this.padding = padding ?? const EdgeInsets.all(20.0),
        this.borderRadius = borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20.0)),
        super(key: key);

  /// The color to paint behind the [child].
  final Color color;

  /// The [child] contained by the container.
  final Widget? child;

  ///Creates a widget that combines common painting, positioning, and sizing widgets.
  ///The height value include the padding.
  final double? height;

  ///A list of shadows cast by this box behind the box.
  ///The shadow follows the [shape] of the box.
  final List<BoxShadow>? boxShadow;

  ///The border radius of the rounded corners.
  ///Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///
  ///Default:
  /// ```dart
  ///const BorderRadius.vertical(top: Radius.circular(20.0))
  /// ```
  final BorderRadius borderRadius;

  ///Empty space to inscribe inside the [decoration].
  ///The [child], if any, is placed inside this padding.
  ///
  ///Default:
  /// ```dart
  ///const EdgeInsets.all(20.0),
  /// ```
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: double.infinity,
        child: child,
        padding: padding,
        decoration: BoxDecoration(boxShadow: boxShadow, color: color),
      ),
    );
  }
}

class SlidingPanel extends StatefulWidget {
  ///Create a SlidingPanel like a AlertDialog.
  ///This widget is similar than [sliding_up_panel](https://pub.dev/packages/sliding_up_panel) package.
  ///
  ///Example:
  ///```dart
  ///context.toTransparentPage(
  ///   SlidingPanelPage(builder: (_, __) => SlidingPanelContainer(...)),
  ///);
  ///```
  SlidingPanel({
    Key? key,
    required this.builder,
    this.chevron = const SlidingPanelChevron(),
    SlidingPanelController? controller,
    this.isDraggable = true,
    Color? backgroundColor,
    this.backgroundBlur = 0.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.decelerate,
    this.onPanelOpened,
    this.onPanelClosed,
    this.onPanelSlide,
  })  : this.controller = controller ?? SlidingPanelController(),
        this.backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.2),
        super(key: key);

  ///Allows toggling of the draggability of the SlidingUpPanel.
  ///Set this to false to prevent the user from being able to drag the panel up and down. Defaults to true
  final bool isDraggable;

  ///The Widget over the [builder]
  final Widget chevron;

  ///The color to paint behind the [builder].
  ///
  ///Default:
  ///```dart
  ///Colors.black.withOpacity(0.2)
  ///```
  final Color backgroundColor;

  ///Creates an image filter that applies a Gaussian blur.
  final double backgroundBlur;

  ///Provides a [ScrollController] to attach to a scrollable
  ///object in the panel that links the panel position with the scroll position.
  ///Useful for implementing an infinite scroll behavior.
  final Widget Function(BuildContext, ScrollController) builder;

  /// If non-null, this callback
  /// is called as the panel slides around with the
  /// current position of the panel. The position is a double
  /// between 0.0 and 1.0 where 0.0 is fully collapsed and 1.0 is fully open.
  final void Function(double position)? onPanelSlide;

  /// If non-null, this callback is called when the
  /// panel is fully opened
  final VoidCallback? onPanelOpened;

  /// If non-null, this callback is called when the panel
  /// is fully collapsed.
  final VoidCallback? onPanelClosed;

  ///Creates an animation controller. This controller allows move the panel.
  ///
  ///```dart
  /////Example: Close the panel
  ///await controller.close();
  ///```
  final SlidingPanelController controller;

  ///[duration] is the length of time this animation should last.
  final Duration duration;

  ///Creates a curved animation. The curve to use in the forward and reverse direction.
  final Curve curve;

  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel>
    with SingleTickerProviderStateMixin {
  static const _defaultBuilderHeight = 1500.0;

  final ScrollController _sc = ScrollController();
  final GlobalKey _key = GlobalKey();

  late AnimationController _controller;
  double _builderHeight = _defaultBuilderHeight;
  VelocityTracker _tracker = VelocityTracker.withKind(
    PointerDeviceKind.unknown,
  );

  bool get _canScroll =>
      widget.isDraggable && _sc.hasClients ? _sc.offset <= 0 : true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_controllerListener);
    widget.controller._addState(this);
    Misc.onLayoutRendered(() {
      setState(() {
        _builderHeight = _key.height ?? _defaultBuilderHeight;
        _openPanel();
      });
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    _sc.dispose();
    super.dispose();
  }

  void _controllerListener() {
    final value = _controller.value;
    if (value == 1.0) {
      widget.onPanelOpened?.call();
    } else if (value == 0.0) {
      widget.onPanelClosed?.call();
    } else {
      widget.onPanelSlide?.call(value);
    }
  }

  void _onVerticalDragUpdate(PointerMoveEvent details) {
    if (_canScroll && !(details.delta.dx > 2 || details.delta.dx < -2)) {
      final dy = details.delta.dy;
      _tracker.addPosition(details.timeStamp, details.position);
      _controller.value -= (dy / _builderHeight);
    }
  }

  void _onVerticalDragEnd(PointerUpEvent details) {
    if (widget.isDraggable) {
      final velocity =
          -_tracker.getVelocity().pixelsPerSecond.dy / _builderHeight;
      if (velocity + 1 > 0.0)
        _openPanel();
      else
        _closePanel();
    }
  }

  Future<void> _openPanel() async => await _animateTo(1.0);
  Future<void> _closePanel() async {
    await _animateTo(0.0);
    context.goBack();
  }

  Future<void> _animateTo(double position) async {
    await _controller.animateTo(
      position,
      curve: widget.curve,
      duration: widget.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _closePanel();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          GestureDetector(
            onTap: _closePanel,
            behavior: HitTestBehavior.opaque,
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, double value, __) {
                final color = widget.backgroundColor;
                final blur = widget.backgroundBlur * value;
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(
                    color: color.withOpacity(color.opacity * value),
                  ),
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              widget.chevron,
              Listener(
                key: _key,
                onPointerMove: _onVerticalDragUpdate,
                onPointerUp: _onVerticalDragEnd,
                child: widget.builder(context, _sc),
              ),
            ]),
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(0.0, (1 - _controller.value) * _builderHeight),
                child: child,
              );
            },
          ),
        ]),
      ),
    );
  }
}

class SlidingPanelChevron extends StatelessWidget {
  const SlidingPanelChevron({Key? key, this.color = Colors.white})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 6,
      margin: Margin.horizontal(20) + Margin.vertical(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: EdgeRadius.all(20),
      ),
    );
  }
}

class SlidingPanelController {
  _SlidingPanelState? _panelState;

  void _addState(_SlidingPanelState panelState) {
    this._panelState = panelState;
  }

  /// Determine if the panelController is attached to an instance
  /// of the SlidingUpPanel (this property must return true before any other
  /// functions can be used)
  bool get isAttached => _panelState != null;

  Future<void> close() {
    assert(isAttached, "PanelController must be attached to a SlidingPanel");
    return _panelState!._closePanel();
  }

  Future<void> open() {
    assert(isAttached, "PanelController must be attached to a SlidingPanel");
    return _panelState!._openPanel();
  }

  ///[position] will be between 0.0 to 1.0
  Future<void> animateTo(double position) {
    assert(isAttached, "PanelController must be attached to a SlidingPanel");
    return _panelState!._animateTo(position);
  }
}
