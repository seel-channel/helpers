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
        primaryColor: const Color(0xFF37393d),
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
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
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => visible = !visible),
        child: TurnTransition(
            turn: visible, child: const Icon(Icons.chevron_left)),
      ),
      body: Column(children: [
        SafeAreaColor(
          height: 60,
          child: Center(
            child: BooleanTween<double>(
              animate: visible,
              tween: Tween<double>(begin: 16, end: 20),
              builder: (_, value, __) {
                return BodyText1(
                  "HELPERS EXAMPLE",
                  style: TextStyle(fontSize: value),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: SwipeTransition(
            visible: visible,
            child: const Center(child: BodyText1("Swipe Transition")),
          ),
        ),
        Expanded(
          child: OpacityTransition(
            visible: visible,
            child: Center(
              child: AnimatedInteractiveViewer(
                child: Image.network(
                    "https://avatars0.githubusercontent.com/u/65832922?s=460&u=67f908b168ae2934f9e832af2180825c6b2f0e37&v=4"),
              ),
            ),
          ),
        ),
        Expanded(
          child: SwipeTransition(
            visible: visible,
            axisAlignment: 1.0,
            child: Center(child: BodyText1("Swipe Transition")),
          ),
        ),
        SplashButton(
          onTap: () {
            context.navigator.pushNoTransition(
              SlidingBottomSheet(
                backgroundBlur: 4.4,
                builder: (newContext, __) => SlidingBottomSheetContainer(
                  height: 600,
                  padding: Margin.all(100),
                  child: Column(children: [
                    SplashTap(
                      onTap: () {
                        context.navigator.pushNoTransition(Center(
                          child: Headline4("GG"),
                        ));
                      },
                      child: Text("Using BuildContext"),
                    ),
                  ]),
                ),
              ),
            );
          },
          child: BodyText1("Open Sliding Panel"),
        ),
        SizedBox(height: 20),
        SplashButton(
          onTap: () {
            printPink("I'm an error 凸-_-凸", bold: true);
            printYellow("I'm an alert (¯―¯٥)");
            printCyan("I'm an info (✿◠‿◠)");
            printColor(
              "I'm a weird boy ¯\\(°_o)/¯",
              PrintColorStyle(
                prefix: "Hola baby!",
                foreground: Colors.green,
                background: Colors.black,
                underline: true,
                bold: true,
                italic: true,
              ),
            );
            printColor(
              "Controller disposed!",
              PrintColorStyle(
                prefix: "HELPERS",
                foreground: Colors.orangeAccent,
                bold: true,
              ),
            );
          },
          child: BodyText1("Test console color text"),
        ),
        SizedBox(height: 60),
      ]),
    );
  }
}
