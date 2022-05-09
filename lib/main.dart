import 'package:bank/pages/pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Bank',
      initialRoute: FirstPage.routeName,
      routes: {
        FirstPage.routeName: (_) => FirstPage(),
        LoginPage.routeName: (_) => LoginPage(),
        SigninPage.routeName: (_) => SigninPage(),
        HomePage.routeName: (_) => HomePage(),
      },
    );
  }
}
