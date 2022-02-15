import 'package:flutter/material.dart';

class NoTransitionPageRoute<T> extends PageRoute<T> {
  NoTransitionPageRoute({required this.child});

  final Widget child;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      child;

  @override
  bool canTransitionFrom(TransitionRoute nextRoute) => false;

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration.zero;
}

extension NavigatorStateHelperExtension on NavigatorState {
  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  /// NoTransitionPageRoute<T>(child: page)
  /// ```
  @optionalTypeArgs
  Future<T?> pushNoTransition<T extends Object?>(Widget page) {
    return push<T>(NoTransitionPageRoute<T>(child: page));
  }

  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  ///Navigator.pushReplacementOpaque(
  ///  NoTransitionPageRoute<T>(child: page),
  ///);
  /// ```
  @optionalTypeArgs
  Future<T?> pushReplacementNoTransition<T extends Object?, TO extends Object?>(
    Widget page,
  ) {
    return pushReplacement<T, TO>(NoTransitionPageRoute<T>(child: page));
  }
}
