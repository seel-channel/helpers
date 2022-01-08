import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

enum _SlidingBottomSheetFocusType { sliver, panel }

class SlidingBottomSheetController {
  _SlidingBottomSheetState? _panelState;

  bool get isAttached => _panelState != null;

  void dispose() => _panelState = null;

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
    this.controller,
    this.isDraggable = true,
    Color? backgroundColor,
    this.backgroundBlur = 0.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.decelerate,
    this.onPanelOpened,
    this.onPanelClosed,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.reversedCurve,
    this.onPanelSlide,
    this.constraints,
    this.resizeToAvoidBottomInset,
    this.scrollController,
    this.onSizeChanged,
  })  : backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.2),
        super(key: key);

  ///Provides a [ScrollController] to attach to a scrollable
  ///object in the panel that links the panel position with the scroll position.
  ///Useful for implementing an infinite scroll behavior.
  final Widget Function(BuildContext, ScrollController) builder;

  /// If non-null, this callback
  /// is called as the panel slides around with the
  /// current position of the panel. The position is a double
  /// between 0.0 and 1.0 where 0.0 is fully collapsed and 1.0 is fully open.
  final void Function(double position)? onPanelSlide;

  final Function(double height)? onSizeChanged;

  ///Creates an image filter that applies a Gaussian blur.
  final double backgroundBlur;

  ///The color to paint behind the [builder].
  ///
  ///Default:
  ///```dart
  ///Colors.black.withOpacity(0.2)
  ///```
  final Color backgroundColor;

  final BoxConstraints? constraints;

  ///Creates an animation controller. This controller allows move the panel.
  ///
  ///```dart
  /////Example: Close the panel
  ///await controller.close();
  ///```
  final SlidingBottomSheetController? controller;

  ///Creates a curved animation. The curve to use in the forward and reverse direction.
  final Curve curve;

  ///[duration] is the length of time this animation should last.
  final Duration duration;

  ///Allows toggling of the draggability of the SlidingUpPanel.
  ///Set this to false to prevent the user from being able to drag the panel up and down. Defaults to true
  final bool isDraggable;

  final double lowerBound;

  /// If non-null, this callback is called when the panel
  /// is fully collapsed.
  final VoidCallback? onPanelClosed;

  /// If non-null, this callback is called when the
  /// panel is fully opened
  final VoidCallback? onPanelOpened;

  final bool? resizeToAvoidBottomInset;
  final Curve? reversedCurve;
  final ScrollController? scrollController;
  final double upperBound;

  @override
  _SlidingBottomSheetState createState() => _SlidingBottomSheetState();
}

class _SlidingBottomSheetState extends State<SlidingBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _builderHeight = 1500.0;
  bool _canScroll = true;
  _SlidingBottomSheetFocusType _focusType = _SlidingBottomSheetFocusType.panel;
  Offset _initialPointerPosition = Offset.zero;
  final GlobalKey _key = GlobalKey();
  late ScrollController _scrollController;
  final VelocityTracker _tracker = VelocityTracker.withKind(
    PointerDeviceKind.unknown,
  );

  @override
  void dispose() {
    if (widget.scrollController != null) _scrollController.dispose();
    if (_hasCallbacks) {
      _animationController.removeListener(_animationControllerListener);
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    _animationController = AnimationController(
      vsync: this,
      upperBound: widget.upperBound,
      lowerBound: widget.lowerBound,
    );
    widget.controller?._panelState = this;
    Misc.onLayoutRendered(() {
      _updateDimensions();
      _openPanel();
    });
    if (_hasCallbacks) {
      _animationController.addListener(_animationControllerListener);
    }
    super.initState();
  }

  bool get _atTopEdge {
    try {
      return _scrollController.offset <= 0;
    } catch (_) {
      return false;
    }
  }

  //---------//
  //DIMESIONS//
  //---------//
  void _updateDimensions() {
    final double? height = _key.height;
    if (mounted && height != null) {
      widget.onSizeChanged?.call(height);
      setState(() => _builderHeight = height);
    }
  }

  bool _onSizeChangeNotification(SizeChangedLayoutNotification notification) {
    Misc.delayed(300, _updateDimensions);
    return true;
  }

  //--------//
  //GESTURES//
  //--------//
  void _onVerticalDragUpdate(PointerMoveEvent details) {
    final bool toBottom = details.localPosition.dy > _initialPointerPosition.dy;
    if (_atTopEdge) {
      if (toBottom && _focusType == _SlidingBottomSheetFocusType.panel) {
        _canScroll = true;
      }
    } else {
      _focusType = _SlidingBottomSheetFocusType.sliver;
      _canScroll = false;
    }
    if (_canScroll) {
      if (toBottom) _scrollController.jumpTo(0);
      _animateDragUpdate(details);
    }
  }

  void _animateDragUpdate(PointerMoveEvent details) {
    final Offset delta = details.localDelta;
    _tracker.addPosition(details.timeStamp, details.position);
    _animationController.value -= delta.dy / _builderHeight;
  }

  void _onVerticalDragEnd(PointerUpEvent details) {
    if (_atTopEdge) {
      _focusType = _SlidingBottomSheetFocusType.panel;
    } else {
      _focusType = _SlidingBottomSheetFocusType.sliver;
    }
    if (_canScroll) _animateDragEnd(details);
  }

  void _onVerticalDragStart(PointerDownEvent details) {
    _initialPointerPosition = details.localPosition;
  }

  void _animateDragEnd(PointerUpEvent details) {
    double velocity =
        -_tracker.getVelocity().pixelsPerSecond.dy / _builderHeight;
    velocity += 1;
    if (velocity > 0 && _animationController.value > 0.55) {
      _openPanel(velocity: velocity);
    } else {
      _closePanel(velocity: velocity);
    }
  }

  bool get _hasCallbacks =>
      widget.onPanelOpened != null &&
      widget.onPanelClosed != null &&
      widget.onPanelSlide != null;

  //----------------//
  //PANEL CONTROLLER//
  //----------------//
  void _animationControllerListener() {
    final double value = _animationController.value;
    if (value == 1.0) {
      widget.onPanelOpened?.call();
    } else if (value == 0.0) {
      widget.onPanelClosed?.call();
    } else {
      widget.onPanelSlide?.call(value);
    }
  }

  Future<void> _openPanel({double? velocity}) =>
      _animateTo(1.0, velocity: velocity);

  Future<void> _closePanel({double? velocity}) async {
    await _animateTo(0.0, reversed: true, velocity: velocity);
    context.navigator.pop();
  }

  Future<void> _animateTo(
    double position, {
    bool reversed = false,
    double? velocity,
  }) async {
    Duration duration = widget.duration;
    if (velocity != null) {
      final int milliseconds = duration.inMilliseconds;
      duration = Duration(
        milliseconds: (milliseconds ~/ velocity.abs()).clamp(1, milliseconds),
      );
    }
    await _animationController.animateTo(
      position,
      curve: reversed ? widget.reversedCurve ?? widget.curve : widget.curve,
      duration: duration,
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
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Listener(
            onPointerDown: _onVerticalDragStart,
            onPointerMove: _animateDragUpdate,
            onPointerUp: _animateDragEnd,
            child: GestureDetector(
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
                    onPointerDown: _onVerticalDragStart,
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
