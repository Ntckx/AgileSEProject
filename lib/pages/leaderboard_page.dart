import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyLeaderBoardPage extends StatelessWidget {
  const MyLeaderBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Logo()),
        backgroundColor: const Color(0xFFDA2D4A),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "LeaderBoard",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors:[Color.fromRGBO(255, 215, 0, 100),Color.fromRGBO(218, 45, 74, 100)] , begin: Alignment.topCenter,end: Alignment.bottomCenter)
                ),
                height: 250,
                width: 400,
                child: DataTable( dividerThickness: 0.00000000001,columns: const [
                  DataColumn(label: Text('Rank')),
                  DataColumn(label: Text('User')),
                  DataColumn(label: Text('Kcal')),
                  
                ], rows: const [
                  DataRow(
                      cells: [
                        DataCell(Text('1')), 
                        DataCell(Text('Ratchanon')),
                        DataCell(Text('150000')),
                                                
                        ],
                        
                        ),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('Jack')),
                      DataCell(Text('25000'))
                    ])
                ]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Statistic",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFDA2D4A).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: 400,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  
                                  Column(
                                    children: [
                                      Text(
                                        "Workouts",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "54",
                                         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Kcal",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "105923",
                                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Minutes",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "30",
                                         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(height: 5), // Add spacing between rows
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: <Widget>[
                              //     Text(
                              //       "54",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 20,
                              //       ),
                              //     ),
                              //     Text(
                              //       "1059",
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20),
                              //     ),
                              //     Text(
                              //       "542",
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'OK KAMLANGKAI',
      style: TextStyle(color: Colors.white),
    );
  }
}
