
import 'package:flutter/material.dart';
import 'package:flutter_application_1/calories_page.dart';
import 'package:flutter_application_1/getready_page.dart';
import 'package:flutter_application_1/recommendedplan.dart';
import 'package:flutter_application_1/src/register.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/edit_workout.dart';
import 'package:flutter_application_1/workout_page.dart';
import 'package:flutter_application_1/workoutoption_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => Register(),
          '/workouthome': (context) => MyHomePage(),
          '/editworkout': (context) => EditWorkoutABS(),
          '/recommendedplan':(context)=> RecommendedPlan(),
          '/getready':(context)=> MyGetReady(),
          '/recommendedplanworkout':(context)=> WorkoutPage(),
          '/caloriesburnedrecommendplan':(context)=> CaloriesPage(),
          '/workoutoption':(context)=>MyWorkoutPlan(),



        });
  }
}
