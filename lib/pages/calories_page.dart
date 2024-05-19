import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/congrate_page.dart';
import 'package:flutter_application_1/src/workout_plan.dart';
import '../src/widget.dart';

class CaloriesPage extends StatelessWidget {
  final double totalCalories;
  final WorkoutPlan plan;
  final List<double> caloriesDetails;
  const CaloriesPage(
      {Key? key,
      required this.totalCalories,
      required this.plan,
      required this.caloriesDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 14, top: 20),
                child: Text(
                  "Summary",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFDA2D4A),
                          const Color(0xFF741827).withOpacity(0.7)
                        ]),
                  ),
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Text(
                    '${totalCalories.toStringAsFixed(2)} kcal',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),

              //Card
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: plan.workouts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                    child: Calcard(
                        posture: plan.workouts[index].workoutName,
                        amount: "${plan.workouts[index].amount} times",
                        kcal: caloriesDetails[index]),
                  );
                },
              ),

              // Calcard(posture: "Pushup", amount: "20 times", kcal: 400.00),
              // Calcard(posture: "Squat", amount: "20 times", kcal: 800.00),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 65),
                      backgroundColor: const Color(0xFFDA2D4A)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const CongratePage())));
                  },
                  child: const SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Collect',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
