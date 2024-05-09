import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/widget.dart';

void main() {
  runApp(const MyApp());
}

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
        home: const CongratePage());
  }
}

class CongratePage extends StatelessWidget {
  const CongratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: 
      SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Padding(
              padding: EdgeInsets.only(left: 14, top: 20),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Award.png',
                    width: 400,
                    height: 400,
                  ),
                  Text(
                "Congratulations",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                
              ),
              Text('Good job. Today, you have workout for 1400 cal.')
                ],/*  */
              )
            ),
            

      

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 65),
                    backgroundColor: const Color(0xFFDA2D4A)),
                onPressed: () {
                  Navigator.pushNamed(context, '/workouthome');

                },
                child: const SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Back to Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                     
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
