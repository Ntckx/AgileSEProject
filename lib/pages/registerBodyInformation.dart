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
  List<String> items = ['Male', 'Female', 'None'];
  String? selectedItem;

  bool isChecked = false;

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
                    'sex': selectedItem,
                    'caloriesBurn': 0,
                    'timeSpend': 0,
                    'workoutsAmount': 0
                  })
                });
      } catch (e) {
        print(e);
      }
    }
  }

  void _showCheckBoxAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Terms and Conditions"),
          content:
              Text("You must agree to the terms and conditions to proceed."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      'images/maxresdefault.jpg', // Replace with your asset path
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      hintText: 'Height',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Sex',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: selectedItem,
                    items: items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors
                                  .black; // Color of the checkbox itself when checked
                            }
                            return Colors
                                .white; // Color of the checkbox itself when not checked
                          }),
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue ?? false;
                            });
                          },
                        ),
                        Text(
                          'I agree to ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    "Terms and Conditions\nIMPORTANT: PLEASE READ THESE TERMS AND CONDITION BEFORE USING OK KAMLANG KAI",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      "1. Disclaimer\n\nThe App is intended for informational purposes only and should not be construed as medical advice. The information provided in the App is not a substitute for professional medical advice, diagnosis, or treatment. You should always consult with your physician before beginning any new exercise program, especially if you have any existing medical conditions.\n\n2. Use of the App\n\nThe App is intended for a general audience and may not be suitable for everyone. You are responsible for determining whether the App is appropriate for you.\n\n3. Limitations\n\nThe App and the information provided within it are provided 'as is' and without warranties of any kind, express or implied. The developers and distributors of the App disclaim all warranties, express or implied, including but not limited to, implied warranties of merchantability, fitness for a particular purpose, and non-infringement.\n\n4. Specific Warning for Users with Diabetes\n\nPeople with diabetes should consult with their physician before using this App. Exercise programs can affect blood sugar levels, and it is important to work with your doctor to create a safe and effective exercise plan that meets your individual needs.",
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Close",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)),
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        enableFeedback:
                                            false, // Disable ripple effect
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Text(
                              'Terms and Conditions*',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.orange),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (isChecked) {
                            if (selectedItem != null) {
                              signUp();
                            } else {
                              // Show alert or snackbar indicating that the sex field is required
                            }
                          } else {
                            _showCheckBoxAlert();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          splashFactory: NoSplash.splashFactory,
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
                            padding: EdgeInsets.zero,
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
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
                  SizedBox(height: 20),
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
                              return Colors.transparent;
                            },
                          ),
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
