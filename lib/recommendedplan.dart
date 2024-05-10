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
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'Workout list',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        edit,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/editworkout');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              WorkoutItem(
                workoutName: 'Bicycle Crunches',
                imagePath: 'assets/images/BicycleCrunches.png',
              ),
              WorkoutItem(
                workoutName: 'Pushup',
                imagePath: 'assets/images/pushup.png',
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/getready');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
}

class WorkoutItem extends StatefulWidget {
  final String workoutName;
  final String imagePath;

  const WorkoutItem({
    Key? key,
    required this.workoutName,
    required this.imagePath,
  }) : super(key: key);

  @override
  _WorkoutItemState createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  int _timesPerformed = 20;

  void _increaseTimes() {
    setState(() {
      _timesPerformed++;
    });
  }

  void _decreaseTimes() {
    if (_timesPerformed > 0) {
      setState(() {
        _timesPerformed--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            widget.imagePath,
            width: 500,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
