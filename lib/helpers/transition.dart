import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpers/helpers.dart';

class OnScrollHideContent extends StatefulWidget {
  const OnScrollHideContent({
    Key? key,
    this.onSizeChanged,
    this.onChanged,
    required this.controller,
    required this.child,
    this.floating = true,
    this.forcesToHideAtEdge = true,
    this.hideContent = true,
    this.offsetToHideButton,
    this.onTop = true,
    this.opacity = false,
  }) : super(key: key);

  final void Function(double height)? onSizeChanged;
  final void Function(double height)? onChanged;
  final Widget child;
  final ScrollController controller;
  final bool floating;
  final bool forcesToHideAtEdge;
  final bool hideContent;
  final double? offsetToHideButton;
  final bool onTop;
  final bool opacity;

  @override
  _OnScrollHideContentState createState() => _OnScrollHideContentState();
}

class _OnScrollHideContentState extends State<OnScrollHideContent> {
  double _buttonHeight = 240;
  final GlobalKey _buttonKey = GlobalKey();
  final ValueNotifier<double> _buttonPosition = ValueNotifier<double>(0.0);
  double _buttonPositionRef = 0;
  double _offsetRef = 0;
  late ScrollController _scrollController;
  bool _upping = false;

  @override
  void dispose() {
    _buttonPosition.dispose();
    if (widget.hideContent) {
      _scrollController.removeListener(_controllerListener);
    }
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = widget.controller;
    if (widget.hideContent) _scrollController.addListener(_controllerListener);
    Misc.onLayoutRendered(_assingPositions);
    super.initState();
  }

  void _assingPositions() {
    final double? height = _buttonKey.height;
    if (height != null) {
      _buttonHeight = height;
      widget.onSizeChanged?.call(height);
      _buttonPositionRef = height;
      _buttonPosition.value = height;
      if (mounted) setState(() {});
    }
  }

  void _controllerListener() {
    final ScrollPosition position = _scrollController.position;
    final ScrollDirection direction = position.userScrollDirection;
    final double pixels = position.pixels;

    if (widget.forcesToHideAtEdge) {
      if (pixels <= position.minScrollExtent) {
        _buttonPosition.value = _buttonHeight;
        _updateRefs();
        _updateHeight(_buttonHeight);
        return;
      } else if (pixels >= position.maxScrollExtent) {
        _buttonPosition.value = 0;
        _updateRefs();
        _updateHeight(0);
        return;
      }
    }
    if (widget.floating) {
      if (direction == ScrollDirection.forward) {
        if (!_upping) _updateRefs();
        _updateHeight(_buttonHeight);
        //UPPING
      }
      if (direction == ScrollDirection.reverse) {
        if (_upping) _updateRefs();
        _updateHeight(0.0);
        //DOWNING
      }
    } else {
      _buttonPosition.value =
          (_buttonHeight - pixels).clamp(0.0, _buttonHeight);
      widget.onChanged?.call(_buttonPosition.value);
    }
  }

  void _updateRefs() {
    _upping = !_upping;
    _offsetRef = _scrollController.offset;
    _buttonPositionRef = _buttonPosition.value;
  }

  void _updateHeight(double to) {
    final double offset = _scrollController.offset;
    final double toHide = widget.offsetToHideButton ?? _buttonHeight;
    final double lerp = ((_offsetRef - offset) / toHide).abs();

    _buttonPosition.value =
        Misc.lerpDouble(_buttonPositionRef, to, lerp <= 1.0 ? lerp : 1.0);
    widget.onChanged?.call(_buttonPosition.value);
  }

