import 'package:flutter/material.dart';

class BuildMedia {
  BuildMedia(this.context) : assert(context != null);
  final BuildContext context;

  ///```dart
  ///return MediaQuery.of(context)
  ///```
  MediaQueryData get data => MediaQuery.of(context);

  ///```dart
  ///return MediaQuery.of(context).size
  ///```
  Size get size => MediaQuery.of(context).size;

  ///```dart
  ///return MediaQuery.of(context).size.width
  ///```
  double get width => MediaQuery.of(context).size.width;

  ///```dart
  ///return MediaQuery.of(context).size.height
  ///```
  double get height => MediaQuery.of(context).size.height;

  ///```dart
  ///return MediaQuery.of(context).padding
  ///```
  EdgeInsets get padding => data.padding;

  ///```dart
  ///return MediaQuery.of(context).devicePixelRatio
  ///```
  double get devicePixelRatio => data.devicePixelRatio;

  ///```dart
  ///return MediaQuery.of(context).textScaleFactor
  ///```
  double get textScaleFactor => data.textScaleFactor;

  ///```dart
  ///return MediaQuery.of(context).platformBrightness
  ///```
  Brightness get platformBrightness =>
      MediaQuery.of(context).platformBrightness;

  ///```dart
  ///return MediaQuery.of(context).viewInsets
  ///```
  EdgeInsets get viewInsets => data.viewInsets;

  ///```dart
  ///return MediaQuery.of(context).systemGestureInsets
  ///```
  EdgeInsets get systemGestureInsets =>
      MediaQuery.of(context).systemGestureInsets;

  ///Do that:  MediaQuery.of(context).viewPadding
  ///```
  EdgeInsets get viewPadding => viewPadding;

  ///```dart
  ///return MediaQuery.of(context).alwaysUse24HourFormat
  ///```
  bool get alwaysUse24HourFormat => data.alwaysUse24HourFormat;

  ///```dart
  ///return MediaQuery.of(context).accessibleNavigation
  ///```
  bool get accessibleNavigation => data.accessibleNavigation;

  ///```dart
  ///return MediaQuery.of(context).invertColors
  ///```
  bool get invertColors => data.invertColors;

  ///```dart
  ///return MediaQuery.of(context).highContrast
  ///```
  bool get highContrast => data.highContrast;

  ///```dart
  ///return MediaQuery.of(context).disableAnimations
  ///```
  bool get disableAnimations => data.disableAnimations;

  ///```dart
  ///return MediaQuery.of(context).boldText
  ///```
  bool get boldText => data.boldText;

  ///```dart
  ///return MediaQuery.of(context).navigationMode
  ///```
  NavigationMode get navigationMode => data.navigationMode;
}
