import 'package:flutter/material.dart';

extension GlobalKeyHelperExtension<T extends State<StatefulWidget>>
    on GlobalKey<T> {
  ///Do that:
  ///```dart
  ///return key.currentContext
  ///```
  BuildContext? get context => currentContext;

  ///Do that:
  ///```dart
  ///return key.currentWidget
  ///```
  Widget? get widget => currentWidget;

  ///Do that:
  ///```dart
  ///return key.currentContext.size.height
  ///```
  double? get height => currentContext?.size?.height;

  ///Do that:
  ///```dart
  ///return key.currentContext.size.width
  ///```
  double? get width => currentContext?.size?.width;

  ///Do that:
  ///```dart
  ///return key.currentContext.size
  ///```
  Size? get size => currentContext?.size;

  ///Do that:
  ///```dart
  ///return key.currentState
  ///```
  T? get state => currentState;
}
