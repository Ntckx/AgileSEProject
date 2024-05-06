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
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/picture.png',
                      width: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
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
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft, // Align text to the left
                child: Text(
                  ' Workout list',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              workoutItemWithDeleteConfirmation(
                context,
                'Bicycle Crunches',
                'assets/BicycleCrunches.png',
              ),
              workoutItemWithDeleteConfirmation(
                context,
                'Pushup',
                'assets/pushup.png',
              ),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget workoutItemWithDeleteConfirmation(
    BuildContext context,
    String workoutName,
    String imagePath,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
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
              workoutName,
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
                  onPressed: () {
                    // Handle minus button press
                  },
                  icon: Icon(Icons.remove),
                  color: Colors.white,
                ),
                Text(
                  '20 times',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle plus button press
                  },
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
