import 'dart:developer';

import 'package:flutter/material.dart';

class _AnsiColor {
  _AnsiColor(this.style) {
    _fg = _fromRgbColorTo8bitColor(style.foreground);
    if (style.background != null) {
      _bg = _fromRgbColorTo8bitColor(style.background!);
    }
  }

  static const ansiDefault = '${ansiEscape}0m';
  static const ansiEscape = '\x1B[';

  final PrintColorStyle style;

  int? _bg;
  late int _fg;

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

  int _fromRgbColorTo8bitColor(Color color) {
    return ((color.red / 255) * 5).floor() * 36 +
        ((color.green / 255) * 5).floor() * 6 +
        ((color.blue / 255) * 5).floor() +
        16;
  }

  String message(Object? msg) => '${this}$msg$ansiDefault';
}

void printColor(Object? object, PrintColorStyle style) {
  final value = _AnsiColor(style).message(object);
  if (style.prefix.isEmpty) {
    debugPrint(value);
  } else {
    log(value, name: style.prefix.isEmpty ? "LOG" : style.prefix);
  }
}

class PrintColorStyle {
  const PrintColorStyle({
    this.background,
    this.bold = false,
    this.foreground = Colors.blue,
    this.italic = false,
    this.prefix = "",
    this.underline = false,
  });

  final Color? background;
  final bool bold;
  final Color foreground;
  final bool italic;
  final String prefix;
  final bool underline;
}

void printWhite(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.white,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printBlack(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.black,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printBrown(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.brown,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );

void printRed(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.redAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printBlue(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.blueAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printPink(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.pinkAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printLime(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.limeAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printTeal(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.tealAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printCyan(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.cyanAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printGreen(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.greenAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printAmber(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.amberAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printOrange(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.orangeAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printYellow(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.yellowAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printIndigo(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.indigoAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printPurple(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.purpleAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printBlueGrey(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.blueGrey,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printDeepPurple(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.deepPurpleAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printLightGreen(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.lightGreenAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printLightBlue(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.lightBlueAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
void printDeepOrange(
  Object? object, {
  bool bold = false,
  bool italic = false,
  bool underline = false,
  String prefix = "",
}) =>
    printColor(
      object,
      PrintColorStyle(
        foreground: Colors.deepOrangeAccent,
        bold: bold,
        prefix: prefix,
        underline: underline,
        italic: italic,
      ),
    );
