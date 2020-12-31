import 'package:flutter/material.dart';

class GetMedia {
  GetMedia(this.context) : assert(context != null);
  final BuildContext context;

  ///Do that:
  ///```dart
  ///MediaQuery.of(context)
  ///```
  MediaQueryData get data => MediaQuery.of(context);

  ///Do that:
  ///```dart
  ///MediaQuery.of(context).size
  ///```
  Size get size => MediaQuery.of(context).size;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).size.width
  ///```
  double get width => MediaQuery.of(context).size.width;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).size.height
  ///```
  double get height => MediaQuery.of(context).size.height;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).padding
  ///```
  EdgeInsets get padding => data.padding;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).devicePixelRatio
  ///```
  double get devicePixelRatio => data.devicePixelRatio;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).textScaleFactor
  ///```
  double get textScaleFactor => data.textScaleFactor;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).platformBrightness
  ///```
  Brightness get platformBrightness =>
      MediaQuery.of(context).platformBrightness;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).viewInsets
  ///```
  EdgeInsets get viewInsets => data.viewInsets;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).systemGestureInsets
  ///```
  EdgeInsets get systemGestureInsets =>
      MediaQuery.of(context).systemGestureInsets;

  ///Do that:  MediaQuery.of(context).viewPadding
  ///```
  EdgeInsets get viewPadding => viewPadding;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).alwaysUse24HourFormat
  ///```
  bool get alwaysUse24HourFormat => data.alwaysUse24HourFormat;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).accessibleNavigation
  ///```
  bool get accessibleNavigation => data.accessibleNavigation;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).invertColors
  ///```
  bool get invertColors => data.invertColors;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).highContrast
  ///```
  bool get highContrast => data.highContrast;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).disableAnimations
  ///```
  bool get disableAnimations => data.disableAnimations;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).boldText
  ///```
  bool get boldText => data.boldText;

  ///Do that:
  ///```dart
  /// MediaQuery.of(context).navigationMode
  ///```
  NavigationMode get navigationMode => data.navigationMode;
}

class GetColor {
  final BuildContext context;
  GetColor(this.context);

  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColor
  ///```
  Color get primary => Theme.of(context).primaryColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColorLight
  ///```
  Color get primaryLight => Theme.of(context).primaryColorLight;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).primaryColorDark
  ///```
  Color get primaryDark => Theme.of(context).primaryColorDark;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).accentColor
  ///```
  Color get accent => Theme.of(context).accentColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).canvasColor
  ///```
  Color get canvas => Theme.of(context).canvasColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).shadowColor
  ///```
  Color get shadow => Theme.of(context).shadowColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).scaffoldBackgroundColor
  ///```
  Color get scaffold => Theme.of(context).scaffoldBackgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).bottomAppBarColor
  ///```
  Color get bottomAppBar => Theme.of(context).bottomAppBarColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).cardColor
  ///```
  Color get card => Theme.of(context).cardColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).dividerColor
  ///```
  Color get divider => Theme.of(context).dividerColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).focusColor
  ///```
  Color get focus => Theme.of(context).focusColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).hoverColor
  ///```
  Color get hover => Theme.of(context).hoverColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).highlightColor
  ///```
  Color get highlight => Theme.of(context).highlightColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).splashColor
  ///```
  Color get splash => Theme.of(context).splashColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).selectedRowColor
  ///```
  Color get selectedRow => Theme.of(context).selectedRowColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).unselectedWidgetColor
  ///```
  Color get unselectedWidget => Theme.of(context).unselectedWidgetColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).disabledColor
  ///```
  Color get disabled => Theme.of(context).disabledColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).buttonColor
  ///```
  Color get button => Theme.of(context).buttonColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).secondaryHeaderColor
  ///```
  Color get secondaryHeader => Theme.of(context).secondaryHeaderColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).backgroundColor
  ///```
  Color get background => Theme.of(context).backgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).dialogBackgroundColor
  ///```
  Color get dialogBackground => Theme.of(context).dialogBackgroundColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).indicatorColor
  ///```
  Color get indicator => Theme.of(context).indicatorColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).hintColor
  ///```
  Color get hint => Theme.of(context).hintColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).errorColor
  ///```
  Color get error => Theme.of(context).errorColor;

  ///DO THAT:
  ///```dart
  ///Theme.of(context).toggleableActiveColor
  ///```
  Color get toggleableActive => Theme.of(context).toggleableActiveColor;
}
