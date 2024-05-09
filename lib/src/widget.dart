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
  final String descriptionTopic;
  final String descriptionDetail;
  const Cardplan(
      {super.key,
      required this.planname,
      required this.details,
      required this.imagePath,
      required this.descriptionDetail,
      required this.descriptionTopic,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken))),
        height: 150,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text(descriptionTopic),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(descriptionDetail),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon:
                        Icon(Icons.info_outline, size: 30, color: Colors.white),
                  ),
                ),
              ),
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
  const Calcard(
      {super.key,
      required this.posture,
      required this.amount,
      required this.kcal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFDA2D4A).withOpacity(0.5)),
          height: 100,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                Icons.fitness_center,
                size: 40,
              ),
              Text(
                posture,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(amount,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("${kcal}kcal",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )),
    );
  }
}
