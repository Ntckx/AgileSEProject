import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'register.dart';
import 'registerBodyInformation.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => Register(), routes: [
    GoRoute(
      path: 'body',
      builder: (context, state) => RegisterBodyInfo(),
    )
  ]),
  GoRoute(
    path: '/home',
    builder: (context, state) => const MyHomePage(),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OKKAMLANGKAI',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
