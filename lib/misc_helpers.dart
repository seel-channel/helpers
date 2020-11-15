import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Misc {
  ///DO THAT:
  ///```dart
  /// WidgetsBinding.instance.addPostFrameCallback((d) => callback());
  /// ```
  static void onLayoutRendered(void Function() callback) {
    WidgetsBinding.instance.addPostFrameCallback((d) => callback());
  }

  ///DO THAT:
  ///```dart
  ///Theme.of(context);
  ///```
  static ThemeData theme(BuildContext context) {
    return Theme.of(context);
  }

  ///DO THAT:
  ///```dart
  ///Theme.of(context).textTheme;
  ///```
  static TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  ///DO THAT:
  ///```dart
  ///if (ifNotNull != null)
  ///  return ifNotNull;
  ///else
  ///  return ifNull;
  ///```
  static dynamic ifNull(dynamic ifNotNull, dynamic ifNull) {
    if (ifNotNull != null)
      return ifNotNull;
    else
      return ifNull;
  }

  ///RETURN:
  ///```dart
  ///"Lorem ipsum dolor sit amet, consectetur
  ///adipiscing elit, sed do eiusmod tempor incididunt
  ///ut labore et dolore magna aliqua."
  ///```
  static String loremIpsum() {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  }

  ///RETURN:
  ///```dart
  ///"Lorem ipsum dolor sit amet, consectetur
  /// adipiscing elit, sed do eiusmod tempor incididunt
  /// ut labore et dolore magna aliqua. Ut enim ad minim
  /// veniam, quis nostrud exercitation ullamco laboris
  /// nisi ut aliquip ex ea commodo consequat."
  /// ```
  static String extendedLoremIpsum() {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
        "Ut enim ad minim veniam, quis nostrud exercitation " +
        "ullamco laboris nisi ut aliquip ex ea commodo consequat.";
  }

  ///DO THAT:
  ///```dart
  ///Future.delayed(
  ///  Duration(milliseconds: durationInMiliseconds),
  ///  () => callback(),
  ///);
  ///```
  static void delayed(int durationInMiliseconds, void Function() callback) {
    Future.delayed(
      Duration(milliseconds: durationInMiliseconds),
      () => callback(),
    );
  }

  ///DO THAT:
  ///```dart
  ///await SystemChrome.setPreferredOrientations(orientations)
  ///```
  static Future<void> setSystemOrientation(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  ///DO THAT:
  ///```dart
  ///await SystemChrome.setEnabledSystemUIOverlays(overlays)
  ///```
  static Future<void> setSystemOverlay(List<SystemUiOverlay> overlays) async {
    await SystemChrome.setEnabledSystemUIOverlays(overlays);
  }

  ///DO THAT:
  ///```dart
  ///SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(...));
  ///```
  static void setSystemOverlayStyle({
    Brightness statusBarBrightness,
    Brightness statusBarIconBrightness,
    Brightness navigationBarIconBrightness,
    Color statusBarColor,
    Color navigationBarColor,
    Color navigationBarDividerColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navigationBarColor,
      systemNavigationBarDividerColor: navigationBarDividerColor,
      systemNavigationBarIconBrightness: navigationBarIconBrightness,
      statusBarColor: statusBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness,
    ));
  }
}

abstract class SystemOverlay {
  ///RETURN:
  ///```dart
  ///List()
  ///```
  static List<SystemUiOverlay> none = List();

  ///RETURN:
  ///```dart
  ///[SystemUiOverlay.top]
  ///```
  static List<SystemUiOverlay> top = [SystemUiOverlay.top];

  ///RETURN:
  ///```dart
  ///SystemUiOverlay.values
  ///```
  static List<SystemUiOverlay> values = SystemUiOverlay.values;

  ///RETURN:
  ///```dart
  ///[SystemUiOverlay.bottom]
  ///```
  static List<SystemUiOverlay> bottom = [SystemUiOverlay.bottom];
}

abstract class SystemOrientation {
  ///RETURN:
  ///```dart
  ///[DeviceOrientation.values]
  ///```
  static List<DeviceOrientation> values = DeviceOrientation.values;

