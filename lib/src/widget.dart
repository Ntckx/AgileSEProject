import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/bottom_nav.dart';
import 'package:flutter_application_1/src/workout.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'OK KAMLANG KAI',
      style: TextStyle(
          fontFamily: GoogleFonts.monofett().fontFamily,
          color: Colors.white,
          fontSize: 32),
    );
  }
}

class Cardplan extends StatelessWidget {
  final String planname;
  final String details;
  final String imagePath;
  final String descriptionTopic;
  final String descriptionDetail;
  const Cardplan({
    super.key,
    required this.planname,
    required this.details,
    required this.imagePath,
    required this.descriptionDetail,
    required this.descriptionTopic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken))),
        height: 150,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(descriptionTopic),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(descriptionDetail),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon:
                        const Icon(Icons.info_outline, size: 30, color: Colors.white),
                  ),
                ),
              ),
              Text(
                planname,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                details,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}

class Workoutplan extends StatefulWidget {
  final Workout workout;
  final String imagePath;
  final String planId;
  final String planname;
  final String email;

  const Workoutplan(
      {Key? key,
      required this.workout,
      required this.imagePath,
      required this.planId,
      required this.planname,
      required this.email})
      : super(key: key);

  @override
  State<Workoutplan> createState() => _WorkoutplanState();
}

class _WorkoutplanState extends State<Workoutplan> {
  int _number = 0;

  void addWorkout() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('workouts');

    try {
      await collectionReference.add({
        'amount': _number,
        'description': widget.workout.description,
        'metValue': widget.workout.metValue.toInt(),
        'planId': widget.planId,
        'planname': 'new_${widget.email}_${widget.planname}_workout',
        'workoutName': widget.workout.workoutName
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: const Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0), // Add underline
          ),
        ),
        height: 150,
        width: 450,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 150, // Set the width of the image container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.workout.workoutName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // Text(
                    //   details,
                    //   style: const TextStyle(color: Colors.black),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const  Icon(Icons.remove),
                          onPressed: () {
                            if (_number > 0) {
                              setState(() {
                                _number--;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 50,
                          child: Center(child: Text('$_number')),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _number++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  addWorkout();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const BottomNavPage();
                    },
                  ));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text(
                  'ADD +',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NumberInputDialog extends StatefulWidget {
  const NumberInputDialog({super.key});

  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a Number'),
      content: SizedBox(
        height: 100, // Set the height here
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_number > 0) {
                        setState(() {
                          _number--;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 50,
                    child: Center(child: Text('$_number')),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _number++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      // print('Selected number: $_number');
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Calcard extends StatelessWidget {
  final String posture;
  final String amount;
  final double kcal;
  const Calcard(
      {super.key,
      required this.posture,
      required this.amount,
      required this.kcal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFDA2D4A).withOpacity(0.5)),
          height: 100,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Icon(
                Icons.fitness_center,
                size: 40,
              ),
              Text(
                posture,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(amount,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("${kcal.toStringAsFixed(2)}kcal",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )),
    );
  }
}
