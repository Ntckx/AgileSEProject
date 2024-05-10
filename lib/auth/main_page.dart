import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_page.dart';
import 'package:flutter_application_1/pages/congrate_page.dart';
import 'package:flutter_application_1/src/bottom_nav.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  final int initialIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('please work!!!');
            return BottomNavPage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
