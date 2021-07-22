import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Misc {
  ///DO THAT:
  ///```dart
  ///  WidgetsBinding.instance?.endOfFrame.then((_) => callback);
  /// ```
  static void onLayoutRendered(void Function() callback) {
    WidgetsBinding.instance?.endOfFrame.then((_) => callback);
  }

  ///```dart
  ///return "Lorem ipsum dolor sit amet, consectetur
  ///adipiscing elit, sed do eiusmod tempor incididunt
  ///ut labore et dolore magna aliqua."
  ///```
  static String loremIpsum() {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  }

  ///```dart
  /// return "Lorem ipsum dolor sit amet, consectetur
  /// adipiscing elit, sed do eiusmod tempor incididunt
  /// ut labore et dolore magna aliqua. Ut enim ad minim
  /// veniam, quis nostrud exercitation ullamco laboris
  /// nisi ut aliquip ex ea commodo consequat."
  /// ```
  static String extendedLoremIpsum() {
    // ignore: prefer_interpolation_to_compose_strings
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
        "Ut enim ad minim veniam, quis nostrud exercitation " +
        "ullamco laboris nisi ut aliquip ex ea commodo consequat.";
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
  static Future<Null> wait(int milliseconds) async {
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
  ///return [SystemUiOverlay.top]
  ///```
  static List<SystemUiOverlay> top = [SystemUiOverlay.top];

  ///```dart
  ///return SystemUiOverlay.values
  ///```
  static List<SystemUiOverlay> values = SystemUiOverlay.values;

  ///```dart
  ///return [SystemUiOverlay.bottom]
  ///```
  static List<SystemUiOverlay> bottom = [SystemUiOverlay.bottom];
}

// ignore: avoid_classes_with_only_static_members
abstract class SystemOrientation {
  ///```dart
  ///return [DeviceOrientation.values]
  ///```
  static List<DeviceOrientation> values = DeviceOrientation.values;

  ///```dart
  ///return [DeviceOrientation.portraitUp]
  ///```
  static List<DeviceOrientation> portraitUp = [DeviceOrientation.portraitUp];

  ///```dart
  ///return [DeviceOrientation.portraitDown]
  ///```
  static List<DeviceOrientation> portraitDown = [
    DeviceOrientation.portraitDown
  ];

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
}
