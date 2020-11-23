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
