import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class TextDesigned extends StatelessWidget {
  const TextDesigned(
    this.text, {
    Key key,
    this.color,
    this.size = 16,
    this.bold = false,
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
      (uppercase ? text.toUpperCase() : text) ?? "",
      textAlign: justify
          ? TextAlign.justify
          : center
              ? TextAlign.center
              : TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

class Headline1 extends StatelessWidget {
  ///`Text Widget` with the **headline1** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline1);
  ///```
  const Headline1(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline1** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline1.merge(style));
  }
}

class Headline2 extends StatelessWidget {
  ///`Text Widget` with the **headline2** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline2);
  ///```
  const Headline2(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline2** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline2.merge(style));
  }
}

class Headline3 extends StatelessWidget {
  ///`Text Widget` with the **headline3** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline3);
  ///```
  const Headline3(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline3** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline3.merge(style));
  }
}

class Headline4 extends StatelessWidget {
  ///`Text Widget` with the **headline4** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline4);
  ///```
  const Headline4(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline4** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline4.merge(style));
  }
}

class Headline5 extends StatelessWidget {
  ///`Text Widget` with the **headline5** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline5);
  ///```
  const Headline5(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline5** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline5.merge(style));
  }
}

class Headline6 extends StatelessWidget {
  ///`Text Widget` with the **headline6** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).headline6);
  ///```
  const Headline6(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **headline6** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).headline6.merge(style));
  }
}

class Subtitle1 extends StatelessWidget {
  ///`Text Widget` with the **subtitle1** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).subtitle1);
  ///```
  const Subtitle1(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **subtitle1** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).subtitle1.merge(style));
  }
}

class Subtitle2 extends StatelessWidget {
  ///`Text Widget` with the **subtitle2** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).subtitle2);
  ///```
  const Subtitle2(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **subtitle2** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).subtitle2.merge(style));
  }
}

class BodyText1 extends StatelessWidget {
  ///`Text Widget` with the **bodyText1** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).bodyText1);
  ///```
  const BodyText1(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **bodyText1** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).bodyText1.merge(style));
  }
}

class BodyText2 extends StatelessWidget {
  ///`Text Widget` with the **bodyText2** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).bodyText2);
  ///```
  const BodyText2(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **bodyText2** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).bodyText2.merge(style));
  }
}

class CaptionText extends StatelessWidget {
  ///`Text Widget` with the **caption** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).caption);
  ///```
  const CaptionText(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **caption** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).caption.merge(style));
  }
}

class ButtonText extends StatelessWidget {
  ///`Text Widget` with the **button** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).button);
  ///```
  const ButtonText(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **button** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).button.merge(style));
  }
}

class OverlineText extends StatelessWidget {
  ///`Text Widget` with the **overline** theme style.
  ///```dart
  ///return Text(text, style: Misc.textTheme(context).overline);
  ///```
  const OverlineText(this.text, {Key key, this.style}) : super(key: key);

  ///The text to display.
  final String text;

  ///Returns a new text style that is a combination of this **overline** theme style and the given [other] style.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Misc.textTheme(context).overline.merge(style));
  }
}
