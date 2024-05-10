import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/pages/setting_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  String username = '';
  int height = 0;
  int weight = 0;
  double BMI = 0;

  Future getUserInformation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();

      Map<String, dynamic>? userData = snapshot.data();
      if (userData != null) {
        username = userData['username'];
        height = userData['height'];
        weight = userData['weight'];
      }
    } catch (e) {
      print(e);
    }

    BMI = calculateBMI(height, weight);
  }

  double calculateBMI(int height, int weight) {
    double heightMeter = height / 100;
    return weight / (heightMeter * heightMeter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          child: Column(
            children: [
              FutureBuilder(
                future: getUserInformation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error : ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        // user profile
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.asset(
                              '../assets/maxresdefault.jpg',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //user name
                        Text(
                          username.isEmpty ? 'No username' : username.trim(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black),
                        ),
                        //user rank
                        const Text(
                          'Rank #1',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        //user weight
                        Text(
                          weight == 0
                              ? 'No weight'
                              : "Weight : ${weight.toString().trim()}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        //user bmi
                        Text(
                          BMI == 0
                              ? 'No BMI'
                              : "BMI : ${BMI.toStringAsFixed(2).trim()}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),

              //settings
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SettingPage();
                    },
                  ));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // log-out
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Log-out',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // delete account
              GestureDetector(
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete_outlined,
                      size: 30,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Delete account',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
