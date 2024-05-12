import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/catagories_abs.dart';
import 'package:flutter_application_1/pages/edit_workout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../src/widget.dart';

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
      home: MySearch(),
    );
  }
}

class MySearch extends StatelessWidget {
  MySearch({super.key});
  final TextEditingController _textController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              ),
            ),
            const SizedBox(
                height: 40), // Add some space between TextField and Text widget
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Recently',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AbsPage()));
                        },
                        child: const Cardplan(
                          planname: 'ABS',
                          details: '20 Min - 16 gestures',
                          imagePath: 'assets/images/ABS.png',
                          descriptionTopic: "Lorem",
                          descriptionDetail:
                              "Amet cupidatat aliqua et id reprehenderit ex quis ullamco.",
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AbsPage()));
                        },
                        child: const Cardplan(
                          planname: 'Arms',
                          details: '30 Min - 25 gestures',
                          imagePath: 'assets/images/ARMS.jpg',
                          descriptionTopic: "Lorem",
                          descriptionDetail:
                              "Amet cupidatat aliqua et id reprehenderit ex quis ullamco.",
                        ),
                      ),
                    ),
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
