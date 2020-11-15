import 'package:flutter/material.dart';

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
    this.transitionMs = 300,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;
  final int transitionMs;

  @override
  bool get opaque => false;
  @override
  Color get barrierColor => null;
  @override
  String get barrierLabel => null;
  @override
  bool get maintainState => true;
  @override
  Duration get transitionDuration => Duration(milliseconds: transitionMs);

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
  ///  withTransition
  ///     ? MaterialPageRoute(builder: (_) => page)
  ///     : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
  ///);
  /// ```
  static void page(BuildContext context, Widget page,
      {bool withTransition = true}) {
    Navigator.push(
      context,
      withTransition
          ? MaterialPageRoute(builder: (_) => page)
          : PageRouteBuilder(pageBuilder: (_, __, ___) => page),
    );
  }

  ///Do that:
  ///```dart
  ///Navigator.push(
  ///  context,
  ///  TransparentRoute(builder: (_) => page, transitionMs: transitionMs),
  ///);
  /// ```
  static void transparentPage(BuildContext context, Widget page,
      {int transitionMs = 0}) {
    Navigator.push(
      context,
      TransparentRoute(builder: (_) => page, transitionMs: transitionMs),
    );
  }
}
