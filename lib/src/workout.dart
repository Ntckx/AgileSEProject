import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String workoutName;
  String description = "";
  double amount;
  double metValue;

  Workout(
      {required this.workoutName,
      required this.amount,
      required this.metValue,
      this.description = ''});

  factory Workout.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Workout(
        workoutName: data['workoutName'],
        amount: (data['amount'] ?? 0).toDouble(),
        metValue: (data['metValue'] ?? 0).toDouble(),
        description: data['description'] ?? '');
  }
}
