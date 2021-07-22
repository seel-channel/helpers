import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

extension BuildContextHelperExtension on BuildContext {
  Route pageRoute(Widget page, bool withTransition) {
    return withTransition
        ? MaterialPageRoute(builder: (_) => page)
        : PageRouteBuilder(pageBuilder: (_, __, ___) => page);
  }

  NavigatorState get navigator => Navigator.of(this);

  /// It is a simplification of the **_Theme.of(context)_** statement.
  ///
  ///Do that:
  ///```dart
  ///return BuildColor(context)
  ///```
  BuildColor get color => BuildColor(this);

  /// It is a simplification of the **_MediaQuery.of(context)_** statement.
  ///
  ///Do that:
  ///```dart
  ///return BuildMedia(context)
  ///```
  BuildMedia get media => BuildMedia(this);

  ///DO THAT:
  ///```dart
  ///Theme.of(context);
  ///```
  ThemeData get theme => Theme.of(this);

  ///DO THAT:
  ///```dart
  ///Theme.of(context).textTheme;
  ///```
  TextTheme get textTheme => Theme.of(this).textTheme;

  ///Do that:
  ///```dart
  ///return context.size.width
  ///```
  double? get width => this.size?.width;

  ///Do that:
  ///```dart
  ///return context.size.height
  ///```
  double? get height => this.size?.height;

  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.pushOpaque(...)")
  Future<void> toTransparentPage(
    Widget page, {
    Duration duration = Duration.zero,
  }) async {
    await Navigator.of(this).pushOpaque(page);
  }

  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.push(...)")
  Future<void> to(Widget page, {bool transition = true}) async {
    await Navigator.push(this, pageRoute(page, transition));
  }

  ///Do that:
  ///```dart
  ///Navigator.pushReplacement(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.pushReplacement(...)")
  Future<void> toReplacement(
    Widget page, {
    bool transition = true,
  }) async {
    await Navigator.pushReplacement(this, pageRoute(page, transition));
  }

  ///Do that:
  ///```dart
  ///Navigator.named(context, routeName, arguments: arguments);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.pushNamed(...)")
  Future<void> toNamed(
    String routeName, {
    Object? arguments,
  }) async {
    await Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  ///Do that:
  ///```dart
  ///Navigator.pushAndRemoveUntil(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///  predicate
  ///);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.pushAndRemoveUntil(...)")
  Future<void> toAndRemoveUntil(
    Widget page,
    bool Function(Route<dynamic>) predicate, {
    bool transition = true,
  }) async {
    await Navigator.pushAndRemoveUntil(
      this,
      pageRoute(page, transition),
      predicate,
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.pushNamedAndRemoveUntil(newRouteName, predicate);
  /// ```
  @Deprecated(
      "Avoid use this instance, you should use context.navigator.toNamedAndRemoveUntil(...)")
  Future<void> toNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) async {
    await Navigator.pushNamedAndRemoveUntil(
      this,
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.pop();
  /// ```
  @Deprecated("Avoid use this instance, you should use context.navigator.pop()")
  void goBack() => Navigator.pop(this);
}
