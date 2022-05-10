import 'package:bank/pages/pages.dart';
import 'package:bank/provider/login_provider.dart';
import 'package:bank/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  static String routeName = 'signin';
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late FocusNode nameNode;
  late FocusNode emailNode;
  late FocusNode passwordNode;

  @override
  void initState() {
    super.initState();

    nameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
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
                key: loginProvider.signinFormKey,
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
                                'Crear cuenta',
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
                                    'Crea una cuenta para continuar',
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
                                      'Nombre',
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
                                      focusNode: nameNode,
                                      decoration: InputDecoration(
                                        hintText: 'Ingresa tu nombre',
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
                                          emailNode.requestFocus(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Correo electrónico',
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
                                      focusNode: emailNode,
                                      decoration: InputDecoration(
                                        hintText: 'Ingresa tu email',
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
                                        'Términos y condiciones',
                                        style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        TermsConditionPage.routeName,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text(
                                      'Crear cuenta',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (!loginProvider
                                          .signinFormKey.currentState!
                                          .validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: ErrorSnackBar(
                                              title: 'Datos incompletos',
                                              content:
                                                  'Completa toda la información para crear una cuenta',
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );

                                        return;
                                      }

                                      SmartDialog.show(builder: (context) {
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                        );
                                      });

                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        SmartDialog.dismiss();
                                        Navigator.pushNamed(
                                          context,
                                          HomePage.routeName,
                                        );
                                      });
                                    },
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
                'Ya tienes una cuenta?',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 16,
                    ),
              ),
              TextButton(
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  LoginPage.routeName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
