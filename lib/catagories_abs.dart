import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/congrate_page.dart';
import 'package:flutter_application_1/workout_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OKKAMLANGKAI',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: true,
        ),
        home: const AbsPage());
  }
}

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
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.info_outline,size: 30,color: Colors.white),
                              ),
                            ),
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
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  "Your own desire",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Cardplan(
                    planname: "Bicycle Crunches",
                    details: "20 times",
                    imagePath: 'assets/images/Bicycle2.jpg',
                    descriptionTopic: 'Bicycle Crunches',
                    descriptionDetail: 'Bicycle crunches are a core exercise where you lie on your back, lift your legs, and alternately bring your knees towards your chest while twisting your torso to touch the opposite elbow to knee. They work your abs, obliques, and hip flexors. Lie down, hands behind your head, knees up. Lift your head, neck, and shoulders, then pedal your legs like riding a bike while twisting your torso to touch elbows to knees alternately. Aim for controlled movements and engage your core throughout.',
                  )),
              const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Cardplan(
                    planname: "Push up",
                    details: "100 times",
                    imagePath: 'assets/images/Pushup1.jpg',
                    descriptionTopic: 'Push up',
                    descriptionDetail: 'Push-ups are a classic bodyweight exercise that target the chest, shoulders, and arms. Start in a plank position with hands shoulder-width apart, lower your body until your chest nearly touches the ground, then push back up to the starting position. Keep your core engaged and body in a straight line throughout the movement.',
                  )),
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
              const Padding(
                padding: EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 40.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.home,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.leaderboard,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: 40.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
