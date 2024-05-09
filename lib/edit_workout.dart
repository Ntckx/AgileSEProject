import 'package:flutter/material.dart';

class EditWorkoutABS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OK KAMLANG KAI'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Other widgets...
              WorkoutItemWithDeleteConfirmation(
                workoutName: 'Bicycle Crunches',
                imagePath: 'assets/images/BicycleCrunches.png',
              ),
              WorkoutItemWithDeleteConfirmation(
                workoutName: 'Pushup',
                imagePath: 'assets/images/pushup.png',
              ),
              // Other widgets...
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
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

  const WorkoutItemWithDeleteConfirmation({
    Key? key,
    required this.workoutName,
    required this.imagePath,
  }) : super(key: key);

  @override
  _WorkoutItemWithDeleteConfirmationState createState() =>
      _WorkoutItemWithDeleteConfirmationState();
}

class _WorkoutItemWithDeleteConfirmationState
    extends State<WorkoutItemWithDeleteConfirmation> {
  int _times = 20; // Initial number of times

  void _incrementTimes() {
    setState(() {
      _times++;
    });
  }

  void _decrementTimes() {
    setState(() {
      if (_times > 1) {
        _times--;
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
                      Spacer(),
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
