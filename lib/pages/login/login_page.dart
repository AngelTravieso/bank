import 'dart:math';

import 'package:bank/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode userNode;
  late FocusNode passwordNode;

  LocalAuthentication auth = LocalAuthentication();
  late bool _canCheckBiometric;
  late List<BiometricType> _avaliableBiometrics;
  String autherized = 'No autorizado';

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    print(availableBiometric);

    setState(() {
      _avaliableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Escanea tu dedo para autenticar',
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      autherized =
          authenticated ? 'Autherize success' : 'Failed to authenticate';
      if (authenticated) {
        Navigator.pushNamed(context, HomePage.routeName);
      }
      print(autherized);
    });
  }

  @override
  void initState() {
    super.initState();

    userNode = FocusNode();
    passwordNode = FocusNode();

    _checkBiometric();
    _getAvailableBiometric();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo[800]!,
                Colors.indigo[600]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 32,
                          ),
                          child: const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 32,
                        left: 36,
                        right: 36,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Bienvenido',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Hola, inicia sesión para continuar',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                'Usuario',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                width: 300,
                                child: TextFormField(
                                  cursorColor: Colors.indigo,
                                  maxLength: 14,
                                  focusNode: userNode,
                                  decoration: InputDecoration(
                                    hintText: 'Ingresa tu usuario',
                                    counterText: '',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.indigo,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onEditingComplete: () =>
                                      passwordNode.requestFocus(),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                'Contraseña',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                width: 300,
                                child: TextFormField(
                                  cursorColor: Colors.indigo,
                                  maxLength: 14,
                                  obscureText: true,
                                  focusNode: passwordNode,
                                  decoration: InputDecoration(
                                    hintText: 'Ingresa tu contraseña',
                                    counterText: '',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.indigo,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onEditingComplete: () =>
                                      passwordNode.unfocus(),
                                )),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextButton(
                                  child: const Text(
                                    'Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {}),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        ),
                                      ),
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Icon(Icons.fingerprint),
                                    onPressed: _authenticate,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                child: Text('Face id'),
                                onPressed: () async {
                                  await auth.authenticate(
                                      localizedReason:
                                          'Please authenticate to show account balance',
                                      options: const AuthenticationOptions(
                                          biometricOnly: true));
                                }),
                          ]),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No tienes una cuenta?',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                ),
          ),
          TextButton(
            child: const Text(
              'Crear cuenta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              SigninPage.routeName,
            ),
          ),
        ],
      ),
    );
  }
}
