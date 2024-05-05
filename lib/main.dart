import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/main_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/register.dart';
import 'pages/registerBodyInformation.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

// final GoRouter _router = GoRouter(routes: [
//   GoRoute(path: '/', builder: (context, state) => Register(), routes: [
//     GoRoute(
//       path: 'body',
//       builder: (context, state) => RegisterBodyInfo(),
//     )
//   ]),
//   GoRoute(
//     path: '/home',
//     builder: (context, state) => const MyHomePage(),
//   )
// ]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKKAMLANGKAI',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
