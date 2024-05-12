import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/catagories_abs.dart';
import 'package:flutter_application_1/pages/recommendedplan.dart';
import '../src/widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  double calories = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getHomepageInformation();
  }

  Future<void> getHomepageInformation() async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      Map<String, dynamic>? userData = snapshot.data();
      setState(() {
        calories = userData?['caloriesBurn'] ?? 0;
        isLoading = false; // Set loading to false after getting data
      });
      // print("Calories : " + calories.toString());
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false; // Set loading to false if there's an error
      });
    }
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
        child: isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 14, top: 20),
                    child: Text(
                      "Recommend Plan",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, top: 4),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/Workout#1.png'),
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
                              const Text(
                                'DAY1',
                                style: TextStyle(
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
                                        minimumSize: const Size(300, 40)),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const RecommendedPlan();
                                        },
                                      ));
                                    },
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 14, top: 25),
                    child: Text(
                      "Your own desire",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const AbsPage();
                        },
                      ));
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(left: 14, top: 4),
                        child: Cardplan(
                          planname: "ABS",
                          details: "20 Min - 16 gestures",
                          imagePath: 'assets/images/ABS.png',
                          descriptionTopic: 'ABS',
                          descriptionDetail:
                              'Abs, short for abdominals, refer to the muscles in your midsection. They include the rectus abdominis, obliques, and transverse abdominis. Exercises like crunches, planks, and leg raises can help strengthen and define your abs. Focus on proper form and engage your core muscles throughout each movement for best results.',
                        )),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 14, top: 15),
                      child: Cardplan(
                          planname: "ARMS",
                          details: "30 Min - 25 gestures",
                          imagePath: 'assets/images/ARMS.jpg',
                          descriptionTopic: 'ARMS',
                          descriptionDetail:
                              "Arms include biceps, triceps, and forearms. Strengthen them with exercises like bicep curls, tricep dips, and forearm curls using weights or resistance bands. Focus on proper form and gradually increase resistance for results.")),
                ],
              ),
      ),
    );
  }
}
