import 'package:flutter/material.dart';

//PADDINGS - MARGINS
class Margin {
  ///Do that:
  ///```dart
  ///EdgeInsets.zero
  ///```
  static EdgeInsets zero = EdgeInsets.zero;

  ///Do that:
  ///```dart
  ///EdgeInsets.all(amount)
  ///```
  static EdgeInsets all(double amount) => EdgeInsets.all(amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(vertical: amount)
  ///```
  static EdgeInsets vertical(double amount) =>
      EdgeInsets.symmetric(vertical: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(horizontal: amount)
  ///```
  static EdgeInsets horizontal(double amount) =>
      EdgeInsets.symmetric(horizontal: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(top: amount ?? 0.0)
  ///```
  static EdgeInsets top(double amount) => EdgeInsets.only(top: amount ?? 0.0);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(right: amount ?? 0.0)
  ///```
  static EdgeInsets right(double amount) =>
      EdgeInsets.only(right: amount ?? 0.0);

  ///Do that:
  ///```dart
  /// EdgeInsets.only(bottom: amount ?? 0.0)
  /// ```
  static EdgeInsets bottom(double amount) =>
      EdgeInsets.only(bottom: amount ?? 0.0);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(left: amount ?? 0.0)
  ///```
  static EdgeInsets left(double amount) => EdgeInsets.only(left: amount ?? 0.0);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(horizontal: horizontal ?? 0.0,
  ///vertical: vertical ?? 0.0);
  ///```
  static EdgeInsets symmetric({double horizontal, double vertical}) {
    return EdgeInsets.symmetric(
        horizontal: horizontal ?? 0.0, vertical: vertical ?? 0.0);
  }

  ///Do that:
  ///```dart
  ///EdgeInsets.only(
  ///  top: top ?? 0.0,
  ///  bottom: bottom ?? 0.0,
  ///  left: left ?? 0.0,
  ///  right: right ?? 0.0,
  ///)
  ///```
  static EdgeInsets only({
    double top,
    double bottom,
    double left,
    double right,
  }) {
    return EdgeInsets.only(
      top: top ?? 0.0,
      bottom: bottom ?? 0.0,
      left: left ?? 0.0,
      right: right ?? 0.0,
    );
  }
}

//BORDERS RADIUS
abstract class EdgeRadius {
  ///Do that:
  ///```dart
  ///BorderRadius.zero
  ///```
  static BorderRadius zero = BorderRadius.zero;

  ///Do that:
  ///```dart
  ///BorderRadius.all(Radius.circular(amount))
  ///```
  static BorderRadius all(double amount) {
    return BorderRadius.all(Radius.circular(amount));
  }

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(
  ///  top: Radius.circular(top ?? 0.0),
  ///  bottom: Radius.circular(bottom ?? 0.0),
  ///)
  ///```
  static BorderRadius vertical({double top, double bottom}) {
    return BorderRadius.vertical(
      bottom: Radius.circular(bottom ?? 0.0),
      top: Radius.circular(top ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(
  ///  top: Radius.circular(top ?? 0.0),
  ///)
  ///```
  static BorderRadius top(double top) {
    return BorderRadius.vertical(
      top: Radius.circular(top ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(
  ///  bottom: Radius.circular(bottom ?? 0.0),
  ///)
  ///```
  static BorderRadius bottom(double bottom) {
    return BorderRadius.vertical(
      bottom: Radius.circular(bottom ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  left: Radius.circular(left ?? 0.0),
  ///  right: Radius.circular(right ?? 0.0),
  ///)
  ///```
  static BorderRadius horizontal({double left, double right}) {
    return BorderRadius.horizontal(
      left: Radius.circular(left ?? 0.0),
      right: Radius.circular(right ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  left: Radius.circular(left ?? 0.0),
  ///)
  ///```
  static BorderRadius left(double left) {
    return BorderRadius.horizontal(
      left: Radius.circular(left ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  right: Radius.circular(right ?? 0.0),
  ///)
  ///```
  static BorderRadius right(double right) {
    return BorderRadius.horizontal(
      right: Radius.circular(right ?? 0.0),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.only(
  ///  topLeft: Radius.circular(topLeft ?? 0.0),
  ///  topRight: Radius.circular(topRight ?? 0.0),
  ///  bottomLeft: Radius.circular(bottomLeft ?? 0.0),
  ///  bottomRight: Radius.circular(bottomRight ?? 0.0),
  ///)
  /// ```
  static BorderRadius only({
    double topLeft,
    double topRight,
    double bottomLeft,
    double bottomRight,
  }) {
    return BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? 0.0),
        topRight: Radius.circular(topRight ?? 0.0),
        bottomLeft: Radius.circular(bottomLeft ?? 0.0),
        bottomRight: Radius.circular(bottomRight ?? 0.0));
  }
}
