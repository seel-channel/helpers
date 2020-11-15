# helpers

## My other APIs

- [Scroll Navigation](https://pub.dev/packages/scroll_navigation)

<br>

## Features

- Better readability in code.
- More intuitive statements.
- Faster when declaring.
- Shorten long and tedious statements.

<br>

## Table of Contents

- [Comparative](#Comparative)
  - [Default declaration](#Default-declaration)
  - [Helpers declaration](#Helpers-declaration)
- [Misc Classes](#Misc-Helpers)
  - [Misc](#Misc-Class)
  - [SystemOverlay](#SystemOverlay-Class)
  - [SystemOrientation](#SystemOrientation-Class)
  - [GetColor](#GetColor-Class)
- [PushRoute Class](#PushRoute-Class)
- [Widgets Helpers](#Widgets-Helpers)
  - [TextDesigned](#TextDesigned-Widget)
  - [RemoveScrollGlow](#RemoveScrollGlow-Widget)
  - [DismissKeyboard](#DismissKeyboard-Widget)
  - [BooleanTween](#BooleanTween-Widget)
  - [OpacityTransition](#GetContext-Class)
- [Size Classes](#Size-Helpers)
  - [GetContext](#GetContext-ClasS)
  - [GetKey](#GetKey-Class)
  - [Margin](#Margin-Class)
  - [EdgeRadius](#EdgeRadius-Class)

<br><br>

# Comparative

## **Default declaration:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        accentColor: Color(0xFF0253f5),
        primaryColor: Color(0xFF37393d),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      title: 'HELPERS EXAMPLE',
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, key) {
            return Center(
              child: Text(
                "HELLO ${key + 1}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

<br>

## **Helpers declaration:**

```dart
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Misc.setSystemOrientation(SystemOrientation.portraitUp);
    Misc.setSystemOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        accentColor: Color(0xFF0253f5),
        primaryColor: Color(0xFF37393d),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      title: 'HELPERS EXAMPLE',
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetColor.scaffoldBackground(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GetColor.accent(context),
        onPressed: () => setState(() => visible = !visible),
      ),
      body: RemoveScrollGlow(
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, key) {
            return OpacityTransition(
              visible: visible,
              child: Center(
                child: TextDesigned(
                  "HELLO ${key + 1}",
                  bold: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

<br><br>

# Documentation

## Misc Helpers

- ### **Misc Class:**
  It is a simplification of many instructions.

```dart
    //THEME INSTRUCTIONS
    Misc.theme(context);
    Theme.of(context);

    Misc.textTheme(context);
    Theme.of(context).textTheme;


    //CALLBACKS INSTRUCTIONS
    Misc.onLayoutRendered(() => null);
    WidgetsBinding.instance.addPostFrameCallback((_) => null);

    Misc.delayed(200, () => null);
    Future.delayed(Duration(milliseconds: 200), () => null)


    //IF SENTENCES INSTRUCTION
    double height = Misc.ifNull(widget.height, 0.0);
    double height = widget.height != null ? widget.height : 0.0;


    //TEXT INSTRUCTIONS
    Text(Misc.loremIpsum());
    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

    Text(Misc.extendedLoremIpsum());
    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
        "Ut enim ad minim veniam, quis nostrud exercitation " +
        "ullamco laboris nisi ut aliquip ex ea commodo consequat.");


    //SYSTEM INSTRUCTIONS (NOTE: SystemChrome NEED IMPORT FLUTTER SERVICES)
    Misc.setSystemOverlayStyle(...);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(...));

    Misc.setSystemOrientation(SystemOrientation.values);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values)

```

<br>

- ### **SystemOverlay Class:**

  This is a simplification of the _List type: SystemUiOverlay_ statement. It is used for the _Misc.setSystemOverlayStyle()_ statement.

  **IMPROVEMENT**: By using the SystemOverlay you will not need to import _SystemChrome, DeviceOrientation_ from the flutter services.

```dart
    //INSTRUCTIONS
    SystemOverlay.none;
    List();

    SystemOverlay.values;
    SystemUiOverlay.values

    SystemOverlay.top;
    [SystemUiOverlay.top]

    SystemOverlay.bottom;
    [SystemUiOverlay.bottom]
```

<br>

- ### **SystemOrientation Class:**

  This is a simplification of the _List type: DeviceOrientation_ statement. It is used for the _Misc.setSystemOrientation()_ statement.

  **IMPROVEMENT**: By using the SystemOrientation you will not need to import _SystemChrome, DeviceOrientation_ from the flutter services.

```dart
    //INSTRUCTIONS
    SystemOrientation.none;
    DeviceOrientation.

    SystemOrientation.values;
    DeviceOrientation.values;

    SystemOrientation.portraitUp;
    [DeviceOrientation.portraitUp];

    SystemOrientation.portraitDown;
    [DeviceOrientation.portraitDown];

    SystemOrientation.landscapeLeft;
    [DeviceOrientation.landscapeLeft];

    SystemOrientation.landscapeRight;
    [DeviceOrientation.landscapeRight]
```

<br>

- ### **GetColor Class:**

  It is a simplification of the _Theme.of(context)_ statement.

```dart
    //INSTRUCTIONS
    GetColor.primary(context);
    Theme.of(context).primaryColor;

    GetColor.primaryLight(context);
    Theme.of(context).primaryColorLight;

    GetColor.accent(context);
    Theme.of(context).accentColor;

    GetColor.disabled(context);
    Theme.of(context).disabledColor;

    GetColor.scaffoldBackground(context);
    Theme.of(context).scaffoldBackgroundColor;

    ... //+20 COLORS
```

<br>

---

<br>

## Routes Helpers

- ### **PushRoute Class:**
  It is a simplification of the _Navigator.push()_ statement.

```dart
    Widget page;
    BuildContext context;

    //PAGE INSTRUCTION
    PushRoute.page(context, page);
    Navigator.push(context,
      withTransition
          ? MaterialPageRoute(builder: (_) => page)
          : PageRouteBuilder(pageBuilder: (_, __, ___) => page))

    //TRANSPARENT PAGE INSTRUCTION
    PushRoute.transparentPage(context, page)
    Navigator.push(context,
      TransparentRoute(builder: (_) => page, transitionMs: transitionMs))
```

<br>

---

<br>

## Widgets Helpers

- ### **TextDesigned Widget:**
  **IMPROVEMENT**: If you don't assign it a color, it will automatically select the _Theme.of(context).primaryColor_.

```dart
    TextDesigned(
      "Hello",
      size: 20,
      bold: true,
      uppercase: true,
      underline: true,
      letterSpacing: 1.0
      color: Colors.white,
    );

    Text(
      "Hello".toUpperCase(),
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        letterSpacing: 1.0,
      ),
    );

```

<br>

- ### **RemoveScrollGlow Widget:**
  Eliminate the Splash Effect or Glow Effect when reaching the limit of a PageView, ScrollView, ListView, etc.

```dart
    //WIDGET DECLARATION
    RemoveScrollGlow(child: PageView(...));

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: PageView(...),
    );
```

<br>

- ### **DismissKeyboard Widget:**
  Tapping on a Widget will apply the FocusScope to it and hide the keyboard.

```dart
    //WIDGET DECLARATION
    DismissKeyboard(child: Container());

    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
      },
      child: Container(),
    );
```

<br>

- ### **BooleanTween Widget:**
  It is an AnimatedBuilder. If it is **TRUE**, it will execute the Tween from _begin to end (controller.forward())_, if it is **FALSE** it will execute the Tween from _end to begin (controller.reverse())_.

```dart
    bool animate = true;

    BooleanTween(
      animate: animate,
      tween: ColorTween(begin: Colors.blue, end: Colors.red),
      builder: (dynamic color) {
        return Container(color: color);
      },
    );
```

<br>

- ### **OpacityTransition Widget:**
  Show or hide a Widget with an opacity transition from a Boolean variable.

```dart
    //WIDGET DECLARATION
    bool visible = true;

    OpacityTransition(
      visible: visible,
      child: Container(),
      curve: Curves.linear, //OPTIONAL
      duration: Duration(milliseconds: 200) //OPTIONAL
    );

    return BooleanTween(
      curve: widget.curve,
      animate: widget.visible,
      duration: widget.duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (opacity) {
        return Opacity(
          opacity: opacity,
          child: opacity > 0.0 ? widget.child : null,
        );
      },
    );
```

<br>

---

<br>

## Size Helpers

- ### **GetContext Class:**
  It is a simplification of the _MediaQuery.of(context)_ statement.

```dart
    BuildContext context;

    //INSTRUCTIONS
    GetContext.width(context);
    MediaQuery.of(context).size.width;

    GetContext.height(context);
    MediaQuery.of(context).size.height;

    GetContext.padding(context);
    MediaQuery.of(context).padding;

    GetContext.size(context);
    MediaQuery.of(context).size;

    GetContext.data(context);
    MediaQuery.of(context);

    ... //+10 MEDIAQUERIES
```

<br>

- ### **GetKey Class:**
  It is a simplification of the _key.currentContext_ statement.

```dart
    GlobalKey key = GlobalKey();

    //INSTRUCTIONS
    GetKey.width(key);
    key.currentContext.size.width;

    GetKey.height(key);
    key.currentContext.size.height;

    GetKey.size(key);
    key.currentContext.size;

    GetKey.context(key);
    key.currentContext;
```

<br>

- ### **Margin Class:**
  It is a simplification of the _EdgeInsets_ statement.

```dart
    double amount = 2.0;

    //INSTRUCTIONS
    Margin.zero;
    EdgeInsets.zero;

    Margin.all(amount);
    EdgeInsets.all(amount);


    //SYMETRIC
    Margin.vertical(amount);
    EdgeInsets.symmetric(vertical: amount);

    Margin.horizontal(amount);
    EdgeInsets.symmetric(horizontal: amount);

    Margin.symmetric(...);
    EdgeInsets.symmetric(...);


    //ONLY
    Margin.top(amount);
    EdgeInsets.only(top: amount);

    Margin.bottom(amount);
    EdgeInsets.only(bottom: amount);

    Margin.left(amount);
    EdgeInsets.only(left: amount);

    Margin.right(amount);
    EdgeInsets.only(right: amount);

    Margin.only(...);
    EdgeInsets.only(...);
```

<br>

- ### **EdgeRadius Class:**
  It is a simplification of the _BorderRadius_ statement.

```dart
    double amount = 2.0;

    //INSTRUCTIONS
    EdgeRadius.zero;
    BorderRadius.zero;

    EdgeRadius.all(amount);
    BorderRadius.all(Radius.circular(amount));


    //SYMETRIC
    Margin.vertical(top: amount, bottom: amount);
    BorderRadius.vertical(
      top: Radius.circular(top),
      bottom: Radius.circular(bottom));

    Margin.horizontal(left: amount, right: amount);
    BorderRadius.horizontal(
      left: Radius.circular(left),
      right: Radius.circular(right));


    //ONLY
    Margin.only(
      topLeft: amount,
      topRight: amount,
      bottomLeft: amount,
      bottomRight: amount);
    BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight));
```
