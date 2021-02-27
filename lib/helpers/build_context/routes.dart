import 'package:flutter/material.dart';

Route pageRoute(Widget page, bool withTransition) {
  return withTransition
      ? MaterialPageRoute(builder: (_) => page)
      : PageRouteBuilder(pageBuilder: (_, __, ___) => page);
}

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

//----------------------//
//NAVIGATION KEY QUERIES//
//----------------------//
class BuildRoute {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static NavigatorState state = key.currentState;

  ///Do that:
  ///```dart
  ///navigationKey.currentState.push(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static Future<void> to(Widget page, {bool transition = true}) async {
    await state.push(pageRoute(page, transition));
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.pushReplacement(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static Future<void> toReplacement(
    Widget page, {
    bool transition = true,
  }) async {
    await state.pushReplacement(pageRoute(page, transition));
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.named(context, routeName, arguments: arguments);
  /// ```
  static Future<void> toNamed(
    String routeName, {
    Object arguments,
  }) async {
    await state.pushNamed(routeName, arguments: arguments);
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.pageAndRemoveUntil(
  ///  transition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///  predicate
  ///);
  /// ```
  static Future<void> toAndRemoveUntil(
    Widget page,
    bool Function(Route<dynamic>) predicate, {
    bool transition = true,
  }) async {
    await state.pushAndRemoveUntil(pageRoute(page, transition), predicate);
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.pushNamedAndRemoveUntil(newRouteName, predicate);
  /// ```
  static Future<void> toNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object arguments,
  }) async {
    await state.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.push(
  ///  TransparentRoute(builder: (_) => page, duration: duration),
  ///);
  /// ```
  static Future<void> toTransparentPage(
    Widget page, {
    Duration duration = Duration.zero,
  }) async {
    await state.push(
      TransparentRoute(builder: (_) => page, duration: duration),
    );
  }

  ///Do that:
  ///```dart
  ///navigationKey.currentState.pop();
  /// ```
  static void goBack() => state.pop();
}
