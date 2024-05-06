import 'package:flutter/material.dart';

class RecommendedPlan extends StatelessWidget {
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');

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
                      'assets/images/picture.png',
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
              Padding(
                padding:
                    EdgeInsets.all(20), // Add padding of 8 pixels on all sides
                child: Row(
                  children: [
                    Text(
                      'Workout list',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Spacer(), // Add a spacer to push the text to the right
                    IconButton(
                      icon: Icon(
                        edit,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add functionality here
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              workoutItem(
                context,
                'Bicycle Crunches',
                'assets/images/BicycleCrunches.png',
              ),
              workoutItem(
                context,
                'Pushup',
                'assets/images/pushup.png',
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
                  'Start',
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

  Widget workoutItem(
    BuildContext context,
    String workoutName,
    String imagePath,
  ) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            width: 500,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                workoutName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '20 times',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
