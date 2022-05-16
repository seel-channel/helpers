import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:helpers/helpers.dart';

class Misc {
  /// Creates a [Stopwatch] in stopped state with a zero elapsed count.
  ///
  /// The following example shows how to start a [Stopwatch]
  /// immediately after allocation.
  /// ```dart
  /// final misc = Misc()..startWatch();
  /// //Also it is same
  /// final misc = Misc.watch();
  /// ```
  Misc();

  /// Creates a [Stopwatch] in stopped state with a zero elapsed count.
  ///
  /// The following example shows how to start a [Stopwatch]
  /// immediately after allocation.
  /// ```dart
  /// final misc = Misc()..startWatch();
  /// ```
  factory Misc.stopwatch([String? prefix]) => Misc()..startWatch(prefix);

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

  static RegExp beetweenCharacterPattern([String character = "*"]) {
    return RegExp('(\\$character)(.*?)(\\$character)');
  }

  static int randomInt(int max) {
    return math.Random().nextInt(max);
  }

  static bool randomBool() {
    return math.Random().nextBool();
  }

  static double randomDouble() {
    return math.Random().nextDouble();
  }

  static String getFunctionReturnType(dynamic function) {
    final text = function.toString();
    final splitted = text.split(" ");
    final count = splitted.length;
    int index = -1;
    for (int i = 0; i < count; i++) {
      final item = splitted[i];
      if (item == "=>") {
        index = i;
        break;
      }
    }
    if (index >= 0 && index + 1 < count) return splitted[index + 1];
    return "";
  }

