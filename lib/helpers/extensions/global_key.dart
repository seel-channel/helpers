import 'package:flutter/material.dart';

extension GlobalKeyHelperExtension<T extends State<StatefulWidget>>
    on GlobalKey<T> {
  ///Do that:
  ///```dart
  ///return key.currentContext
  ///```
  BuildContext? get context => this.currentContext;

  ///Do that:
  ///```dart
  ///return key.currentWidget
  ///```
  Widget? get widget => this.currentWidget;

  ///Do that:
  ///```dart
  ///return key.currentContext.size.height
  ///```
  double? get height => this.currentContext?.size?.height;

  ///Do that:
  ///```dart
  ///return key.currentContext.size.width
  ///```
  double? get width => this.currentContext?.size?.width;

  ///Do that:
  ///```dart
  ///return key.currentContext.size
  ///```
  Size? get size => this.currentContext?.size;

  ///Do that:
  ///```dart
  ///return key.currentState
  ///```
  T? get state => this.currentState;
}
