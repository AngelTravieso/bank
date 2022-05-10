import 'package:bank/pages/pages.dart';
import 'package:bank/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Bank',
      initialRoute: FirstPage.routeName,
      routes: {
        FirstPage.routeName: (_) => const FirstPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        SigninPage.routeName: (_) => const SigninPage(),
        TermsConditionPage.routeName: (_) => const TermsConditionPage(),
        HomePage.routeName: (_) => const HomePage(),
      },
    );
  }
}
