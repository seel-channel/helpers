import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

extension BuildContextHelperExtension on BuildContext {
  Route _pageRoute(Widget page, bool withTransition) {
    return withTransition
        ? MaterialPageRoute(builder: (_) => page)
        : PageRouteBuilder(pageBuilder: (_, __, ___) => page);
  }

  //----------//
  //NAVIGATION//
  //----------//
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  NavigatorState get navigator => Navigator.of(this);

  //---------//
  //SNACKBARS//
  //---------//
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar, {
    void Function(SnackBarClosedReason)? onClosed,
    VoidCallback? onVisible,
  }) {
    final controller = ScaffoldMessenger.of(this).showSnackBar(snackBar);
    onVisible?.call();
    controller.closed.then((reason) => onClosed?.call(reason));
    return controller;
  }

  void hideCurrentSnackBar(
      [SnackBarClosedReason reason = SnackBarClosedReason.remove]) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar(reason: reason);
  }

  void removeCurrentSnackBar(
      [SnackBarClosedReason reason = SnackBarClosedReason.remove]) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar(reason: reason);
  }

  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  //----------//
  //DIMENSIONS//
  //----------//
  ///Do that:
  ///```dart
  ///return context.size.width
  ///```
  double? get width => size?.width;

  ///Do that:
  ///```dart
  ///return context.size.height
  ///```
  double? get height => size?.height;

  //-----//
  //THEME//
  //-----//
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

  IconThemeData get iconTheme => theme.iconTheme;

  //----------//
  //DEPRECATED//
  //----------//
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
    await Navigator.push(this, _pageRoute(page, transition));
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
    await Navigator.pushReplacement(this, _pageRoute(page, transition));
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
      _pageRoute(page, transition),
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