  ///RETURN:
  ///```dart
  ///[DeviceOrientation.portraitUp]
  ///```
  static List<DeviceOrientation> portraitUp = [DeviceOrientation.portraitUp];

  ///RETURN:
  ///```dart
  ///[DeviceOrientation.portraitDown]
  ///```
  static List<DeviceOrientation> portraitDown = [
    DeviceOrientation.portraitDown
  ];

  ///RETURN:
  ///```dart
  ///[DeviceOrientation.landscapeLeft]
  ///```
  static List<DeviceOrientation> landscapeLeft = [
    DeviceOrientation.landscapeLeft
  ];

  ///RETURN:
  ///```dart
  ///[DeviceOrientation.landscapeRight]
  ///```
  static List<DeviceOrientation> landscapeRight = [
    DeviceOrientation.landscapeRight
  ];
}

abstract class GetColor {
  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColor
  ///```
  static Color primary(BuildContext context) =>
      Misc.theme(context).primaryColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColorLight
  ///```
  static Color primaryLight(BuildContext context) =>
      Misc.theme(context).primaryColorLight;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColorDark
  ///```
  static Color primaryDark(BuildContext context) =>
      Misc.theme(context).primaryColorDark;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).accentColor
  ///```
  static Color accent(BuildContext context) => Misc.theme(context).accentColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).canvasColor
  ///```
  static Color canvas(BuildContext context) => Misc.theme(context).canvasColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).shadowColor
  ///```
  static Color shadow(BuildContext context) => Misc.theme(context).shadowColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).scaffoldBackgroundColor
  ///```
  static Color scaffoldBackground(BuildContext context) =>
      Misc.theme(context).scaffoldBackgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).bottomAppBarColor
  ///```
  static Color bottomAppBar(BuildContext context) =>
      Misc.theme(context).bottomAppBarColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).cardColor
  ///```
  static Color card(BuildContext context) => Misc.theme(context).cardColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).dividerColor
  ///```
  static Color divider(BuildContext context) =>
      Misc.theme(context).dividerColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).focusColor
  ///```
  static Color focus(BuildContext context) => Misc.theme(context).focusColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).hoverColor
  ///```
  static Color hover(BuildContext context) => Misc.theme(context).hoverColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).highlightColor
  ///```
  static Color highlight(BuildContext context) =>
      Misc.theme(context).highlightColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).splashColor
  ///```
  static Color splash(BuildContext context) => Misc.theme(context).splashColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).selectedRowColor
  ///```
  static Color selectedRow(BuildContext context) =>
      Misc.theme(context).selectedRowColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).unselectedWidgetColor
  ///```
  static Color unselectedWidget(BuildContext context) =>
      Misc.theme(context).unselectedWidgetColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).disabledColor
  ///```
  static Color disabled(BuildContext context) =>
      Misc.theme(context).disabledColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).buttonColor
  ///```
  static Color button(BuildContext context) => Misc.theme(context).buttonColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).secondaryHeaderColor
  ///```
  static Color secondaryHeader(BuildContext context) =>
      Misc.theme(context).secondaryHeaderColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).textSelectionColor
  ///```
  static Color textSelection(BuildContext context) =>
      Misc.theme(context).textSelectionColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).cursorColor
  ///```
  static Color cursor(BuildContext context) => Misc.theme(context).cursorColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).textSelectionColor
  ///```
  static Color textSelectionHandle(BuildContext context) =>
      Misc.theme(context).textSelectionColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).backgroundColor
  ///```
  static Color background(BuildContext context) =>
      Misc.theme(context).backgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).dialogBackgroundColor
  ///```
  static Color dialogBackground(BuildContext context) =>
      Misc.theme(context).dialogBackgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).indicatorColor
  ///```
  static Color indicator(BuildContext context) =>
      Misc.theme(context).indicatorColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).hintColor
  ///```
  static Color hint(BuildContext context) => Misc.theme(context).hintColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).errorColor
  ///```
  static Color error(BuildContext context) => Misc.theme(context).errorColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).toggleableActiveColor
  ///```
  static Color toggleableActive(BuildContext context) =>
      Misc.theme(context).toggleableActiveColor;
}
