import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:helpers/helpers/build_context/color.dart';
import 'package:helpers/helpers/build_context/media.dart';

extension BuildContextHelperExtension on BuildContext {
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
  double get width => this.size!.width;

  ///Do that:
  ///```dart
  ///return context.size.height
  ///```
  double get height => this.size!.height;

  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
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
  Future<void> toAndRemoveUntil(
    Widget page,
    bool Function(Route<dynamic>) predicate, {
    bool transition = true,
  }) async {
    await Navigator.pushAndRemoveUntil(
        this, pageRoute(page, transition), predicate);
  }

  ///Do that:
  ///```dart
  ///Navigator.pushNamedAndRemoveUntil(newRouteName, predicate);
  /// ```
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

  ///Usually used with a **[SlidingPanel]**
  ///
  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  Future<void> toTransparentPage(
    Widget page, {
    Duration duration = Duration.zero,
  }) async {
    await Navigator.push(
      this,
      TransparentRoute(builder: (_) => page, duration: duration),
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.pop();
  /// ```
  void goBack() => Navigator.pop(this);
}
