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
      navigatorKey: BuildRoute.key,
      home: HomePage(),
      theme: ThemeData(
        accentColor: Color(0xFF0253f5),
        primaryColor: Color(0xFF37393d),
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
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
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: BuildColor(context).accent,
        onPressed: () => setState(() => visible = !visible),
        child: TurnTransition(turn: visible, child: Icon(Icons.chevron_left)),
      ),
      body: Column(children: [
        SafeAreaColor(
          color: Colors.white,
          height: 60,
          child: Center(
            child: BooleanTween<double>(
              animate: visible,
              tween: Tween<double>(begin: 16, end: 20),
              builder: (_, value, __) {
                return TextDesigned("HELPERS EXAMPLE", bold: true, size: value);
              },
            ),
          ),
        ),
        Expanded(
          child: SwipeTransition(
            visible: visible,
            direction: SwipeDirection.fromTop,
            child: Center(child: TextDesigned("Swipe Transition", bold: true)),
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
            direction: SwipeDirection.fromBottom,
            child: Center(child: TextDesigned("Swipe Transition", bold: true)),
          ),
        ),
        SplashButton(
          onTap: () {
            openSlidingPanelPage(
              context,
              SlidingPanelPage(
                backgroundBlur: 4.4,
                builder: (newContext, __) => SlidingPanelContainer(
                  height: 600,
                  padding: Margin.all(100),
                  child: Column(children: [
                    SplashTap(
                      onTap: () {
                        //Need on MaterialApp the navigationKey
                        BuildRoute.toTransparentPage(Center(
                          child: Headline4("GG"),
                        ));
                      },
                      child: Text("Using BuildRoute"),
                    ),
                    ExpandedSpacer(),
                    SplashTap(
                      onTap: () {
                        newContext.toTransparentPage(Center(
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
        SizedBox(height: 60),
      ]),
    );
  }
}