  bool _onSizeChangeNotification(SizeChangedLayoutNotification notification) {
    Misc.delayed(300, _assingPositions);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onSizeChangeNotification,
      child: SizeChangedLayoutNotifier(
        key: _buttonKey,
        child: ValueListenableBuilder(
          valueListenable: _buttonPosition,
          builder: (_, double value, Widget? child) {
            final offset =
                widget.onTop ? value - _buttonHeight : _buttonHeight - value;
            final double opacity = (offset / _buttonHeight).clamp(0, 1);
            final Widget transform = Transform.translate(
              offset: Offset(0.0, offset),
              child: child,
            );
            return widget.opacity
                ? Opacity(opacity: opacity, child: transform)
                : transform;
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class TimerPeriodicBuilder extends StatefulWidget {
  const TimerPeriodicBuilder({
    Key? key,
    this.duration = const Duration(seconds: 1),
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  TimerPeriodicBuilderState createState() => TimerPeriodicBuilderState();
}

class TimerPeriodicBuilderState extends State<TimerPeriodicBuilder> {
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _timer = Timer.periodic(widget.duration, (_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

class BooleanTween<T> extends StatefulWidget {
  ///It is an AnimatedBuilder.
  ///If it is TRUE, it will execute the Tween from begin to end
  ///(controller.forward()),
  ///if it is FALSE it will execute the Tween from end to begin (controller.reverse())
  const BooleanTween({
    Key? key,
    required this.animate,
    required this.builder,
    this.child,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    this.reverseCurve,
    this.reverseDuration,
    required this.tween,
  }) : super(key: key);

  ///If it is **TRUE**, it will execute the Tween from begin to end.
  ///
  ///If it is **FALSE** it will execute the Tween from end to begin
  final bool animate;

  ///Called every time the animation changes value.
  ///Return a Widget and receive the interpolation value as a parameter.
  final ValueWidgetBuilder<T> builder;

  final Widget? child;

  /// It is the curve that will carry out the interpolation.
  final Curve curve;

  /// It is the time it takes to execute the animation from beginning to end or vice versa.

  final Duration duration;

  /// It is the curve that will carry out the interpolation.
  final Curve? reverseCurve;

  /// It is the time it takes to execute the animation from beginning to end or vice versa.
  final Duration? reverseDuration;

  /// A linear interpolation between a beginning and ending value.
  ///
  /// [Tween] is useful if you want to interpolate across a range.
  ///
  ///You should use `LerpTween()` instead `Tween<double>(begin: 0.0, end: 1.0)`
  final Tween<T> tween;

  @override
  _BooleanTweenState<T> createState() => _BooleanTweenState<T>();
}

class _BooleanTweenState<T> extends State<BooleanTween<T>>
    with SingleTickerProviderStateMixin {
  late Animation<T> _animation;
  late AnimationController _controller;

  @override
  void didUpdateWidget(BooleanTween oldWidget) {
    super.didUpdateWidget(oldWidget as BooleanTween<T>);
    if (!oldWidget.animate && widget.animate) {
      _controller.forward();
    } else if (oldWidget.animate && !widget.animate) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      value: widget.animate ? 1.0 : 0.0,
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );
    _animation = widget.tween.animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => widget.builder(
        context,
        _animation.value,
        child,
      ),
      child: widget.child,
    );
  }
}

class OpacityTransition extends StatefulWidget {
  /// It is a FadeTransition but this will be shown when receiving a Boolean value.
  const OpacityTransition({
    Key? key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  }) : super(key: key);

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// Is the time it takes to make the transition.
  final Duration duration;

  /// If true, it will show the widget.
  /// If false, it will hide the widget.
  final bool visible;

  @override
  _OpacityTransitionState createState() => _OpacityTransitionState();
}

class _OpacityTransitionState extends State<OpacityTransition> {
  @override
  Widget build(BuildContext context) {
    return BooleanTween<double>(
      tween: LerpTween(),
      animate: widget.visible,
      curve: widget.curve,
      duration: widget.duration,
      builder: (_, opacity, child) => Opacity(
        opacity: opacity,
        child: opacity > 0.0 ? child : null,
      ),
      child: widget.child,
    );
  }
}

class SwipeTransition extends StatelessWidget {
  /// It is a type of transition very similar to SizeTransition.
  /// The SwipeTransition fixes the problem that arises in the SlideTransition since
  /// always hides the elements on the screen and not on the parent widget,
  /// that is, if you performed the effect inside a 100x100 container the child widget
  /// of the SwipeTransition would pop out of the container and be overexposed on top of its other widgets.
  const SwipeTransition({
    Key? key,
    this.axis = Axis.vertical,
    this.axisAlignment = -1.0,
    required this.child,
    this.clip = Clip.antiAlias,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 200),
    this.reverseCurve,
    this.reverseDuration,
    required this.visible,
  }) : super(key: key);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  final Clip clip;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// Is the time it takes to make the transition.
  final Duration duration;

  /// It is the curve that the SwipeTransition performs
  final Curve? reverseCurve;

  /// Is the time it takes to make the transition.
  final Duration? reverseDuration;

  /// If true, it will show the widget in its position.
  /// If false, it will hide the widget.
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final swipper = BooleanTween<double>(
      tween: LerpTween(),
      curve: curve,
      animate: visible,
      duration: duration,
      reverseCurve: reverseCurve,
      reverseDuration: reverseDuration,
      builder: (_, lerp, ___) => AlignFactor(
        axisAlignment: axisAlignment,
        lerp: lerp,
        axis: axis,
        child: child,
      ),
    );
    return clip == Clip.none
        ? swipper
        : ClipRRect(clipBehavior: clip, child: swipper);
  }
}

class AlignFactor extends StatelessWidget {
  const AlignFactor({
    Key? key,
    required this.lerp,
    this.axis = Axis.vertical,
    this.axisAlignment = -1.0,
    required this.child,
  }) : super(key: key);

  final Axis axis;
  final double axisAlignment;
  final Widget child;
  final double lerp;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }

    return Align(
      alignment: alignment,
      heightFactor: axis == Axis.vertical ? math.max(lerp, 0.0) : null,
      widthFactor: axis == Axis.horizontal ? math.max(lerp, 0.0) : null,
      child: child,
    );
  }
}

class TranslateTransition extends StatelessWidget {
  /// It is a type of transition very similar to SlideTransition.
  const TranslateTransition({
    Key? key,
    this.begin = const Offset(0, 1),
    required this.child,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 200),
    this.end = Offset.zero,
    this.textDirection,
    this.transformHitTests = true,
    required this.visible,
  }) : super(key: key);

  /// If true, it will show the widget in its position.
  /// If false, it will hide the widget.
  final Offset begin;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// Is the time it takes to make the transition.
  final Duration duration;

  final Offset end;

  /// The direction to use for the x offset described by the [position].
  ///
  /// If [textDirection] is null, the x offset is applied in the coordinate
  /// system of the canvas (so positive x offsets move the child towards the
  /// right).
  ///
  /// If [textDirection] is [TextDirection.rtl], the x offset is applied in the
  /// reading direction such that x offsets move the child towards the left.
  ///
  /// If [textDirection] is [TextDirection.ltr], the x offset is applied in the
  /// reading direction such that x offsets move the child towards the right.
  final TextDirection? textDirection;

  /// Whether hit testing should be affected by the slide animation.
  ///
  /// If false, hit testing will proceed as if the child was not translated at
  /// all. Setting this value to false is useful for fast animations where you
  /// expect the user to commonly interact with the child widget in its final
  /// location and you want the user to benefit from "muscle memory".
  final bool transformHitTests;

  /// If true, it will show the widget in its position.
  /// If false, it will hide the widget.
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return BooleanTween<Offset>(
      tween: Tween(begin: begin, end: end),
      curve: curve,
      animate: visible,
      duration: duration,
      builder: (_, offset, ___) {
        return FractionalTranslation(
          translation: textDirection == TextDirection.rtl
              ? Offset(-offset.dx, offset.dy)
              : offset,
          transformHitTests: transformHitTests,
          child: child,
        );
      },
    );
  }
}

class TurnTransition extends StatelessWidget {
  /// It is a RotationTransition but this will be animate when receiving a Boolean value.
  const TurnTransition({
    Key? key,
    required this.turn,
    required this.child,
    this.begin = 90,
    this.end = -90,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  ///BEGIN DEGREES (RANGE IS 0 - 359)
  final double begin;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// Is the time it takes to make the transition.
  final Duration duration;

  ///END DEGREES (RANGE IS 0 - 359)
  final double end;

  ///**If** true, animate to end degrees, **else** animate to begin degrees.
  final bool turn;

  @override
  Widget build(BuildContext context) {
    return BooleanTween<double>(
      duration: duration,
      animate: turn,
      curve: curve,
      tween: Tween<double>(
        begin: Misc.degreesToRadians(begin),
        end: Misc.degreesToRadians(end),
      ),
      builder: (_, angle, child) => Transform.rotate(
        angle: angle,
        child: child,
      ),
      child: child,
    );
  }
}
