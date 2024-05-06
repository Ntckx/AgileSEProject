import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'OK KAMLANG KAI',
      style: TextStyle(
          fontFamily: GoogleFonts.monofett().fontFamily,
          color: Colors.white,
          fontSize: 32),
    );
  }
}

class Cardplan extends StatelessWidget {
  final String planname;
  final String details;
  final String imagePath;
  const Cardplan({super.key, required this.planname, required this.details , required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.darken)
            )),
        height: 150,
        width: 400,
        child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                planname,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                details,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}

class Calcard extends StatelessWidget {
  final String posture;
  final String amount; 
  final double kcal; 
  const Calcard({super.key, required this.posture , required this.amount , required this.kcal});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFDA2D4A).withOpacity(0.5)
                  ),
                  height: 100,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [
                      Icon(Icons.fitness_center,size: 40,),
                      Text(posture, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(amount, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      Text("${kcal}kcal", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ],
                  )),
            );
  }
}