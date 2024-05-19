import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String username;
  final String email;
  final String password;
  final double caloriesBurn;
  final int timeSpend;
  final int workoutsAmount;

  const AppUser(
      {required this.username,
      required this.email,
      required this.password,
      this.caloriesBurn = 0,
      this.timeSpend = 0,
      this.workoutsAmount = 0});

  factory AppUser.fromFirebase(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>;
    return AppUser(
      username: userData['username'] ?? '',
      email: userData['email'] ?? '',
      password: userData['password'] ?? '',
      caloriesBurn: (userData['caloriesBurn'] ?? 0.0).toDouble(),
      timeSpend: userData['timeSpend'] ?? 0,
      workoutsAmount: userData['workoutsAmount'] ?? 0,
    );
  }
}
