import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/main_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/firebase_options.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const MyApp()),
//   ));
// }
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
// final GoRouter _router = GoRouter(routes: [
//   GoRoute(
//       path: '/',
//       builder: (context, state) {
//         return const AuthFunc();
//       },
//       routes: [
//         GoRoute(
//           path: 'home',
//           builder: (context, state) {
//             return const BottomNavPage();
//           },
//         ),
//       ])
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
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
