import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_workout.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart'
    as leaderboard;
import 'package:flutter_application_1/pages/workout_page.dart';
import 'package:flutter_application_1/src/widget.dart' as tool;
import 'package:flutter_application_1/src/workout.dart';
import 'package:flutter_application_1/src/workout_plan.dart';
import 'package:get/get.dart';


class RecommendedPlan extends StatelessWidget {
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');
  String planname = '';
  double userWeight = 0;
  User? user = FirebaseAuth.instance.currentUser;

  Future<WorkoutPlan?> getPlanInformation() async {
    String planId = '';
    WorkoutPlan? plan;
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);

      CollectionReference recommendPlanRef =
          userRef.collection('recommendPlan');

      QuerySnapshot recommendPlanSnapshot = await recommendPlanRef.get();

      DocumentSnapshot userSnapshot = await userRef.get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      userWeight = (userData['weight']).toDouble();

      if (recommendPlanSnapshot.docs.isNotEmpty) {
        planId = recommendPlanSnapshot.docs.first.id;
        plan = WorkoutPlan.fromFirestore(
            recommendPlanSnapshot.docs.first.data() as Map<String, dynamic>,
            planId);
      }
    } catch (err) {
      print('Error getting planId: $err');
    }
    return plan;
  }

  Future<WorkoutPlan> getWorkoutsForPlan() async {
    WorkoutPlan? plan = await getPlanInformation();
    if (plan == null) {
      throw Exception('Failed to load plan information');
    }

    List<Workout> workouts = [];
    try {
      QuerySnapshot workoutSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('recommendPlan')
          .doc(plan
              .planId) // Assuming planId is properly set in your WorkoutPlan model
          .collection('workouts')
          .get();

      workouts = workoutSnapshot.docs.map((doc) {
        return Workout.fromFirestore(doc, workoutId: doc.id);
      }).toList();

      plan.workouts = workouts;
      for (Workout workout in workouts) {
        print('Workout: ${workout.workoutName}');
      }
    } catch (e) {
      print('Error getting workouts: $e');
      throw Exception('Failed to load workouts');
    }
    return plan;
  }

  RecommendedPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: tool.Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: getWorkoutsForPlan(),
            builder: (context, workoutList) {
              WorkoutPlan? plan = workoutList.data;

              if (workoutList.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (workoutList.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/picture.png',
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Good Choice'.tr,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Here is Your Recommended Plan'.tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              20), // Add padding of 8 pixels on all sides
                      child: Row(
                        children: [
                           Text('Workout list'.tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Spacer(), // Add a spacer to push the text to the right
                          IconButton(
                            icon: const Icon(
                              edit,
                              size: 24,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return EditWorkoutABS(
                                    workouts: plan!.workouts,
                                    planId: plan.planId,
                                    planname: planname,
                                  );
                                },
                              )); // Add functionality here
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: plan?.workouts.length,
                      itemBuilder: (context, index) {
                        return WorkoutItem(
                          workoutName: plan!.workouts[index].workoutName,
                          amount: plan.workouts[index].amount,
                          imagePath: 'assets/images/BicycleCrunches.png',
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return WorkoutPage(
                                currentPlan: plan as WorkoutPlan,
                                userWeight: userWeight);
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Start'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              } else {
                return Center(
                  child: Text('Error : ${workoutList.error}'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class WorkoutItem extends StatefulWidget {
  final String workoutName;
  final String imagePath;
  final double amount;

  const WorkoutItem(
      {Key? key,
      required this.workoutName,
      required this.imagePath,
      required this.amount})
      : super(key: key);

  @override
  _WorkoutItemState createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  int _timesPerformed = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timesPerformed = widget.amount.toInt();
  }

  void _increaseTimes() {
    setState(() {
      _timesPerformed++;
    });
  }

  void _decreaseTimes() {
    if (_timesPerformed > 0) {
      setState(() {
        _timesPerformed--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            widget.imagePath,
            width: 500,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.workoutName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_timesPerformed ',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'times'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
