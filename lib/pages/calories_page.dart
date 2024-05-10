import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/congrate_page.dart';
import '../src/widget.dart';

class CaloriesPage extends StatelessWidget {
  const CaloriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: Center(
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
                child: const Center(
                    child: Text(
                  '200 kcal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),

            //Card

            Calcard(
                posture: "Bicycle Crunches", amount: "20 times", kcal: 200.00),
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
                          builder: ((context) => CongratePage())));
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
    );
  }
}
