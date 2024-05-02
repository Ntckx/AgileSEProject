// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'src/widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'OKKAMLANGKAI',
//         theme: ThemeData(
//           textTheme: GoogleFonts.robotoTextTheme(),
//           useMaterial3: true,
//         ),
//         home: const WorkoutPage());
//   }
// }

// class WorkoutPage extends StatelessWidget {
//   const WorkoutPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Logo()),
//         backgroundColor: const Color(0xFFDA2D4A),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 25),
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Container(
//                   width: double.infinity,
//                   height: 300,
//                   color: const Color(0xFFE0DEDF).withOpacity(0.1),
//                 ),
//                 Center(
//                   child: Container(
//                     width: 400,
//                     height: 250,
//                    decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image:  const DecorationImage(
//               image: AssetImage('assets/gif/Bicycle.gif'),
//               fit: BoxFit.cover,
             
//             )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 40),
//           const Text(
//             'Bicycle Crunches',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 80),
//           const Text(
//             '20 times',
//             style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 80),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(250, 65),
//                 backgroundColor: const Color(0xFFDA2D4A)),
//             onPressed: () {},
//             child: const SizedBox(
//               width: 300,
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Complete',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 10),
//                   Icon(Icons.check_circle_outline_rounded,color: Colors.white,size: 30,),
                 
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
