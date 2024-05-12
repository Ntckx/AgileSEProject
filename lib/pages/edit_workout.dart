import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/src/workout.dart';

class EditWorkoutABS extends StatelessWidget {
  final List<Workout> workouts;
  Map<String, int> updatedWorkouts = {};

  EditWorkoutABS({super.key, required this.workouts});

  Future<void> updateWorkoutInformation(Map<String, int> updateWorkout) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (String workoutId in updateWorkout.keys) {
      DocumentReference workoutRef =
          FirebaseFirestore.instance.collection('workouts').doc(workoutId);
      batch.update(workoutRef, {'amount': updateWorkout[workoutId]});
    }

    try {
      await batch.commit();
      print('Batch update successful');
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                      Text('Here is Your ABS Plan',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(2.0), // Add padding
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Workout list',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          '+ Add',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutItemWithDeleteConfirmation(
                    workoutName: workouts[index].workoutName,
                    amount: workouts[index].amount,
                    workoutId: workouts[index].workoutId,
                    imagePath: 'assets/images/BicycleCrunches.png',
                    onTimesChanged: (workoutId, times) {
                      if (!updatedWorkouts.containsKey(workoutId)) {
                        updatedWorkouts[workoutId] = times;
                      } else {
                        updatedWorkouts.addAll({workoutId: times});
                      }
                    },
                  );
                },
              ),
              // Other widgets...
              ElevatedButton(
                onPressed: () {
                  updateWorkoutInformation(updatedWorkouts);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class WorkoutItemWithDeleteConfirmation extends StatefulWidget {
  final String workoutName;
  final String imagePath;
  final double amount;
  final String workoutId;
  final Function(String, int) onTimesChanged;

  const WorkoutItemWithDeleteConfirmation(
      {Key? key,
      required this.workoutName,
      required this.imagePath,
      required this.amount,
      required this.workoutId,
      required this.onTimesChanged})
      : super(key: key);

  @override
  _WorkoutItemWithDeleteConfirmationState createState() =>
      _WorkoutItemWithDeleteConfirmationState();
}

class _WorkoutItemWithDeleteConfirmationState
    extends State<WorkoutItemWithDeleteConfirmation> {
  int _times = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _times = widget.amount.toInt();
  } // Initial number of times

  void _incrementTimes() {
    setState(() {
      _times++;
      widget.onTimesChanged(widget.workoutId, _times);
    });
  }

  void _decrementTimes() {
    setState(() {
      if (_times > 1) {
        _times--;
        widget.onTimesChanged(widget.workoutId, _times);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            widget.imagePath,
            width: 500,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10.0,
          top: 10.0,
          child: IconButton(
            onPressed: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Are you sure you want to delete this pose?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss dialog
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss dialog
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.workoutName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementTimes,
                  icon: Icon(Icons.remove),
                  color: Colors.white,
                ),
                Text(
                  '$_times times',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _incrementTimes,
                  icon: Icon(Icons.add),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
