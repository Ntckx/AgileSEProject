import 'package:flutter/material.dart';
import '../src/widget.dart';
import 'dart:async';

class MyGetReady extends StatefulWidget {
  const MyGetReady({Key? key}) : super(key: key);

  @override
  _MyGetReadyState createState() => _MyGetReadyState();
}

class _MyGetReadyState extends State<MyGetReady> {
  int _countdown = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the countdown timer
    _startTimer();
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // If countdown reaches 0, cancel the timer
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: 
      SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFE0DEDF)),
                height: 300,
                width: 450,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'GET READY IN',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  // Display the countdown value
                  '0:$_countdown',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                if (_countdown == 0) // Conditionally render the button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/recommendedplanworkout');
                    },
                    child: Text('Continue',style: TextStyle(color:Colors.white),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
                  ),
                  SizedBox(height: 20,)
              ],
            ),),
        ],
      ),
    ));
  }
}
