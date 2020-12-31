import 'package:flutter/material.dart';

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
    this.duration = Duration.zero,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: builder(context),
      ),
    );
  }
}

abstract class PushRoute {
  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  context,
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static void page(
    BuildContext context,
    Widget page, {
    bool transition = true,
  }) =>
      Navigator.push(context, _route(page, transition));

  ///Do that:
  ///```dart
  ///Navigator.pushReplacement(
  ///  context,
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static void replacement(
    BuildContext context,
    Widget page, {
    bool transition = true,
  }) =>
      Navigator.pushReplacement(context, _route(page, transition));

  static Route _route(Widget page, bool withTransition) {
    return withTransition
        ? MaterialPageRoute(builder: (_) => page)
        : PageRouteBuilder(pageBuilder: (_, __, ___) => page);
  }

  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  context,
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  static void transparentPage(
    BuildContext context,
    Widget page, {
    Duration duration = Duration.zero,
  }) {
    Navigator.push(
      context,
      TransparentRoute(builder: (_) => page, duration: duration),
    );
  }
}
