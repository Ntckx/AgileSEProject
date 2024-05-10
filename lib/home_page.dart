import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKKAMLANGKAI',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 14, top: 50),
                child: Text(
                  "Recommend Plan",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 4),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Workout#1.png'),
                      fit:BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.darken)
                      )
                  ),
                  height: 150,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'DAY1',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1),
                        ),
                        const Text(
                          'This month 1400cal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(300, 40),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,'/recommendedplan');

                              },
                              child: const Text(
                                'Start',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, top: 25),
              child: Text(
                "Your own desire",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, top: 4),
              child: 
              Cardplan(
                planname: "ABS",
                details: "20 Min - 16 gestures",
                imagePath: 'assets/images/ABS.png',
                descriptionTopic: 'ABS',
                descriptionDetail: 'Abs, short for abdominals, refer to the muscles in your midsection. They include the rectus abdominis, obliques, and transverse abdominis. Exercises like crunches, planks, and leg raises can help strengthen and define your abs. Focus on proper form and engage your core muscles throughout each movement for best results.',
              )
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, top: 15),
              child: Cardplan (planname: "ARMS",details: "30 Min - 25 gestures",imagePath: 'assets/images/ARMS.jpg',descriptionTopic: 'ARMS', descriptionDetail: "Arms include biceps, triceps, and forearms. Strengthen them with exercises like bicep curls, tricep dips, and forearm curls using weights or resistance bands. Focus on proper form and gradually increase resistance for results.")
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
    ));
  }
}
