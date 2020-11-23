import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class TextDesigned extends StatelessWidget {
  const TextDesigned(
    this.text, {
    Key key,
    this.size = 16,
    this.bold = false,
    this.color,
    this.italic = false,
    this.center = false,
    this.justify = false,
    this.uppercase = false,
    this.underline = false,
    this.letterSpacing = 0,
  }) : super(key: key);

  final Color color;
  final String text;
  final double size, letterSpacing;
  final bool bold, italic, justify, center, uppercase, underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      Misc.ifNull(uppercase ? text.toUpperCase() : text, ""),
      textAlign: justify
          ? TextAlign.justify
          : center
              ? TextAlign.center
              : TextAlign.start,
      style: TextStyle(
        fontSize: size,
        color: Misc.ifNull(
          color,
          Misc.ifNull(Misc.theme(context).primaryColor, Colors.black),
        ),
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

class RemoveScrollGlow extends StatelessWidget {
  ///Eliminate the Splash Effect or Glow Effect when reaching
  ///the limit of a PageView, ScrollView, ListView, etc.
  const RemoveScrollGlow({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      child: child,
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      },
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  ///Tapping on a Widget will apply the FocusScope to it and hide the keyboard.
  const DismissKeyboard({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
