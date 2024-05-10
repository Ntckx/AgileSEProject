import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/pages/registerBodyInformation.dart';
import 'package:flutter_application_1/src/user.dart';
// import 'package:flutter_application_1/src/widget.dart';

class Register extends StatefulWidget {
  final VoidCallback showLoginpage;

  const Register({super.key, required this.showLoginpage});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool Validate() {
    bool validateResult = true;
    if (_usernameController.text.isEmpty) {
      validateResult = false;
    }
    if (_emailController.text.isEmpty) {
      validateResult = false;
    }
    if (_passwordController.text.isEmpty) {
      validateResult = false;
    }
    if (_confirmPasswordController.text.isEmpty) {
      validateResult = false;
    }
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      validateResult = false;
    }

    return validateResult;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(500)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.asset(
                        '../assets/maxresdefault.jpg',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'WELCOME TO OK KAMLANG KAI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                          if (Validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterBodyInfo(
                                      user: AppUser(
                                          username:
                                              _usernameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim())),
                                ));
                          }
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
                              'Next',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 16),
                      ),
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
                        child: GestureDetector(
                          onTap: widget.showLoginpage,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
