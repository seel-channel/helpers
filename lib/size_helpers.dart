import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

abstract class GetContext {
  ///Do that:
  ///```dart
  ///MediaQuery.of(context)
  ///```
  static MediaQueryData data(BuildContext context) => MediaQuery.of(context);

  ///Do that:
  ///```dart
  ///MediaQuery.of(context).size
  ///```
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  ///Do that:
  ///```dart
  ///GetContext.size(context).width
  ///```
  static double width(BuildContext context) => GetContext.size(context).width;

  ///Do that:
  ///```dart
  ///GetContext.size(context).height
  ///```
  static double height(BuildContext context) => GetContext.size(context).height;

  ///Do that:
  ///```dart
  ///GetContext.data(context).padding
  ///```
  static EdgeInsets padding(BuildContext context) =>
      GetContext.data(context).padding;

  ///Do that:
  ///```dart
  ///GetContext.data(context).devicePixelRatio
  ///```
  static double devicePixelRatio(BuildContext context) =>
      GetContext.data(context).devicePixelRatio;

  ///Do that:
  ///```dart
  ///GetContext.data(context).textScaleFactor
  ///```
  static double textScaleFactor(BuildContext context) =>
      GetContext.data(context).textScaleFactor;

  ///Do that:
  ///```dart
  ///GetContext.data(context).platformBrightness
  ///```
  static Brightness platformBrightness(BuildContext context) =>
      GetContext.data(context).platformBrightness;

  ///Do that:
  ///```dart
  ///GetContext.data(context).viewInsets
  ///```
  static EdgeInsets viewInsets(BuildContext context) =>
      GetContext.data(context).viewInsets;

  ///Do that:
  ///```dart
  ///GetContext.data(context).systemGestureInsets
  ///```
  static EdgeInsets systemGestureInsets(BuildContext context) =>
      GetContext.data(context).systemGestureInsets;

  ///Do that: GetContext.data(context).viewPadding
  ///```
  static EdgeInsets viewPadding(BuildContext context) =>
      GetContext.data(context).viewPadding;

  ///Do that:
  ///```dart
  ///GetContext.data(context).alwaysUse24HourFormat
  ///```
  static bool alwaysUse24HourFormat(BuildContext context) =>
      GetContext.data(context).alwaysUse24HourFormat;

  ///Do that:
  ///```dart
  ///GetContext.data(context).accessibleNavigation
  ///```
  static bool accessibleNavigation(BuildContext context) =>
      GetContext.data(context).accessibleNavigation;

  ///Do that:
  ///```dart
  ///GetContext.data(context).invertColors
  ///```
  static bool invertColors(BuildContext context) =>
      GetContext.data(context).invertColors;

  ///Do that:
  ///```dart
  ///GetContext.data(context).highContrast
  ///```
  static bool highContrast(BuildContext context) =>
      GetContext.data(context).highContrast;

  ///Do that:
  ///```dart
  ///GetContext.data(context).disableAnimations
  ///```
  static bool disableAnimations(BuildContext context) =>
      GetContext.data(context).disableAnimations;

  ///Do that:
  ///```dart
  ///GetContext.data(context).boldText
  ///```
  static bool boldText(BuildContext context) =>
      GetContext.data(context).boldText;

  ///Do that:
  ///```dart
  ///GetContext.data(context).navigationMode
  ///```
  static NavigationMode navigationMode(BuildContext context) =>
      GetContext.data(context).navigationMode;
}

abstract class GetKey {
  ///Do that:
  ///```dart
  ///key.currentContext
  ///```
  static BuildContext context(GlobalKey key) => key.currentContext;

  ///Do that:
  ///```dart
  ///key.currentContext.size.height
  ///```
  static double height(GlobalKey key) => key.currentContext.size.height;

  ///Do that:
  ///```dart
  ///key.currentContext.size.width
  ///```
  static double width(GlobalKey key) => key.currentContext.size.width;

