import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class BooleanTween extends StatefulWidget {
  ///It is an AnimatedBuilder.
  ///If it is TRUE, it will execute the Tween from begin to end
  ///(controller.forward()),
  ///if it is FALSE it will execute the Tween from end to begin (controller.reverse())
  BooleanTween(
      {Key key,
      @required this.animate,
      @required this.tween,
      @required this.builder,
      Duration duration,
      this.curve = Curves.linear})
      : this.duration = duration ?? Duration(milliseconds: 200),
        super(key: key);

  ///If it is TRUE, it will execute the Tween from begin to end.
  ///
  ///If it is FALSE it will execute the Tween from end to begin
  final bool animate;

  /// It is the time it takes to execute the animation from beginning to end or vice versa.
  final Duration duration;

  ///Es el tipo de interpolación que llevará acabo
  final Tween<dynamic> tween;

  /// Return a Widget and receive the interpolation value as a parameter.
  final Widget Function(dynamic value) builder;

  /// It is the curve that will carry out the interpolation.
  final Curve curve;

  @override
  BooleanTweenState createState() => BooleanTweenState();
}

class BooleanTweenState extends State<BooleanTween>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<dynamic> _animation;

  //Change the tween
  set changeTween(Tween<dynamic> tween) {
    setState(() {
      _animation = tween.animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
    });
  }

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = widget.tween.animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    widget.animate ? _controller.forward() : _controller.reverse();
    super.initState();
  }

  @override
  void didUpdateWidget(BooleanTween oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.animate && widget.animate)
      _controller.forward();
    else if (oldWidget.animate && !widget.animate) _controller.reverse();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => widget.builder(_animation.value),
    );
  }
}

class OpacityTransition extends StatefulWidget {
  /// It is a FadeTransition but this will be shown when receiving a Boolean value.
  OpacityTransition({
    Key key,
    @required this.visible,
    @required this.child,
    Duration duration,
    this.curve = Curves.linear,
  })  : this.duration = duration ?? Duration(milliseconds: 200),
        super(key: key);

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
    return BooleanTween(
      curve: widget.curve,
      animate: widget.visible,
      duration: widget.duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (opacity) {
        return Opacity(
          opacity: opacity,
          child: opacity > 0.0 ? widget.child : null,
        );
      },
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
  SwipeTransition({
    Key key,
    @required this.visible,
    @required this.child,
    Duration duration,
    this.curve = Curves.ease,
    this.direction = SwipeDirection.fromBottom,
  })  : this.duration = duration ?? Duration(milliseconds: 400),
        super(key: key);

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
  GlobalKey<BooleanTweenState> tweenKey = GlobalKey<BooleanTweenState>();
  Offset direction = Offset.zero;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    Misc.onLayoutRendered(() {
      setState(() {
        Size size = GetKey.size(key);
        switch (widget.direction) {
          case SwipeDirection.fromTop:
            direction = Offset(0.0, -size.height);
            break;
          case SwipeDirection.fromLeft:
            direction = Offset(-size.width, 0.0);
            break;
          case SwipeDirection.fromRight:
            direction = Offset(size.width, 0.0);
            break;
          case SwipeDirection.fromBottom:
            direction = Offset(0.0, size.height);
            break;
        }
        tweenKey.currentState.changeTween = createTween();
      });
    });
  }

  Tween createTween() => Tween<Offset>(begin: direction, end: Offset.zero);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BooleanTween(
        key: tweenKey,
        tween: createTween(),
        curve: widget.curve,
        animate: widget.visible,
        duration: widget.duration,
        builder: (value) {
          return Transform.translate(
            offset: value,
            child: Container(key: key, child: widget.child),
          );
        },
      ),
    );
  }
}

class TurnTransition extends StatefulWidget {
  /// It is a RotationTransition but this will be animate when receiving a Boolean value.
  TurnTransition({
    Key key,
    @required this.turn,
    @required this.child,
    this.begin = 90,
    this.end = -90,
    this.curve = Curves.ease,
    Duration duration,
  })  : this.duration = duration ?? Duration(milliseconds: 200),
        super(key: key);

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
    return BooleanTween(
      duration: widget.duration,
      animate: widget.turn,
      curve: widget.curve,
      tween: Tween<double>(
        begin: widget.begin * degrees2radians,
        end: widget.end * degrees2radians,
      ),
      builder: (value) => Transform.rotate(
        angle: value,
        child: widget.child,
      ),
    );
  }
}
