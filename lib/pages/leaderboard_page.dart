import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/user.dart';
import 'package:get/get.dart';

class MyLeaderBoardPage extends StatefulWidget {
  const MyLeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<MyLeaderBoardPage> createState() => _MyLeaderBoardPageState();
}

class _MyLeaderBoardPageState extends State<MyLeaderBoardPage> {
  double timeSpend = 0;
  String displayTime = '';
  List<AppUser> userList = [];

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData = {};

    try {
      userList = await getAllUsersData();
      sortAndLimitUserListByCaloriesBurn();
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      if (snapshot.exists) {
        userData = snapshot.data() as Map<String, dynamic>;
        timeSpend = userData['timeSpend'] as double;
        displayTime = calculateTimeSpend(timeSpend);
      }
    } catch (err) {
      print(err);
    }
    return userData;
  }

  Future<List<AppUser>> getAllUsersData() async {
    List<AppUser> userDataList = [];
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (final DocumentSnapshot doc in snapshot.docs) {
        AppUser user = AppUser.fromFirebase(doc);
        userDataList.add(user);
      }
    } catch (err) {
      print(err);
    }

    return userDataList;
  }

  void sortAndLimitUserListByCaloriesBurn() {
    userList.sort((a, b) => b.caloriesBurn.compareTo(a.caloriesBurn));
    if (userList.length > 4) {
      userList = userList.sublist(0, 4);
    }
  }

  String calculateTimeSpend(double second) {
    double minutes = 0;
    if (second > 60) {
      minutes = second / 60;
      second %= 60;
    }

    String timeFormat = "${minutes.toStringAsFixed(0)}.$second";
    return timeFormat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: fetchUserData(),
        builder: (context, snapshot) {
          Map<String, dynamic>? userData = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "LeaderBoard".tr,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 215, 0, 100),
                                Color.fromRGBO(218, 45, 74, 100)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      height: 250,
                      width: 400,
                      child: DataTable(
                        dividerThickness: 0.00000000001,
                        columns:  [
                          DataColumn(label: Text('Rank'.tr)),
                          DataColumn(label: Text('User'.tr)),
                          DataColumn(label: Text('Kcal'.tr)),
                        ],
                        rows: userList.map((user) {
                          final rank = userList.indexOf(user) + 1;
                          return DataRow(
                            cells: [
                              DataCell(Text(rank.toString())),
                              DataCell(Text(user.username)),
                              DataCell(
                                  Text(user.caloriesBurn.toStringAsFixed(2))),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Statistic".tr,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFDA2D4A).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                             Text(
                                              "Workouts".tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "${userData?['workoutsAmount'] ?? 0}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            children: [
                                               Text(
                                                "Kcal".tr,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "${(userData?['caloriesBurn'] ?? 0).toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Minutes".tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              displayTime.toString().trim(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        },
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'OK KAMLANGKAI',
      style: TextStyle(color: Colors.white),
    );
  }
}
