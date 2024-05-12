import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/workout_page.dart';
import 'package:flutter_application_1/src/workout.dart';
import 'package:flutter_application_1/src/workout_plan.dart';
import '../src/widget.dart';

class AbsPage extends StatefulWidget {
  final WorkoutPlan plan;

  const AbsPage({super.key, required this.plan});

  @override
  State<AbsPage> createState() => _AbsPageState();
}

class _AbsPageState extends State<AbsPage> {
  final user = FirebaseAuth.instance.currentUser;
  int weight = 0;
  double totalCalories = 0;

  // get user weight which later will be pass to workoutpage
  Future<void> getUserInformation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();

      Map<String, dynamic>? userData = snapshot.data();

      weight = userData?['weight'];
    } catch (err) {
      print(err);
    }
  }

  // get list of workout for displaying
  Future<List<Workout>> getWorkoutsForPlan() async {
    String planId = widget.plan.planId;
    List<Workout> workouts = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('workouts')
          .where('planId', isEqualTo: planId)
          .get();

      workouts = snapshot.docs.map((doc) {
        return Workout.fromFirestore(doc);
      }).toList();
      widget.plan.workouts = workouts;
    } catch (e) {
      print('Error getting workouts: $e');
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
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: getWorkoutsForPlan(),
            builder: (context, workoutList) {
              if (workoutList.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (workoutList.hasData) {
                List<Workout>? workouts = workoutList.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: const AssetImage(
                                      'assets/images/Workout#1.png'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.darken))),
                          height: 150,
                          width: 400,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.info_outline,
                                          size: 30, color: Colors.white),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Good Choice',
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          height: 1),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Here is Your ABS Plan',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 25, left: 20),
                              child: Text(
                                "Workout list",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, right: 20),
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: workouts?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Cardplan(
                                  planname: workouts![index].workoutName,
                                  details: "${workouts[index].amount} times",
                                  imagePath: 'assets/images/Bicycle2.jpg',
                                  descriptionTopic: workouts[index].workoutName,
                                  descriptionDetail:
                                      workouts[index].description),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(250, 65),
                            backgroundColor: const Color(0xFFDA2D4A)),
                        onPressed: () {
                          getUserInformation().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => WorkoutPage(
                                        currentPlan: widget.plan,
                                        userWeight:
                                            double.parse(weight.toString()),
                                      )))));
                        },
                        child: const SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Start',
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
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("Error : ${workoutList.error.toString().trim()}"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
