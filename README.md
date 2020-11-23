# helpers

## My other APIs

- [Scroll Navigation](https://pub.dev/packages/scroll_navigation)
- [Video Viewer](https://pub.dev/packages/video_viewer)

<br>

## Features

- Better readability in code.
- More intuitive statements.
- Faster when declaring.
- Shorten long and tedious statements.

<br>

## Table of Contents

- [Comparative](#comparative)
  - [Default declaration](#default-declaration)
  - [Helpers declaration](#helpers-declaration)
- [Misc Classes](#misc-helpers)
  - [Misc](#misc-class)
  - [SystemOverlay](#systemoverlay-class)
  - [SystemOrientation](#systemorientation-class)
  - [GetColor](#getcolor-class)
- [PushRoute Class](#pushroute-class)
- [Widgets Helpers](#widgets-helpers)
  - [TextDesigned](#textdesigned-widget)
  - [RemoveScrollGlow](#removescrollglow-widget)
  - [DismissKeyboard](#dismisskeyboard-widget)
- [Transition Helpers](#transition-helpers)
  - [BooleanTween](#booleantween-widget)
  - [OpacityTransition](#opacitytransition-widget)
  - [SwipeTransition Widget](#swipetransition-widget)
- [Size Classes](#size-helpers)
  - [GetContext](#getcontext-class)
  - [GetKey](#getkey-class)
  - [Margin](#margin-class)
  - [EdgeRadius](#edgeradius-class)

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
    Misc.setSystemOrientation(SystemOrientation.portraitUp); //Helper
    Misc.setSystemOverlayStyle( //Helper
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
      backgroundColor: GetColor.scaffoldBackground(context), //Helper
      floatingActionButton: FloatingActionButton(
        backgroundColor: GetColor.accent(context), //Helper
        onPressed: () => setState(() => visible = !visible),
      ),
      body: RemoveScrollGlow( //Helper
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, key) {
            return OpacityTransition( //Helper
              visible: visible,
              child: Center(
                child: TextDesigned( //Helper
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
    double milliseconds = 200;

    //THEME
    Misc.theme(context);          //Helper
    Theme.of(context);

    Misc.textTheme(context);      //Helper
    Theme.of(context).textTheme;


    //CALLBACKS
    Misc.onLayoutRendered(() {}); //Helper
    WidgetsBinding.instance.addPostFrameCallback((_) {});


    //TIMER-ASYNC
    Misc.delayed(milliseconds, () {});  //Helper
    Future.delayed(Duration(milliseconds: milliseconds), () {});

    Misc.timer(milliseconds, () {});    //Helper
    Timer(Duration(milliseconds: milliseconds), () {});

    Misc.periodic(milliseconds, () {}); //Helper
    Timer.periodic(Duration(milliseconds: milliseconds), () {});

    await Misc.wait(milliseconds);      //Helper
    await Future.delayed(Duration(milliseconds: milliseconds), () {});


    //IF SENTENCES
    double height = Misc.ifNull(widget.height, 0.0);    //Helper
    double height = widget.height != null ? widget.height : 0.0;


    //TEXT
    Text(Misc.loremIpsum());
    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

    Text(Misc.extendedLoremIpsum());
    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
        "Ut enim ad minim veniam, quis nostrud exercitation " +
        "ullamco laboris nisi ut aliquip ex ea commodo consequat.");


    //SYSTEM (NOTE: SystemChrome NEED IMPORT FLUTTER SERVICES)
    Misc.setSystemOverlayStyle(...); //Helper
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(...));

    Misc.setSystemOverlay(SystemOverlay.portraitUp);     //Helper
    SystemChrome.setSystemUIOverlay([SystemUiOverlay.portraitUp]);

    Misc.setSystemOrientation(SystemOrientation.values); //Helper
    SystemChrome.setPreferredOrientations(DeviceOrientation.values)

```

<br>

- ### **SystemOverlay Class:**

  This is a simplification of the _List type: SystemUiOverlay_ statement. It is used for the _Misc.setSystemOverlayStyle()_ statement.
  **IMPROVEMENT**: By using the SystemOverlay you will not need to import _SystemChrome, DeviceOrientation_ from the flutter services.

```dart
    //INSTRUCTIONS
    SystemOverlay.none;   //Helper
    List();

    SystemOverlay.values; //Helper
    SystemUiOverlay.values

    SystemOverlay.top;    //Helper
    [SystemUiOverlay.top]

    SystemOverlay.bottom; //Helper
    [SystemUiOverlay.bottom]
```

<br>

- ### **SystemOrientation Class:**

  This is a simplification of the _List type: DeviceOrientation_ statement. It is used for the _Misc.setSystemOrientation()_ statement.
  **IMPROVEMENT**: By using the SystemOrientation you will not need to import _SystemChrome, DeviceOrientation_ from the flutter services.

```dart
    //INSTRUCTIONS
    SystemOrientation.values;         //Helper
    DeviceOrientation.values;

    SystemOrientation.portraitUp;     //Helper
    [DeviceOrientation.portraitUp];

    SystemOrientation.portraitDown;   //Helper
    [DeviceOrientation.portraitDown];

    SystemOrientation.landscapeLeft;  //Helper
    [DeviceOrientation.landscapeLeft];

    SystemOrientation.landscapeRight; //Helper
    [DeviceOrientation.landscapeRight]
```

<br>

- ### **GetColor Class:**

  It is a simplification of the _Theme.of(context)_ statement.

```dart
    GetColor.primary(context);      //Helper
    Theme.of(context).primaryColor;

    GetColor.primaryLight(context); //Helper
    Theme.of(context).primaryColorLight;

    GetColor.accent(context);       //Helper
    Theme.of(context).accentColor;

    GetColor.disabled(context);           //Helper
    Theme.of(context).disabledColor;

    GetColor.scaffoldBackground(context); //Helper
    Theme.of(context).scaffoldBackgroundColor;

    ... //+20 COLORS
```

<br>

---

<br>

## Routes Helpers

- ### **PushRoute Class:**
  It is a simplification of the _Navigator.push()_ statement.
  **TranparentPage** solved the bug of MaterialPageRoute with a black background

```dart
    Widget page;
    BuildContext context;


    PushRoute.page(context, page); //Helper
    Navigator.push(context,
      withTransition
          ? MaterialPageRoute(builder: (_) => page)
          : PageRouteBuilder(pageBuilder: (_, __, ___) => page))


    PushRoute.transparentPage(context, page) //Helper
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
    TextDesigned(     //Helper
      "Hello",
      size: 20,
      bold: true,
      underline: true,
      color: Colors.white,
    );

    Text(
      "Hello",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );

```

<br>

- ### **RemoveScrollGlow Widget:**
  Eliminate the Splash Effect or Glow Effect when reaching the limit of a PageView, ScrollView, ListView, etc.

```dart
    RemoveScrollGlow(child: PageView(...));

    //RESULT
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
    DismissKeyboard(child: Container());

    //RESULT
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
      },
      child: Container(),
    );
```

<br>

---

<br>

## Transition Helpers

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
  Show or hide a Widget with an **Fade Transition** from a Boolean variable.

```dart
    bool visible = true;

    OpacityTransition(  //Helper
      visible: visible,
      child: Container(),
      curve: Curves.linear, //OPTIONAL
      duration: Duration(milliseconds: 200) //OPTIONAL
    );


    //RESULT
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

- ### **SwipeTransition Widget:**
  Show or hide a Widget with an **Slide Transition** from a Boolean variable.

```dart
    bool visible = true;

    SwipeTransition(  //Helper
      visible: visible,
      child: Container(),
      curve: Curves.ease, //OPTIONAL
      duration: Duration(milliseconds: 400) //OPTIONAL
    );


    //RESULT
    return ClipRRect(
      child: BooleanTween(
        key: tweenKey,
        tween: Tween<Offset>(begin: direction, end: Offset.zero);,
        curve: widget.curve,
        animate: widget.visible,
        duration: widget.duration,
        builder: (value) {
          return Transform.translate(
            offset: value,
            child: Container(key: key, child: widget.child),
          );
        },
      ),
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


    GetContext.width(context);   //Helper
    MediaQuery.of(context).size.width;

    GetContext.height(context);  //Helper
    MediaQuery.of(context).size.height;

    GetContext.padding(context); //Helper
    MediaQuery.of(context).padding;

    GetContext.size(context);    //Helper
    MediaQuery.of(context).size;

    GetContext.data(context);    //Helper
    MediaQuery.of(context);

    ... //+10 MEDIAQUERIES
```

<br>

- ### **GetKey Class:**
  It is a simplification of the _key.currentContext_ statement.

```dart
    GlobalKey key = GlobalKey();


    GetKey.width(key);   //Helper
    key.currentContext.size.width;

    GetKey.height(key);  //Helper
    key.currentContext.size.height;

    GetKey.size(key);    //Helper
    key.currentContext.size;

    GetKey.context(key); //Helper
    key.currentContext;
```

<br>

- ### **Margin Class:**
  It is a simplification of the _EdgeInsets_ statement.

```dart
    double amount = 2.0;


    Margin.zero; //Helper
    EdgeInsets.zero;

    Margin.all(amount); //Helper
    EdgeInsets.all(amount);


    //SYMETRIC
    Margin.vertical(amount);   //Helper
    EdgeInsets.symmetric(vertical: amount);

    Margin.horizontal(amount); //Helper
    EdgeInsets.symmetric(horizontal: amount);

    Margin.symmetric(...);     //Helper
    EdgeInsets.symmetric(...);


    //ONLY
    Margin.top(amount);    //Helper
    EdgeInsets.only(top: amount);

    Margin.bottom(amount); //Helper
    EdgeInsets.only(bottom: amount);

    Margin.left(amount);   //Helper
    EdgeInsets.only(left: amount);

    Margin.right(amount);  //Helper
    EdgeInsets.only(right: amount);

    Margin.only(...);      //Helper
    EdgeInsets.only(...);
```

<br>

- ### **EdgeRadius Class:**
  It is a simplification of the _BorderRadius_ statement.

```dart
    double amount = 2.0;


    EdgeRadius.zero;        //Helper
    BorderRadius.zero;

    EdgeRadius.all(amount); //Helper
    BorderRadius.all(Radius.circular(amount));


    //SYMETRIC
    EdgeRadius.vertical(top: amount, bottom: amount);   //Helper
    BorderRadius.vertical(
      top: Radius.circular(top),
      bottom: Radius.circular(bottom));

    EdgeRadius.horizontal(left: amount, right: amount); //Helper
    BorderRadius.horizontal(
      left: Radius.circular(left),
      right: Radius.circular(right));


    //ONLY
    EdgeRadius.only( //Helper
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