  ///Do that:
  ///```dart
  ///key.currentContext.size
  ///```
  static Size size(GlobalKey key) => key.currentContext.size;
}

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
  ///EdgeInsets.only(top: Misc.ifNull(amount, 0.0))
  ///```
  static EdgeInsets top(double amount) =>
      EdgeInsets.only(top: Misc.ifNull(amount, 0.0));

  ///Do that:
  ///```dart
  ///EdgeInsets.only(right: Misc.ifNull(amount, 0.0))
  ///```
  static EdgeInsets right(double amount) =>
      EdgeInsets.only(right: Misc.ifNull(amount, 0.0));

  ///Do that:
  ///```dart
  /// EdgeInsets.only(bottom: Misc.ifNull(amount, 0.0))
  /// ```
  static EdgeInsets bottom(double amount) =>
      EdgeInsets.only(bottom: Misc.ifNull(amount, 0.0));

  ///Do that:
  ///```dart
  ///EdgeInsets.only(left: Misc.ifNull(amount, 0.0))
  ///```
  static EdgeInsets left(double amount) =>
      EdgeInsets.only(left: Misc.ifNull(amount, 0.0));

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(horizontal: Misc.ifNull(horizontal, 0.0),
  ///vertical: Misc.ifNull(vertical, 0.0));
  ///```
  static EdgeInsets symmetric({double horizontal, double vertical}) {
    return EdgeInsets.symmetric(
        horizontal: Misc.ifNull(horizontal, 0.0),
        vertical: Misc.ifNull(vertical, 0.0));
  }

  ///Do that:
  ///```dart
  ///EdgeInsets.only(
  ///  top: Misc.ifNull(top, 0.0),
  ///  bottom: Misc.ifNull(bottom, 0.0),
  ///  left: Misc.ifNull(left, 0.0),
  ///  right: Misc.ifNull(right, 0.0),
  ///)
  ///```
  static EdgeInsets only({
    double top,
    double bottom,
    double left,
    double right,
  }) {
    return EdgeInsets.only(
      top: Misc.ifNull(top, 0.0),
      bottom: Misc.ifNull(bottom, 0.0),
      left: Misc.ifNull(left, 0.0),
      right: Misc.ifNull(right, 0.0),
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
  ///  top: Radius.circular(Misc.ifNull(top, 0.0)),
  ///  bottom: Radius.circular(Misc.ifNull(bottom, 0.0)),
  ///)
  ///```
  static BorderRadius vertical({double top, double bottom}) {
    return BorderRadius.vertical(
      bottom: Radius.circular(Misc.ifNull(bottom, 0.0)),
      top: Radius.circular(Misc.ifNull(top, 0.0)),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  left: Radius.circular(Misc.ifNull(left, 0.0)),
  ///  right: Radius.circular(Misc.ifNull(right, 0.0)),
  ///)
  ///```
  static BorderRadius horizontal({double left, double right}) {
    return BorderRadius.horizontal(
      left: Radius.circular(Misc.ifNull(left, 0.0)),
      right: Radius.circular(Misc.ifNull(right, 0.0)),
    );
  }

  ///Do that:
  ///```dart
  ///BorderRadius.only(
  ///  topLeft: Radius.circular(Misc.ifNull(topLeft, 0.0)),
  ///  topRight: Radius.circular(Misc.ifNull(topRight, 0.0)),
  ///  bottomLeft: Radius.circular(Misc.ifNull(bottomLeft, 0.0)),
  ///  bottomRight: Radius.circular(Misc.ifNull(bottomRight, 0.0)),
  ///)
  /// ```
  static BorderRadius only({
    double topLeft,
    double topRight,
    double bottomLeft,
    double bottomRight,
  }) {
    return BorderRadius.only(
        topLeft: Radius.circular(Misc.ifNull(topLeft, 0.0)),
        topRight: Radius.circular(Misc.ifNull(topRight, 0.0)),
        bottomLeft: Radius.circular(Misc.ifNull(bottomLeft, 0.0)),
        bottomRight: Radius.circular(Misc.ifNull(bottomRight, 0.0)));
  }
}
