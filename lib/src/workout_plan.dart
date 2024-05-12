import 'workout.dart';

class WorkoutPlan {
  String name;
  double duration;
  int gestureAmount;
  List<Workout> workouts;
  String description;
  String planId;

  WorkoutPlan(
      {required this.name,
      required this.workouts,
      required this.duration,
      required this.gestureAmount,
      this.description = '',
      this.planId = ''});

  factory WorkoutPlan.fromFirestore(Map<String, dynamic> map, String planId) {
    return WorkoutPlan(
      name: map['planname'] ?? 'no name',
      duration: map['duration'] ?? 0,
      gestureAmount: map['gestureAmount'] ?? 0,
      description: map['description'] ?? '',
      planId: planId,
      workouts: [],
    );
  }
}
