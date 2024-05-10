import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/user.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterBodyInfo extends StatefulWidget {
  final AppUser user;

  const RegisterBodyInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<RegisterBodyInfo> createState() => _RegisterBodyInfoState();
}

class _RegisterBodyInfoState extends State<RegisterBodyInfo> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: widget.user.email.trim(),
                password: widget.user.password.trim())
            .then((cred) => {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(cred.user?.uid)
                      .set({
                    'email': widget.user.email,
                    'username': widget.user.username,
                    'height': int.parse(_heightController.text.trim()),
                    'weight': int.parse(_weightController.text.trim()),
                    'age': int.parse(_ageController.text.trim()),
                    'caloriesBurn' : 0,
                    'timeSpend' : 0,
                    'workoutsAmount' : 0
                  })
                });
      } catch (e) {
        print(e);
      }
    }
  }

  // Future addUserDetails(
  //     String email, String username, int height, int weight, int age) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'email': email,
  //     'username': username,
  //     'height': height,
  //     'weight': weight,
  //     'age': age
  //   });
  // }

  bool validate() {
    bool validateResult = true;
    if (_weightController.text.isEmpty) {
      validateResult = false;
    }
    if (_heightController.text.isEmpty) {
      validateResult = false;
    }
    if (_ageController.text.isEmpty) {
      validateResult = false;
    }

    return validateResult;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OK KAMLANG ΚΑΙ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Replace with your cat image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      'maxresdefault.jpg', // Replace with your asset path
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10), // Add space between image and text
                  Text(
                    'WELCOME TO OK KAMLANG KAI',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Put Your Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //weight
                  TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      hintText: 'Weight',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //height
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      hintText: 'Height',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //age
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          splashFactory:
                              NoSplash.splashFactory, // Remove splash effect
                        ),
                        child: Ink(
                          height: 50,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red.shade700, Colors.yellow],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero, // Remove padding
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: 100,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //       border: const GradientBoxBorder(
                      //         gradient: LinearGradient(
                      //             colors: [Colors.red, Colors.yellow]),
                      //         width: 4,
                      //       ),
                      //       borderRadius: BorderRadius.circular(16)),
                      // ),
                      SizedBox(
                        height: 50,
                        width: 200, // Set the desired height
                        child: OutlineGradientButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: GradientText(
                              'Back',
                              style: const TextStyle(fontSize: 20),
                              colors: [
                                Colors.red.shade700,
                                Colors.yellow.shade700
                              ],
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: [Colors.red.shade700, Colors.yellow],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                          strokeWidth: 4,
                          radius: Radius.circular(30),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            return Colors.transparent; // Remove overlay color
                          }),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
