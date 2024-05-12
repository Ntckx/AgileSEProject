import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_workout.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/src/workout.dart';

class RecommendedPlan extends StatelessWidget {
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');
  late final String userplanId;

  Future<String> getPlanInformation() async {
    String planId = '';
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);

      CollectionReference recommendPlanRef =
          userRef.collection('recommendPlan');

      QuerySnapshot recommendPlanSnapshot = await recommendPlanRef.get();

      if (recommendPlanSnapshot.docs.isNotEmpty) {
        planId = recommendPlanSnapshot.docs.first.id;
        userplanId = planId;
      }
    } catch (err) {
      print('Error getting planId: $err');
    }
    return planId;
  }

  Future<List<Workout>> getWorkoutsForPlan() async {
    String planId = await getPlanInformation();

    List<Workout> workouts = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('workouts')
          .where('planId', isEqualTo: planId)
          .get();

      workouts = snapshot.docs.map((doc) {
        return Workout.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error getting workouts: $e');
    }
    return workouts;
  }

  RecommendedPlan({super.key});

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
              List<Workout>? workouts = workoutList.data;

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
                            'images/picture.png',
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Good Choice',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Here is Your Recommended Plan',
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
                          const Text('Workout list',
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
                                    workouts: workouts as List<Workout>,
                                    planId: userplanId,
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
                      itemCount: workouts?.length,
                      itemBuilder: (context, index) {
                        return WorkoutItem(
                          workoutName: workouts![index].workoutName,
                          amount: workouts[index].amount,
                          imagePath: 'assets/images/BicycleCrunches.png',
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        'Start',
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
                      '$_timesPerformed times',
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
