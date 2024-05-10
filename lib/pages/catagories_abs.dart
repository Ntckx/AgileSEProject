import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/workout_page.dart';
import '../src/widget.dart';

class AbsPage extends StatelessWidget {
  const AbsPage({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                const AssetImage('assets/images/Workout#1.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken))),
                    height: 150,
                    width: 400,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 45, left: 20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Good Choice',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Here is Your ABS Plan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Workout list",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  
                  const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Cardplan(
                        planname: "Bicycle Crunches",
                        details: "20 times",
                        imagePath: 'images/Bicycle2.jpg',
                      )),
                  const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Cardplan(
                        planname: "Push up",
                        details: "100 times",
                        imagePath: 'images/Pushup1.jpg',
                      )),
                ],
              ),
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
                            builder: ((context) => WorkoutPage())));
                  },
                  child: const SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Start',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.white,
                          size: 30,
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
