import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/calories_page.dart';
import 'package:flutter_application_1/src/calories.dart';
import 'package:flutter_application_1/src/workout.dart';
import 'package:flutter_application_1/src/workout_plan.dart';
import '../src/widget.dart';

class WorkoutPage extends StatefulWidget {
  final WorkoutPlan currentPlan;
  final double userWeight;

  const WorkoutPage({
    super.key,
    required this.currentPlan,
    required this.userWeight,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _currentIndex = 0;
  double totalCalories = 0;
  bool updatingUserInformation = false;
  int _timespend = 0;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timespend++;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void _completeWorkout() {
    setState(() {
      print('Weight : ${widget.userWeight}');
      if (_currentIndex < widget.currentPlan.workouts.length) {
        calculateCaloriesEach(widget.currentPlan.workouts[_currentIndex]);
        print("${totalCalories.toString().trim()} Kcal");

        if (_currentIndex == widget.currentPlan.workouts.length - 1) {
          // If all workouts are completed, navigate back to the homepage
          updateUserInformation().then((_) {
            setState(() {
              updatingUserInformation = false;
            });
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CaloriesPage();
              },
            ));
          });
          setState(() {
            updatingUserInformation = true;
          });
        } else {
          _currentIndex++;
        }
      }
    });
  }

  void calculateCaloriesEach(Workout workout) {
    totalCalories += Calories(weight: widget.userWeight, workout: workout)
        .CalculateCalories();
    print(
        "Workout name : ${workout.workoutName} , MET value : ${workout.metValue}");
  }

  Future<void> updateUserInformation() async {
    User? user = FirebaseAuth.instance.currentUser;
    double currentCalories = 0;
    int currentWorkoutAmount = 0;
    int currentTimespend = 0;
    int workoutSuccessAmount = _currentIndex + 1;

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(user?.uid);
    DocumentSnapshot<Object?> userData = await documentReference.get();
    currentCalories = userData['caloriesBurn'];
    currentWorkoutAmount = userData['workoutsAmount'];
    currentTimespend = userData['timeSpend'];

    await documentReference.update({
      'caloriesBurn': totalCalories + currentCalories,
      'workoutsAmount': currentWorkoutAmount + workoutSuccessAmount,
      'timeSpend': currentTimespend + _timespend
    });
  }

  @override
  Widget build(BuildContext context) {
    Workout currentWorkout = widget.currentPlan.workouts[_currentIndex];

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Logo()),
          backgroundColor: const Color(0xFFDA2D4A),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (updatingUserInformation)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: const Color(0xFFE0DEDF).withOpacity(0.1),
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/gif/Bicycle.gif'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                currentWorkout.workoutName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 80),
              Text(
                currentWorkout.amount.toString().trim(),
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 65),
                    backgroundColor: const Color(0xFFDA2D4A)),
                onPressed: () {
                  _completeWorkout();
                },
                child: const SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Complete',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
