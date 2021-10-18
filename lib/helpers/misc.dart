import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Misc {
  ///```dart
  /// return "Lorem ipsum dolor sit amet, consectetur
  /// adipiscing elit, sed do eiusmod tempor incididunt
  /// ut labore et dolore magna aliqua. Ut enim ad minim
  /// veniam, quis nostrud exercitation ullamco laboris
  /// nisi ut aliquip ex ea commodo consequat."
  /// ```
  static const String extendedLoremIpsum =
      // ignore: prefer_interpolation_to_compose_strings
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
          "Ut enim ad minim veniam, quis nostrud exercitation " +
          "ullamco laboris nisi ut aliquip ex ea commodo consequat.";

  ///```dart
  ///return "Lorem ipsum dolor sit amet, consectetur
  ///adipiscing elit, sed do eiusmod tempor incididunt
  ///ut labore et dolore magna aliqua."
  ///```
  static const String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  static const int maxInt = 9223372036854775807;

  DateTime? _init;
  String? _prefix;

  static bool isEmail(String text) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(text);

  static bool isNumericOnly(String text) => RegExp(r'^\d+$').hasMatch(text);

  static bool isPhoneNumber(String text) {
    if (text.length > 16 || text.length < 9) return false;
    return RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(text);
  }

  static bool isUsername(String text) =>
      RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$').hasMatch(text);

  static bool isUrl(String text) => RegExp(
          r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$")
      .hasMatch(text);

  static bool isBase64(String text) =>
      RegExp(r"^[-A-Za-z0-9+=]{1,50}|=[^=]|={3,}$").hasMatch(text);

  static double? dynamicToDouble(dynamic value) {
    if (value != null) {
      return value is int
          ? value * 1.0
          : value is double
              ? value
              : value is String
                  ? double.tryParse(value)
                  : null;
    }
  }

  static int? dynamicToInt(dynamic value) {
    return dynamicToDouble(value)?.toInt();
  }

  ///Similar to `console.time("TIMER")` (javascript)
  void timeStart([String prefix = "TIMER"]) {
    _prefix = prefix;
    log("Initialized", name: _prefix ?? "");
    _init = DateTime.now();
  }

  ///Similar to `console.timeEnd()` (javascript)
  void timeStop() {
    final int ms =
        DateTime.now().difference(_init ?? DateTime.now()).inMilliseconds;
    log("Completed in ${ms / 1000} seconds", name: _prefix ?? "");
  }

  static double lerpDouble(num a, num b, double t) {
    return ui.lerpDouble(a, b, t)!;
  }

  static double degreesToRadians(double degrees) {
    final double degrees2radians = math.pi / 180.0;
    return degrees * degrees2radians;
  }

  ///DO THAT:
  ///```dart
  /// WidgetsBinding.instance?.addPostFrameCallback((d) => callback());
  /// ```
  static void onLayoutRendered(void Function() callback) {
    WidgetsBinding.instance?.addPostFrameCallback((d) => callback());
  }

  ///DO THAT:
  ///```dart
  ///Future.delayed(
  ///  Duration(milliseconds: milliseconds),
  ///  () => callback(),
  ///);
  ///```
  static Future<void> delayed(
    int milliseconds,
    void Function() callback,
  ) async {
    await Future.delayed(
      Duration(milliseconds: milliseconds),
      () => callback(),
    );
  }

  /// Create a timer that will execute an instruction after an amount of
  /// milliseconds. The goodness and difference it has with the Misc.delayed() is
  /// that has the ability to be canceled and thus the callback will not be executed.
  ///
  ///DO THAT:
  ///```dart
  ///return Timer(Duration(milliseconds: milliseconds), callback);
  ///```
  ///
  static Timer timer(int milliseconds, void Function() callback) {
    return Timer(Duration(milliseconds: milliseconds), callback);
  }

  /// Create a periodic timer that executes a callback every few milliseconds.
  ///DO THAT:
  ///```dart
  ///return Timer.periodic(Duration(milliseconds: milliseconds), (_) => callback());
  ///````
  static Timer periodic(int milliseconds, void Function() callback) {
    return Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) => callback(),
    );
  }

  /// Allows you to pause instructions for a set time.
  ///```dart
  ///await Future.delayed(Duration(milliseconds: milliseconds), () {});
  ///````
  ///-
  ///-
  ///EXAMPLE:
  ///
  /// Once the state has changed, wait for the animation to finish,
  /// which will last 400 milliseconds and then close the context
  ///```dart
  ///   setState(() => showWidget = false);
  ///   await Misc.wait(400);
  ///   Navigator.pop(context);
  ///````
  ///
  static Future<void> wait(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds), () {});
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
  ///await SystemChrome.setEnabledSystemUIMode(mode, overlays: overlays);
  ///```
  static Future<void> setSystemOverlay(
    List<SystemUiOverlay> overlays, {
    SystemUiMode mode = SystemUiMode.manual,
  }) async {
    await SystemChrome.setEnabledSystemUIMode(
      mode,
      overlays: overlays,
    );
  }

  ///DO THAT:
  ///```dart
  ///SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(...));
  ///```
  static void setSystemOverlayStyle({
    Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness,
    Brightness? navigationBarIconBrightness,
    Color? statusBarColor,
    Color? navigationBarColor,
    Color? navigationBarDividerColor,
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

// ignore: avoid_classes_with_only_static_members
abstract class SystemOverlay {
  ///```dart
  ///return [SystemUiOverlay.bottom]
  ///```
  static List<SystemUiOverlay> bottom = [SystemUiOverlay.bottom];

  ///```dart
  ///return [SystemUiOverlay.top]
  ///```
  static List<SystemUiOverlay> top = [SystemUiOverlay.top];

  ///```dart
  ///return SystemUiOverlay.values
  ///```
  static List<SystemUiOverlay> values = SystemUiOverlay.values;
}

// ignore: avoid_classes_with_only_static_members
abstract class SystemOrientation {
  ///```dart
  ///return [DeviceOrientation.landscapeLeft]
  ///```
  static List<DeviceOrientation> landscapeLeft = [
    DeviceOrientation.landscapeLeft
  ];

  ///```dart
  ///return [DeviceOrientation.landscapeRight]
  ///```
  static List<DeviceOrientation> landscapeRight = [
    DeviceOrientation.landscapeRight
  ];

  ///```dart
  ///return [DeviceOrientation.portraitDown]
  ///```
  static List<DeviceOrientation> portraitDown = [
    DeviceOrientation.portraitDown
  ];

  ///```dart
  ///return [DeviceOrientation.portraitUp]
  ///```
  static List<DeviceOrientation> portraitUp = [DeviceOrientation.portraitUp];

  ///```dart
  ///return [DeviceOrientation.values]
  ///```
  static List<DeviceOrientation> values = DeviceOrientation.values;
}
