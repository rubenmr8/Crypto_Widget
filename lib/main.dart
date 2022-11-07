import 'my_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textSize = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              headline4: textSize.headline4!.copyWith(
                color: Colors.white,
              ),
              headline5: textSize.headline5!.copyWith(color: Colors.white),
              subtitle1: textSize.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
      ),
      themeMode: ThemeMode.dark,
      home: MyHomeScreen(),
    );
  }
}
