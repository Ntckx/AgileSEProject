import 'package:flutter_application_1/src/workout.dart';

class Calories {
  double weight;
  Workout workout;
  double defaultMET = 3.5;
  double totalCal = 0;

  Calories({required this.weight, required this.workout});

  double CalculateCalories() {
    totalCal = (workout.metValue * defaultMET * weight * workout.amount) / 200;
    print(
        "MET value : ${workout.metValue} , weight : $weight , amount : ${workout.amount} , totalCal : $totalCal");
    return totalCal;
  }
}
