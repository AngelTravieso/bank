import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  static String routeName = 'signin';
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('signin')),
    );
  }
}
