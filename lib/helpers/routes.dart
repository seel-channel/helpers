import 'package:flutter/material.dart';

class TransparentRoute extends PageRoute<Future<void>> {
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

Route _route(Widget page, bool withTransition) {
  return withTransition
      ? MaterialPageRoute(builder: (_) => page)
      : PageRouteBuilder(pageBuilder: (_, __, ___) => page);
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
  static Future<void> page(
    BuildContext context,
    Widget page, {
    bool transition = true,
  }) async {
    await Navigator.push(context, _route(page, transition));
  }

  ///Do that:
  ///```dart
  ///Navigator.pushReplacement(
  ///  context,
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static Future<void> replacement(
    BuildContext context,
    Widget page, {
    bool transition = true,
  }) async {
    await Navigator.pushReplacement(context, _route(page, transition));
  }

  ///Do that:
  ///```dart
  ///Navigator.named(context, routeName, arguments: arguments);
  /// ```
  static Future<void> named(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) async {
    await Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  ///Do that:
  ///```dart
  ///Navigator.pageAndRemoveUntil(
  ///  context,
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///  predicate
  ///);
  /// ```
  static Future<void> pageAndRemove(
    BuildContext context,
    Widget page,
    bool Function(Route<dynamic>) predicate, {
    bool transition = true,
  }) async {
    await Navigator.pushAndRemoveUntil(
      context,
      _route(page, transition),
      predicate,
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.pushNamedAndRemoveUntil(
  ///  context,
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///  predicate
  ///);
  /// ```
  static Future<void> namedAndRemove(
    BuildContext context,
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object arguments,
  }) async {
    await Navigator.pushNamedAndRemoveUntil(
      context,
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  context,
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  static Future<void> transparentPage(
    BuildContext context,
    Widget page, {
    Duration duration = Duration.zero,
  }) async {
    await Navigator.push(
      context,
      TransparentRoute(builder: (_) => page, duration: duration),
    );
  }
}
