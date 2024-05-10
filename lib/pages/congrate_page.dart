import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/bottom_nav.dart';
import '../src/widget.dart';

class CongratePage extends StatelessWidget {
  const CongratePage({super.key});
  final int initialIndex = 1;

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
            Padding(
                padding: EdgeInsets.only(left: 14, top: 20),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/Award.png',
                      width: 400,
                      height: 400,
                    ),
                    Text(
                      "Congratulations",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text('Good job. Today, you have workout for 200 Kcal.')
                  ], /*  */
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 65),
                    backgroundColor: const Color(0xFFDA2D4A)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return BottomNavPage();
                    },
                  ));
                },
                child: const SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Back to Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
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
