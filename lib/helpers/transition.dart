import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class BooleanTween<T> extends StatefulWidget {
  ///It is an AnimatedBuilder.
  ///If it is TRUE, it will execute the Tween from begin to end
  ///(controller.forward()),
  ///if it is FALSE it will execute the Tween from end to begin (controller.reverse())
  const BooleanTween({
    Key? key,
    required this.tween,
    required this.animate,
    required this.builder,
    this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  }) : super(key: key);

  ///If it is **TRUE**, it will execute the Tween from begin to end.
  ///
  ///If it is **FALSE** it will execute the Tween from end to begin
  final bool animate;

  /// It is the time it takes to execute the animation from beginning to end or vice versa.
  final Duration duration;

  /// A linear interpolation between a beginning and ending value.
  ///
  /// [Tween] is useful if you want to interpolate across a range.
  ///
  ///You should use `LerpTween()` instead `Tween<double>(begin: 0.0, end: 1.0)`
  final Tween<T> tween;

  ///Called every time the animation changes value.
  ///Return a Widget and receive the interpolation value as a parameter.
  final ValueWidgetBuilder<T> builder;

  final Widget? child;

  /// It is the curve that will carry out the interpolation.
  final Curve curve;

  @override
  _BooleanTweenState<T> createState() => _BooleanTweenState<T>();
}

class _BooleanTweenState<T> extends State<BooleanTween<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<T> _animation;

  //Change the tween
  void changeTween(Tween<T> tween) {
    setState(() {
      _animation = tween.animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.curve,
      ));
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      value: widget.animate ? 1.0 : 0.0,
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );
    _animation = widget.tween.animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.curve,
    ));
    super.initState();
  }

  @override
  void didUpdateWidget(BooleanTween oldWidget) {
    super.didUpdateWidget(oldWidget as BooleanTween<T>);
    if (!oldWidget.animate && widget.animate) {
      _controller.forward();
    } else if (oldWidget.animate && !widget.animate) _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (newContext, child) => widget.builder(
        newContext,
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

  /// If true, it will show the widget.
  /// If false, it will hide the widget.
  final bool visible;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// Is the time it takes to make the transition.
  final Duration duration;

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
  /// It is a type of transition very similar to SlideTransition.
  /// The SwipeTransition fixes the problem that arises in the SlideTransition since
  /// always hides the elements on the screen and not on the parent widget,
  /// that is, if you performed the effect inside a 100x100 container the child widget
  /// of the SwipeTransition would pop out of the container and be overexposed on top of its other widgets.
  const SwipeTransition({
    Key? key,
    required this.visible,
    this.curve = Curves.ease,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.axis = Axis.vertical,
    this.axisAlignment = -1.0,
  }) : super(key: key);

  /// If true, it will show the widget in its position.
  /// If false, it will hide the widget.
  final bool visible;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// Is the time it takes to make the transition.
  final Duration duration;

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

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }

    return ClipRRect(
      child: BooleanTween<double>(
        tween: LerpTween(),
        curve: curve,
        animate: visible,
        duration: duration,
        builder: (_, value, child) => Align(
          alignment: alignment,
          heightFactor: axis == Axis.vertical ? math.max(value, 0.0) : null,
          widthFactor: axis == Axis.horizontal ? math.max(value, 0.0) : null,
          child: value > 0.0 ? child : null,
        ),
        child: child,
      ),
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

  ///**If** true, animate to end degrees, **else** animate to begin degrees.
  final bool turn;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  /// Is the time it takes to make the transition.
  final Duration duration;

  ///BEGIN DEGREES (RANGE IS 0 - 359)
  final double begin;

  ///END DEGREES (RANGE IS 0 - 359)
  final double end;

  @override
  Widget build(BuildContext context) {
    final double degrees2radians = math.pi / 180.0;
    return BooleanTween<double>(
      duration: duration,
      animate: turn,
      curve: curve,
      tween: Tween<double>(
        begin: begin * degrees2radians,
        end: end * degrees2radians,
      ),
      builder: (_, angle, child) => Transform.rotate(
        angle: angle,
        child: child,
      ),
      child: child,
    );
  }
}