  static Future<Uint8List?> repaintBoundaryToImageBytes(
    RenderRepaintBoundary? boundary, {
    double pixelRatio = 3.0,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    final ui.Image? image = await boundary?.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData = await image?.toByteData(format: format);
    return byteData?.buffer.asUint8List();
  }

  static Future<Uint8List> widgetToImageBytes({
    required Widget child,
    Size? size,
    double? pixelRatio,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
    Duration delay = Duration.zero,
    BuildContext? context,
  }) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final PipelineOwner pipelineOwner = PipelineOwner();
    final Size logicalSize =
        size ?? ui.window.physicalSize / ui.window.devicePixelRatio;
    final RenderView renderView = RenderView(
      window: ui.window,
      child: RenderPositionedBox(child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: pixelRatio ?? 1.0,
      ),
    );

    int retryCounter = 3;
    bool isDirty = false;
    ui.Image? image;

    final BuildOwner buildOwner = BuildOwner(
      focusManager: FocusManager(),
      onBuildScheduled: () => isDirty = true,
    );

    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: context != null
            ? InheritedTheme.captureAll(
                context,
                MediaQuery(data: MediaQuery.of(context), child: child),
              )
            : child,
      ),
    ).attachToRenderTree(buildOwner);

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    void buildScope() {
      buildOwner
        ..buildScope(rootElement)
        ..finalizeTree();
      pipelineOwner
        ..flushLayout()
        ..flushCompositingBits()
        ..flushPaint();
    }

    buildScope();

    do {
      isDirty = false;
      image = await repaintBoundary.toImage(
        pixelRatio:
            pixelRatio ?? (ui.window.physicalSize.width / logicalSize.width),
      );
      await Future.delayed(delay);
      if (isDirty) buildScope();
      retryCounter--;
    } while (isDirty && retryCounter >= 0);
    final ByteData? byteData = await image.toByteData(format: format);
    return byteData!.buffer.asUint8List();
  }

  static bool isUsername(String text) =>
      RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$').hasMatch(text);

  static bool isUrl(String text) => RegExp(
          r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$")
      .hasMatch(text);

  static bool isBase64(String text) =>
      RegExp(r"^[-A-Za-z0-9+=]{1,50}|=[^=]|={3,}$").hasMatch(text);

  static double pow(double x, int exponent) {
    return math.pow(x, exponent).toDouble();
  }

  static double sqrt(double x) {
    return math.sqrt(x);
  }

  //CONVERSORS//
  static double? dynamicToDouble(dynamic value) {
    if (value != null) {
      return value is double
          ? value
          : value is int
              ? value * 1.0
              : value is String && value.isNotEmpty
                  ? double.tryParse(value.removeAllNotNumber(exclude: ["."]))
                  : null;
    }
    return null;
  }

  static int? dynamicToInt(dynamic value) {
    return dynamicToDouble(value)?.toInt();
  }

  static DateTime? dynamicToDateTime(dynamic value) {
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {}
    }
    return null;
  }

  static Map<K, V>? dynamicToMap<K, V>(dynamic value) {
    if (value == null) return null;
    if (value is Map) return Map<K, V>.from(value);
    if (value is List && value.isNotEmpty) {
      return dynamicToMap<K, V>(value.first);
    }
    return null;
  }

  static Map<String, dynamic>? dynamicToMapStringDynamic(dynamic value) {
    return dynamicToMap<String, dynamic>(value);
  }

  static T? dynamicMapToModel<T>(
    dynamic value,
    T Function(Map<String, dynamic> e) f,
  ) {
    final map = dynamicToMapStringDynamic(value);
    if (map != null) return f(map);
    return null;
  }

  static List<T> dynamicToListEnum<T>(dynamic list, List<T> values) {
    return dynamicToList(list, (x) => values[x as int]);
  }

  static List<T> dynamicToListMap<T>(
    dynamic list,
    T Function(Map<String, dynamic> e) f,
  ) {
    return dynamicToList<T>(
      list,
      (x) => f(Map<String, dynamic>.from(x as Map)),
    );
  }

  static List<T> dynamicToList<T>(
    dynamic list,
    T Function(dynamic e) f,
  ) {
    return List<T>.from((list as List?)?.map((x) => f(x)) ?? []);
  }

  static bool listEquals<T>(List<T>? a, List<T>? b) =>
      foundation.listEquals(a, b);

  static bool mapEquals<T, U>(Map<T, U>? a, Map<T, U>? b) =>
      foundation.mapEquals(a, b);

  static bool hasMapDifference<K, V>(
    Map<K, V> initialMap,
    Map<K, V> currentMap, {
    List<K> keys = const [],
  }) {
    if (keys.isEmpty) return !mapEquals(initialMap, currentMap);
    for (final key in keys) {
      final V? current = currentMap[key];
      final V? initial = initialMap[key];
      if (current != initial) {
        printRed(
          "Difference found on $key(initial, current): $initial(${initial.runtimeType}), $current(${current.runtimeType})",
        );
        return true;
      }
    }
    return false;
  }

  ///DO THAT:
  ///```dart
  /// final FocusScopeNode focus = FocusScope.of(context);
  /// if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
  /// ```
  static void dismissKeyboard(BuildContext context) {
    final FocusScopeNode focus = FocusScope.of(context);
    if (focus.hasFocus) {
      focus.unfocus();
    } else {
      focus.requestFocus(FocusNode());
    }
  }

  static ListDifference<T> detectListDifferences<T>({
    List<T> initialValues = const [],
    List<T> currentValues = const [],
    bool Function(List<T>, T)? containsValidator,
  }) {
    return ListDifference(
      initialValues: initialValues,
      currentValues: currentValues,
      containsValidator: containsValidator,
    );
  }

  /// Starts the [Stopwatch].
  ///
  /// The [elapsed] count is increasing monotonically. If the [Stopwatch] has
  /// been stopped, then calling start again restarts it without resetting the
  /// [elapsed] count.
  ///
  /// If the [Stopwatch] is currently running, then calling start does nothing.
  void startWatch([String? prefix]) {
    _prefix ??= prefix;
    log("Initialized", name: _prefix ?? "");
    _init = DateTime.now().toUtc();
  }

  void showElapsed() {
    final int ms = elapsed.inMilliseconds;
    printAmber("Completed in ${ms / 1000} seconds", prefix: _prefix ?? "");
  }

  Duration get elapsed =>
      DateTime.now().toUtc().difference(_init ?? DateTime.now().toUtc());

  static double lerpDouble(num a, num b, double t) {
    return ui.lerpDouble(a, b, t)!;
  }

  static double degreesToRadians(double degrees) {
    const double degrees2radians = math.pi / 180.0;
    return degrees * degrees2radians;
  }

  static Color colorFromHex(String hex) {
    return ColorExtension.fromHex(hex);
  }

  ///DO THAT:
  ///```dart
  /// WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  /// ```
  static void onLayoutRendered(void Function() callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }

  ///DO THAT:
  ///```dart
  /// WidgetsBinding.instance.endOfFrame.then((_) => callback());
  /// ```
  static void afterFirstLayout(void Function() callback) {
    WidgetsBinding.instance.endOfFrame.then((_) => callback());
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
