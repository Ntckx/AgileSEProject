import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKKAMLANGKAI',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: MyWorkoutPlan(),
    );
  }
}

class MyWorkoutPlan extends StatelessWidget {
  const MyWorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Center(child: Logo()),
      backgroundColor: const Color(0xFFDA2D4A),
      
    ),
    body:  Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration:const BoxDecoration(
          // color: Colors.grey
        ),
        child: Workoutplan(planname: 'Bicycle Crunches', details: 'Detail babbababababab', imagePath: 'assets/images/ARMS.jpg'),
      ),
    ),
    );
  }
}
