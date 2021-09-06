import 'package:flutter/material.dart';

extension NavigatorStateHelperExtension on NavigatorState {
  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  @optionalTypeArgs
  Future<T?> pushOpaque<T extends Object?>(Widget page) {
    return push<T>(PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      opaque: false,
    ));
  }

  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  ///Navigator.pushReplacementOpaque(
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  @optionalTypeArgs
  Future<T?> pushReplacementOpaque<T extends Object?, TO extends Object?>(
    Widget page,
  ) {
    return pushReplacement<T, TO>(PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      opaque: false,
    ));
  }
}
