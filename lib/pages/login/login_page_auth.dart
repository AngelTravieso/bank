// import 'package:bank/pages/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class LoginPage extends StatefulWidget {
//   static String routeName = 'login';
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   LocalAuthentication auth = LocalAuthentication();
//   late bool _canCheckBiometric;
//   late List<BiometricType> _avaliableBiometrics;
//   String autherized = 'No autorizado';

//   Future<void> _checkBiometric() async {
//     bool canCheckBiometric = false;
//     try {
//       canCheckBiometric = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return;

//     setState(() {
//       _canCheckBiometric = canCheckBiometric;
//     });
//   }

//   Future<void> _getAvailableBiometric() async {
//     List<BiometricType> availableBiometric = [];

//     try {
//       availableBiometric = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     setState(() {
//       _avaliableBiometrics = availableBiometric;
//     });
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: 'Escanea tu dedo para autenticar',
//       );
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return;

//     setState(() {
//       autherized =
//           authenticated ? 'Autherize success' : 'Failed to authenticate';
//       if (authenticated) {
//         Navigator.pushNamed(context, HomePage.routeName);
//       }
//       print(autherized);
//     });
//   }

//   @override
//   void initState() {
//     _checkBiometric();
//     _getAvailableBiometric();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Container(
//         margin: const EdgeInsets.symmetric(
//           vertical: 12,
//           horizontal: 24,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 50),
//               child: Column(children: [
//                 Image.asset(
//                   'assets/png/fingerprint.png',
//                   width: 120,
//                 ),
//                 Text(
//                   'Fingerprint auth',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   width: 150,
//                   child: Text(
//                     'Autenticate usando tu dedo, no tu contraseña',
//                     style: TextStyle(height: 1.5),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 15),
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 24,
//                       ),
//                       child: Text(
//                         'Autenticar',
//                         style: TextStyle(),
//                       ),
//                     ),
//                     onPressed: _authenticate,
//                   ),
//                 )
//               ]),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
