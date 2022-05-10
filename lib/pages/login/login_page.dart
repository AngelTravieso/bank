import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:provider/provider.dart';

import 'package:bank/pages/pages.dart';
import 'package:bank/provider/login_provider.dart';
import 'package:bank/widgets/widgets.dart';

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
  bool canCheckBiometric = false;
  List<BiometricType> avaliableBiometrics = [];
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
      canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      avaliableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Autenticate para iniciar sesión',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Acción requerida',
            biometricHint: 'Verifica tu identidad',
          ),
        ],
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
    final loginProvider = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanDown,
      ],
      child: SafeArea(
        child: Scaffold(
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
              child: Form(
                key: loginProvider.loginFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const Text(
                                'Iniciar sesión',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
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
                              top: 14,
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
                                    width: size.width,
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
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
                                    width: size.width,
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                            minimumSize:
                                                const Size.fromHeight(50),
                                          ),
                                          child: const Text(
                                            'Iniciar sesión',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (!loginProvider
                                                .loginFormKey.currentState!
                                                .validate()) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: ErrorSnackBar(
                                                    title: 'Datos incorrectos',
                                                    content:
                                                        'Ingrese un usuario y contraseña válido para iniciar sesión',
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                ),
                                              );

                                              return;
                                            }

                                            SmartDialog.show(
                                                builder: (context) {
                                              return Container(
                                                height: 180,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: const <Widget>[
                                                      SpinKitCircle(
                                                        size: 75,
                                                        color: Colors.indigo,
                                                      ),
                                                      Text(
                                                        'Iniciando sesión',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]),
                                              );
                                            });

                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              SmartDialog.dismiss();
                                              Navigator.pushNamed(
                                                context,
                                                HomePage.routeName,
                                              );
                                            });
                                          },
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
                                                bottomRight:
                                                    Radius.circular(16),
                                              ),
                                            ),
                                            minimumSize:
                                                const Size.fromHeight(50),
                                          ),
                                          child: const Icon(Icons.fingerprint),
                                          onPressed: _authenticate,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ]),
              ),
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
        ),
      ),
    );
  }
}
