import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class SlidingBottomSheetChevron extends StatelessWidget {
  const SlidingBottomSheetChevron({Key? key, this.color = Colors.white})
      : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 6,
      margin: const Margin.vertical(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: EdgeRadius.all(20),
      ),
    );
  }
}

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
    this.child,
    this.height,
    this.boxShadow,
    this.chevron = const SlidingBottomSheetChevron(),
    this.color = Colors.white,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    this.animatedSizeCurve = Curves.decelerate,
    this.animatedSizeDuration = const Duration(milliseconds: 400),
    this.controller,
    this.scrollPhysics,
    this.scrollBehavior = const RemoveGlowScrollBehavior(),
  })  : padding = padding ?? const EdgeInsets.all(20.0),
        borderRadius = borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20.0)),
        super(key: key);

  /// The color to paint behind the [child].
  final Color color;

  ///The Widget over the [builder]
  final Widget chevron;

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

  final Curve animatedSizeCurve;

  final Duration animatedSizeDuration;

  final ScrollPhysics? scrollPhysics;

  final ScrollBehavior scrollBehavior;

  final ScrollController? controller;

  @override
  _SlidingBottomSheetContainerState createState() =>
      _SlidingBottomSheetContainerState();
}

class _SlidingBottomSheetContainerState
    extends State<SlidingBottomSheetContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Widget child = Column(mainAxisSize: MainAxisSize.min, children: [
      widget.chevron,
      ClipRRect(
        borderRadius: widget.borderRadius,
        child: Container(
          padding: widget.padding,
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: widget.boxShadow,
            color: widget.color,
          ),
          child: AnimatedSize(
            vsync: this,
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            curve: widget.animatedSizeCurve,
            duration: widget.animatedSizeDuration,
            reverseDuration: widget.animatedSizeDuration,
            child: widget.child,
          ),
        ),
      ),
    ]);

    return widget.controller != null
        ? ClipRRect(
            borderRadius: widget.borderRadius,
            child: ScrollConfiguration(
              behavior: widget.scrollBehavior,
              child: SingleChildScrollView(
                controller: widget.controller,
                physics: widget.scrollPhysics,
                child: child,
              ),
            ),
          )
        : child;
  }
}

class RemoveGlowScrollBehavior extends ScrollBehavior {
  const RemoveGlowScrollBehavior();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SlidingBottomSheet extends StatefulWidget {
  ///Create a SlidingBottomSheet like a AlertDialog.
  ///This widget is similar than [sliding_up_panel](https://pub.dev/packages/sliding_up_panel) package.
  ///
  ///Example:
  ///```dart
  ///navigator.pushOpaque(
  ///   SlidingBottomSheetPage(builder: (_, __) => SlidingBottomSheetContainer(...)),
  ///);
  ///```
  SlidingBottomSheet({
    Key? key,
    required this.builder,
    SlidingBottomSheetController? controller,
    this.isDraggable = true,
    Color? backgroundColor,
    this.backgroundBlur = 0.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.decelerate,
    this.onPanelOpened,
    this.onPanelClosed,
    this.onPanelSlide,
    this.constraints,
  })  : controller = controller ?? SlidingBottomSheetController(),
        backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.2),
        super(key: key);

  ///Allows toggling of the draggability of the SlidingUpPanel.
  ///Set this to false to prevent the user from being able to drag the panel up and down. Defaults to true
  final bool isDraggable;

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
  final SlidingBottomSheetController controller;

  ///[duration] is the length of time this animation should last.
  final Duration duration;

  ///Creates a curved animation. The curve to use in the forward and reverse direction.
  final Curve curve;

  final BoxConstraints? constraints;

  @override
  _SlidingBottomSheetState createState() => _SlidingBottomSheetState();
}

class _SlidingBottomSheetState extends State<SlidingBottomSheet>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final VelocityTracker _tracker = VelocityTracker.withKind(
    PointerDeviceKind.unknown,
  );

  late AnimationController _animationController;
  double _builderHeight = 1500.0;

  bool get _canScroll =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      widget.isDraggable && _scrollController.hasClients
          ? _scrollController.offset <= 0
          : true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(_animationControllerListener);
    widget.controller._addState(this);
    Misc.onLayoutRendered(() {
      _updateDimensions();
      _openPanel();
    });
  }

  @override
  void dispose() {
    _animationController.removeListener(_animationControllerListener);
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //---------//
  //DIMESIONS//
  //---------//
  void _updateDimensions() {
    final double? height = _key.height;
    if (mounted && height != null) setState(() => _builderHeight = height);
  }

  bool _onSizeChangeNotification(SizeChangedLayoutNotification notification) {
    Misc.delayed(300, _updateDimensions);
    return true;
  }

  //--------//
  //GESTURES//
  //--------//
  void _onVerticalDragUpdate(PointerMoveEvent details) {
    if (_canScroll && !(details.delta.dx > 2 || details.delta.dx < -2)) {
      final dy = details.delta.dy;
      _tracker.addPosition(details.timeStamp, details.position);
      _animationController.value -= dy / _builderHeight;
    }
  }

  void _onVerticalDragEnd(PointerUpEvent details) {
    if (widget.isDraggable) {
      final velocity =
          -_tracker.getVelocity().pixelsPerSecond.dy / _builderHeight;
      if (velocity + 1 > 0.0) {
        _openPanel();
      } else {
        _closePanel();
      }
    }
  }

  //----------------//
  //PANEL CONTROLLER//
  //----------------//
  void _animationControllerListener() {
    final value = _animationController.value;
    if (value == 1.0) {
      widget.onPanelOpened?.call();
    } else if (value == 0.0) {
      widget.onPanelClosed?.call();
    } else {
      widget.onPanelSlide?.call(value);
    }
  }

  Future<void> _openPanel() => _animateTo(1.0);

  Future<void> _closePanel() async {
    await _animateTo(0.0);
    context.navigator.pop();
  }

  Future<void> _animateTo(double position) async {
    await _animationController.animateTo(
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
              valueListenable: _animationController,
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
          ConstrainedBox(
            constraints: widget.constraints ?? const BoxConstraints(),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (_, final Widget? child) {
                return Transform.translate(
                  offset: Offset(
                    0.0,
                    (1 - _animationController.value) * _builderHeight,
                  ),
                  child: child,
                );
              },
              child: NotificationListener(
                onNotification: _onSizeChangeNotification,
                child: SizeChangedLayoutNotifier(
                  child: Listener(
                    key: _key,
                    onPointerMove: _onVerticalDragUpdate,
                    onPointerUp: _onVerticalDragEnd,
                    child: widget.builder(context, _scrollController),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SlidingBottomSheetController {
  _SlidingBottomSheetState? _panelState;

  // ignore: use_setters_to_change_properties
  void _addState(_SlidingBottomSheetState state) => _panelState = state;

  bool get isAttached => _panelState != null;

  Future<void> close() {
    assert(
        isAttached, "PanelController must be attached to a SlidingBottomSheet");
    return _panelState!._closePanel();
  }

  Future<void> open() {
    assert(
        isAttached, "PanelController must be attached to a SlidingBottomSheet");
    return _panelState!._openPanel();
  }

  ///[position] will be between 0.0 to 1.0
  Future<void> animateTo(double position) {
    assert(
        isAttached, "PanelController must be attached to a SlidingBottomSheet");
    return _panelState!._animateTo(position);
  }
}
