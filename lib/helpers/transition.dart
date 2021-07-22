import 'dart:math' as math;
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';

class BooleanTween<T> extends StatefulWidget {
  ///It is an AnimatedBuilder.
  ///If it is TRUE, it will execute the Tween from begin to end
  ///(controller.forward()),
  ///if it is FALSE it will execute the Tween from end to begin (controller.reverse())
  const BooleanTween({
    Key? key,
    required this.animate,
    required this.tween,
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

  ///Es el tipo de interpolación que llevará acabo
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
      curve: widget.curve,
      animate: widget.visible,
      duration: widget.duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, opacity, child) => Opacity(
        opacity: opacity,
        child: opacity > 0.0 ? child : null,
      ),
      child: widget.child,
    );
  }
}

enum SwipeDirection { fromTop, fromLeft, fromRight, fromBottom }

class SwipeTransition extends StatefulWidget {
  /// It is a type of transition very similar to SlideTransition.
  /// The SwipeTransition fixes the problem that arises in the SlideTransition since
  /// always hides the elements on the screen and not on the parent widget,
  /// that is, if you performed the effect inside a 100x100 container the child widget
  /// of the SwipeTransition would pop out of the container and be overexposed on top of its other widgets.
  const SwipeTransition({
    Key? key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.ease,
    this.direction = SwipeDirection.fromBottom,
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

  /// It is in the address where the Widget will be hidden or where the widget will be displayed.
  final SwipeDirection direction;

  @override
  _SwipeTransitionState createState() => _SwipeTransitionState();
}

class _SwipeTransitionState extends State<SwipeTransition> {
  final _tweenKey = GlobalKey<_BooleanTweenState<Offset>>();
  final _containerKey = GlobalKey();
  SwipeDirection? _swipeDirection;
  Offset _direction = Offset.zero;
  Size? _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _changeData();
  }

  @override
  void didUpdateWidget(SwipeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _changeData();
  }

  void _changeData() {
    Misc.onLayoutRendered(() {
      final Size? size = _containerKey.size;
      if (size != null &&
          (_swipeDirection != widget.direction || _size != size)) {
        setState(() {
          _size = size;
          _swipeDirection = widget.direction;
          switch (widget.direction) {
            case SwipeDirection.fromTop:
              _direction = Offset(0.0, -size.height);
              break;
            case SwipeDirection.fromLeft:
              _direction = Offset(-size.width, 0.0);
              break;
            case SwipeDirection.fromRight:
              _direction = Offset(size.width, 0.0);
              break;
            case SwipeDirection.fromBottom:
              _direction = Offset(0.0, size.height);
              break;
          }
          _tweenKey.state!.changeTween(_createTween());
        });
      }
    });
  }

  Tween<Offset> _createTween() =>
      Tween<Offset>(begin: _direction, end: Offset.zero);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BooleanTween<Offset>(
        key: _tweenKey,
        tween: _createTween(),
        curve: widget.curve,
        animate: widget.visible,
        duration: widget.duration,
        builder: (_, value, child) => Transform.translate(
          offset: value,
          child: child,
        ),
        child: Container(key: _containerKey, child: widget.child),
      ),
    );
  }
}

class TurnTransition extends StatefulWidget {
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
  _TurnTransitionState createState() => _TurnTransitionState();
}

class _TurnTransitionState extends State<TurnTransition> {
  @override
  Widget build(BuildContext context) {
    final double degrees2radians = math.pi / 180.0;
    return BooleanTween<double>(
      duration: widget.duration,
      animate: widget.turn,
      curve: widget.curve,
      tween: Tween<double>(
        begin: widget.begin * degrees2radians,
        end: widget.end * degrees2radians,
      ),
      builder: (_, angle, child) => Transform.rotate(
        angle: angle,
        child: child,
      ),
      child: widget.child,
    );
  }
}
