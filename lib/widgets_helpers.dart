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
  ///Eliminate the Splash Effect or Glow Effect when reaching
  ///the limit of a PageView, ScrollView, ListView, etc.
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
  ///Tapping on a Widget will apply the FocusScope to it and hide the keyboard.
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

class SizeBuilder extends StatefulWidget {
  ///```dart
  /////EXAMPLE:
  ///SizeBuilder(builder: (width, height) {
  ///    Size layout = Size(width, height);
  ///    return Container(
  ///       width: width,
  ///       height: height,
  ///       color: Colors.red,
  ///    );
  ///  });
  ///
  ///
  /////RETURN THAT:
  ///return LayoutBuilder(builder: (_, constraints) {
  ///   return widget.builder(constraints.maxWidth, constraints.maxHeight);
  ///});
  ///```
  SizeBuilder({Key key, this.builder}) : super(key: key);

  ///Argument `(double width, double height)`
  final Widget Function(double width, double height) builder;

  @override
  _SizeBuilderState createState() => _SizeBuilderState();
}

class _SizeBuilderState extends State<SizeBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return widget.builder(constraints.maxWidth, constraints.maxHeight);
    });
  }
}

class TransparentBox extends StatelessWidget {
  ///```dart
  ///return Container(color: Colors.transparent)
  ///```
  const TransparentBox({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.transparent, child: child);
  }
}

class ExpandedSpacer extends StatelessWidget {
  ///```dart
  ///return Expanded(child: SizedBox())
  ///```
  const ExpandedSpacer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox());
  }
}

class ExpandedTap extends StatelessWidget {
  ///```dart
  ///return Expanded(
  ///   child: GestureDetector(
  ///     onTap: onTap,
  ///     child: child,
  ///   ),
  ///);
  ///```
  const ExpandedTap({Key key, this.onTap, this.child}) : super(key: key);

  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class SafeAreaColor extends StatelessWidget {
  ///```dart
  ///  return Container(
  ///    color: color,
  ///    child: SafeArea(
  ///      child: Container(
  ///        height: height,
  ///        child: child,
  ///      ),
  ///    ),
  ///  );
  /// ```
  const SafeAreaColor({
    Key key,
    this.child,
    this.color = Colors.white,
    this.height,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        child: Container(
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class AnimatedInteractiveViewer extends StatefulWidget {
  ///It is very similar to the InteractiveViewer except the AnimatedInteractiveViewer
  ///have a double-tap animated zoom
  AnimatedInteractiveViewer({
    Key key,
    this.child,
    this.controller,
    this.maxScale = 2.0,
    this.minScale = 0.8,
    Duration duration,
    Curve curve,
    this.onInteractionStart,
    this.onInteractionUpdate,
    this.onInteractionEnd,
  })  : this.duration = duration ?? Duration(milliseconds: 200),
        this.curve = curve ?? Curves.ease,
        super(key: key);

  //The maximum allowed scale.
  final double maxScale;

  ///The minimum allowed scale.
  final double minScale;

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// It is the child that will be affected by the SwipeTransition
  final Widget child;

  ///The length of time than the double-tap zoom
  final Duration duration;

  ///If you pass the TransformationController then can control the InteractiveViewer outside it
  final TransformationController controller;

  ///Called when the user ends a pan or scale gesture on the widget.
  final void Function(ScaleEndDetails) onInteractionEnd;

  ///Called when the user begins a pan or scale gesture on the widget.
  final void Function(ScaleStartDetails) onInteractionStart;

  ///Called when the user updates a pan or scale gesture on the widget.
  final void Function(ScaleUpdateDetails) onInteractionUpdate;

  @override
  _AnimatedInteractiveViewerState createState() =>
      _AnimatedInteractiveViewerState();
}

class _AnimatedInteractiveViewerState extends State<AnimatedInteractiveViewer>
    with TickerProviderStateMixin {
  TransformationController _controller;
  AnimationController _animationController;
  Animation<Matrix4> _animationMatrix4;

  @override
  void initState() {
    _controller = widget.controller ?? TransformationController();
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  //Clear Matrix4 animation
  void _onInteractionStart(ScaleStartDetails details) {
    if (widget.onInteractionStart != null) widget.onInteractionStart(details);
    if (_animationController.status == AnimationStatus.forward)
      _clearAnimation();
  }

  void _changeControllerMatrix4() {
    _controller.value = _animationMatrix4.value;
    if (!_animationController.isAnimating) _clearAnimation();
  }

  void _clearAnimation() {
    _animationController.stop();
    _animationMatrix4?.removeListener(_changeControllerMatrix4);
    _animationMatrix4 = null;
    _animationController.reset();
  }

  //Animate MATRIX4
  void _onDoubleTapHandle(TapDownDetails details) {
    if (_controller.value == Matrix4.identity()) {
      final RenderBox box = context.findRenderObject();
      final Offset position = box.globalToLocal(details.globalPosition);
      final Matrix4 matrix = Matrix4(
          //Column1
          widget.maxScale,
          0.0,
          0.0,
          0.0,
          //Column2
          0.0,
          widget.maxScale,
          0.0,
          0.0,
          //Column3
          0.0,
          0.0,
          widget.maxScale,
          0.0,
          //Column4
          -position.dx,
          -position.dy,
          0.0,
          1.0);
      animateMatrix4(matrix);
    } else
      animateMatrix4(Matrix4.identity());
  }

  void animateMatrix4(Matrix4 value) {
    _animationMatrix4 = Matrix4Tween(
      begin: _controller.value,
      end: value,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    );
    _animationController.duration = widget.duration;
    _animationMatrix4.addListener(_changeControllerMatrix4);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      transformationController: _controller,
      onInteractionStart: _onInteractionStart,
      onInteractionUpdate: widget.onInteractionUpdate,
      onInteractionEnd: widget.onInteractionEnd,
      child: GestureDetector(
        onDoubleTapDown: _onDoubleTapHandle,
        child: widget.child,
      ),
    );
  }
}
