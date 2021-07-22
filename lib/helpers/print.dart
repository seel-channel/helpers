import 'dart:developer';

import 'package:flutter/material.dart';

class _AnsiColor {
  static const ansiEscape = '\x1B[';
  static const ansiDefault = '${ansiEscape}0m';

  int? _bg;
  late int _fg;

  final PrintColorStyle style;

  _AnsiColor(this.style) {
    _fg = _fromRgbColorTo8bitColor(style.foreground);
    if (style.background != null) {
      _bg = _fromRgbColorTo8bitColor(style.background!);
    }
  }

  int _fromRgbColorTo8bitColor(Color color) {
    return ((color.red / 255) * 5).floor() * 36 +
        ((color.green / 255) * 5).floor() * 6 +
        ((color.blue / 255) * 5).floor() +
        16;
  }

  @override
  String toString() {
    final sb = StringBuffer();

    sb.write('${ansiEscape}38;5;${_fg}m');
    if (style.bold) sb.write('${ansiEscape}1m');
    if (style.italic) sb.write('${ansiEscape}3m');
    if (style.underline) sb.write('${ansiEscape}4m');
    if (_bg != null) sb.write('${ansiEscape}48;5;${_bg}m');

    return sb.toString();
  }

  String call(Object? msg) => '${this}$msg$ansiDefault';
}

void printColor(Object? object, PrintColorStyle style) {
  final value = _AnsiColor(style)(object);
  if (style.prefix.isEmpty) {
    // ignore: avoid_print
    print(value);
  } else {
    log(value, name: style.prefix);
  }
}

class PrintColorStyle {
  final bool bold, underline, italic;
  final String prefix;
  final Color foreground;
  final Color? background;

  const PrintColorStyle({
    required this.foreground,
    this.background,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.prefix = "",
  });
}

void printWhite(Object? object, {bool bold = false}) =>
    printColor(object, PrintColorStyle(foreground: Colors.white, bold: bold));
void printBlack(Object? object, {bool bold = false}) =>
    printColor(object, PrintColorStyle(foreground: Colors.black, bold: bold));
void printBrown(Object? object, {bool bold = false}) =>
    printColor(object, PrintColorStyle(foreground: Colors.brown, bold: bold));

void printRed(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.redAccent, bold: bold));
void printBlue(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.blueAccent, bold: bold));
void printPink(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.pinkAccent, bold: bold));
void printLime(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.limeAccent, bold: bold));
void printTeal(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.tealAccent, bold: bold));
void printCyan(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.cyanAccent, bold: bold));
void printGreen(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.greenAccent, bold: bold));
void printAmber(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.amberAccent, bold: bold));
void printOrange(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.orangeAccent, bold: bold));
void printYellow(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.yellowAccent, bold: bold));
void printIndigo(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.indigoAccent, bold: bold));
void printPurple(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.purpleAccent, bold: bold));
void printBlueGrey(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.blueGrey, bold: bold));
void printDeepPurple(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.deepPurpleAccent, bold: bold));
void printLightGreen(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.lightGreenAccent, bold: bold));
void printLightBlue(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.lightBlueAccent, bold: bold));
void printDeepOrange(Object? object, {bool bold = false}) => printColor(
    object, PrintColorStyle(foreground: Colors.deepOrangeAccent, bold: bold));
