import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/workout.dart';
import '../src/widget.dart';

class MyWorkoutPlanOption extends StatelessWidget {
  final String planId;
  final String planname;
  final String email;

  const MyWorkoutPlanOption(
      {super.key, required this.planId, required this.planname, required this.email});

  Future<List<Workout>> getAllWorkOut() async {
    List<Workout> workouts = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('workouts').get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Workout newWorkout = Workout.fromFirestore(doc);
        if (!workouts
            .any((workout) => workout.workoutName == newWorkout.workoutName)) {
          workouts.add(newWorkout);
        }
      }
    } catch (err) {
      print(err);
    }

    return workouts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: FutureBuilder(
        future: getAllWorkOut(),
        builder: (context, workouts) {
          if (workouts.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (workouts.hasData) {
            List<Workout>? workoutOption = workouts.data;

            return Container(
              decoration: const BoxDecoration(
                  // color: Colors.grey
                  ),
              child: ListView.builder(
                itemCount: workoutOption?.length,
                itemBuilder: (context, index) {
                  return Workoutplan(
                      workout: workoutOption![index],
                      planId: planId,
                      planname: planname,
                      email: email,
                      imagePath: 'assets/images/Bicycle2.jpg');
                },
              ),
            );
          } else {
          
            return Center(
              child: Text("Errors : ${workouts.error}"),
            );
          }
        },
      ),
    );
  }
}
