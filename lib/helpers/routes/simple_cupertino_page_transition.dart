import 'package:flutter/material.dart';

// Offset from offscreen to the right to fully on screen.
final Animatable<Offset> _kRightMiddleTween = Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

// Offset from fully on screen to 1/3 offscreen to the left.
final Animatable<Offset> _kMiddleLeftTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0 / 3.0, 0.0),
);

/// Provides an iOS-style page transition animation.
///
/// The page slides in from the right and exits in reverse. It also shifts to the left in
/// a parallax motion when another page enters to cover it.
class SimpleCupertinoPageTransition extends StatelessWidget {
  /// Creates an iOS-style page transition.
  ///
  ///  * `primaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when this screen is being pushed.
  ///  * `secondaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when another screen is being pushed on top of this one.
  ///  * `linearTransition` is whether to perform the transitions linearly.
  ///    Used to precisely track back gesture drags.
  SimpleCupertinoPageTransition({
    Key? key,
    required Animation<double> primaryRouteAnimation,
    required Animation<double> secondaryRouteAnimation,
    required this.child,
    Curve routeCurve = Curves.linearToEaseOut,
    Curve reverseRouteCurve = Curves.easeInToLinear,
    DecorationTween? decoration,
  })  : _primaryPositionAnimation = CurvedAnimation(
          parent: primaryRouteAnimation,
          curve: routeCurve,
          reverseCurve: reverseRouteCurve,
        ).drive(_kRightMiddleTween),
        _secondaryPositionAnimation = CurvedAnimation(
          parent: secondaryRouteAnimation,
          curve: routeCurve,
          reverseCurve: reverseRouteCurve,
        ).drive(_kMiddleLeftTween),
        _primaryShadowAnimation = decoration != null
            ? CurvedAnimation(
                parent: primaryRouteAnimation,
                curve: routeCurve,
              ).drive(decoration)
            : null,
        super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  // When this page is coming in to cover another page.
  final Animation<Offset> _primaryPositionAnimation;

  final Animation<Decoration>? _primaryShadowAnimation;
  // When this page is becoming covered by another page.
  final Animation<Offset> _secondaryPositionAnimation;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    final TextDirection textDirection = Directionality.of(context);
    return SlideTransition(
      position: _secondaryPositionAnimation,
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: _primaryPositionAnimation,
        textDirection: textDirection,
        child: _primaryShadowAnimation != null
            ? DecoratedBoxTransition(
                decoration: _primaryShadowAnimation!, child: child)
            : child,
      ),
    );
  }
}
