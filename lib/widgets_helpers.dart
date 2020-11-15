import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class TextDesigned extends StatelessWidget {
  const TextDesigned(
    this.text, {
    Key key,
    this.size = 16,
    this.bold = false,
    this.color,
    this.italic = false,
    this.center = false,
    this.justify = false,
    this.uppercase = false,
    this.underline = false,
    this.letterSpacing = 0,
  }) : super(key: key);

  final Color color;
  final String text;
  final double size, letterSpacing;
  final bool bold, italic, justify, center, uppercase, underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      Misc.ifNull(uppercase ? text.toUpperCase() : text, ""),
      textAlign: justify
          ? TextAlign.justify
          : center
              ? TextAlign.center
              : TextAlign.start,
      style: TextStyle(
        fontSize: size,
        color: Misc.ifNull(
          color,
          Misc.ifNull(Misc.theme(context).primaryColor, Colors.black),
        ),
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

class RemoveScrollGlow extends StatelessWidget {
  const RemoveScrollGlow({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      child: child,
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      },
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  const DismissKeyboard({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
      },
      child: child,
    );
  }
}

class OpacityTransition extends StatefulWidget {
  OpacityTransition({
    Key key,
    @required this.child,
    @required this.visible,
    Duration duration,
    this.curve = Curves.linear,
  })  : this.duration = duration ?? Duration(milliseconds: 200),
        super(key: key);

  final Widget child;
  final bool visible;
  final Duration duration;
  final Curve curve;

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

class BooleanTween extends StatefulWidget {
  BooleanTween(
      {Key key,
      @required this.animate,
      @required this.tween,
      Duration duration,
      @required this.builder,
      this.curve = Curves.linear})
      : this.duration = duration ?? Duration(milliseconds: 200),
        super(key: key);

  final bool animate;
  final Duration duration;
  final Tween<dynamic> tween;
  final Widget Function(dynamic value) builder;
  final Curve curve;

  @override
  _BooleanTweenState createState() => _BooleanTweenState();
}

class _BooleanTweenState extends State<BooleanTween>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<dynamic> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    animation = widget.tween.animate(
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
      animation: animation,
      builder: (_, __) => widget.builder(animation.value),
    );
  }
}
