import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
            'OK KAMLANG KAI',
            style: TextStyle(fontFamily: GoogleFonts.monofett().fontFamily,color: Colors.white,fontSize: 32),);
  }
}

class Cardplan extends StatelessWidget {
  final String planname;
  final String details;
  const Cardplan({super.key, required this.planname, required this.details});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  height: 150,
                  width: 400,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(planname, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text(details, style: const TextStyle(color: Colors.white),),
                      ],
                    ),
                  ));
  }
}