import 'package:flutter/material.dart';

class _AnsiColor {
  static const ansiEscape = '\x1B[';
  static const ansiDefault = '${ansiEscape}0m';

  int? bg;
  late int fg;

  _AnsiColor(Color foreground, [Color? background]) {
    fg = _fromRgbColorTo8bitColor(foreground);
    if (background != null) bg = _fromRgbColorTo8bitColor(background);
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

    sb.write('${ansiEscape}38;5;${fg}m');
    if (bg != null) sb.write('${ansiEscape}48;5;${bg}m');

    return sb.toString();
  }

  String call(Object msg) => '${this}$msg$ansiDefault';
}

void printColor(Object object, Color foreground, [Color? background]) {
  print(_AnsiColor(foreground, background)(object));
}

void printWhite(Object object) => printColor(object, Colors.white);
void printBlack(Object object) => printColor(object, Colors.black);
void printBrown(Object object) => printColor(object, Colors.brown);
void printRed(Object object) => printColor(object, Colors.redAccent);
void printBlue(Object object) => printColor(object, Colors.blueAccent);
void printPink(Object object) => printColor(object, Colors.pinkAccent);
void printLime(Object object) => printColor(object, Colors.limeAccent);
void printTeal(Object object) => printColor(object, Colors.tealAccent);
void printCyan(Object object) => printColor(object, Colors.cyanAccent);
void printGreen(Object object) => printColor(object, Colors.greenAccent);
void printAmber(Object object) => printColor(object, Colors.amberAccent);
void printBlueGrey(Object object) => printColor(object, Colors.blueGrey);
void printOrange(Object object) => printColor(object, Colors.orangeAccent);
void printYellow(Object object) => printColor(object, Colors.yellowAccent);
void printIndigo(Object object) => printColor(object, Colors.indigoAccent);
void printPurple(Object object) => printColor(object, Colors.purpleAccent);

void printDeepPurple(Object object) =>
    printColor(object, Colors.deepPurpleAccent);

void printLightGreen(Object object) =>
    printColor(object, Colors.lightGreenAccent);

void printLightBlue(Object object) =>
    printColor(object, Colors.lightBlueAccent);

void printDeepOrange(Object object) =>
    printColor(object, Colors.deepOrangeAccent);
