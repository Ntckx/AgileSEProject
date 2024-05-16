import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/default_plan.dart';
import 'package:flutter_application_1/pages/recommendedplan.dart';
import 'package:flutter_application_1/src/workout_plan.dart';
import '../src/widget.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  double calories = 0;
  bool isLoading = true;

  Future<void> getHomepageInformation() async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      Map<String, dynamic>? userData = snapshot.data();
      calories = userData?['caloriesBurn'] ?? 0;
      // print("Calories : " + calories.toString());
    } catch (err) {
      print(err);
    }
  }

  Future<List<WorkoutPlan>> getPlanInformation() async {
    List<WorkoutPlan> planInfo = [];
    try {
      getHomepageInformation();

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('defaultPlan').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
          in snapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        String planId = docSnapshot.id;
        planInfo.add(WorkoutPlan.fromFirestore(data, planId));
        // print("Each plan Info : $data");
      }
    } catch (err) {
      print("Error : $err");
    }

    return planInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getPlanInformation(),
          builder: (context, planData) {
            List<WorkoutPlan>? plans = planData.data;

            if (planData.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (planData.hasError) {
              return Center(
                child: Text('Error: ${planData.error}'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14, top: 20),
                        child: Text(
                          "Recommend Plan".tr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, top: 4),
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'DAY1'.tr,
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1),
                                  ),
                                  Text(
                                    'This month ${calories.toStringAsFixed(1)} Kcal',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                            minimumSize: const Size(300, 40)),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return RecommendedPlan();
                                            },
                                          ));
                                        },
                                        child: Text(
                                          'Start'.tr,
                            
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, top: 25),
                        child: Text(
                          "Your own desire".tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: plans?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DefaultPlan(
                                    plan: plans[index],
                                  );
                                },
                              ));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                child: Cardplan(
                                  planname: plans![index].name.tr,
                                  details:
                                      "${plans[index].duration} Min - ${plans[index].gestureAmount} gestures",
                                  imagePath: 'assets/images/ABS.png',
                                  descriptionTopic: plans[index].name.tr,
                                  descriptionDetail: plans[index].description,
                                )),
                          );
                        },
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
