import 'package:flutter/material.dart';

class BuildKey<T extends State<StatefulWidget>> {
  BuildKey(this.key) : assert(key != null);
  final GlobalKey<T> key;

  ///Do that:
  ///```dart
  ///key.currentContext
  ///```
  BuildContext get context => key.currentContext;

  ///Do that:
  ///```dart
  ///key.currentContext.size.height
  ///```
  double get height => key.currentContext.size.height;

  ///Do that:
  ///```dart
  ///key.currentContext.size.width
  ///```
  double get width => key.currentContext.size.width;

  ///Do that:
  ///```dart
  ///key.currentContext.size
  ///```
  Size get size => key.currentContext.size;

  ///Do that:
  ///```dart
  ///key.currentContext.widget
  ///```
  Widget get widget => key.currentContext.widget;

  ///Do that:
  ///```dart
  ///key.currentState
  ///```
  T get state => key.currentState;
}
