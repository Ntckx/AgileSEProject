import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../src/widget.dart';

class MySearch extends StatefulWidget {
  MySearch({Key? key}) : super(key: key);

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _textController = TextEditingController(text: "");
  List<DocumentSnapshot> _searchResults = [];

  Future<void> _searchPlans(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('defaultPlan')
        .where('planname', isGreaterThanOrEqualTo: query)
        .where('planname', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      _searchResults = result.docs;
    });
  }

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
              onSubmitted: (query) {
                _searchPlans(query);
              },
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final plan = _searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        onTap: () {
                          // Navigate to the plan detail page if needed
                        },
                        child: Cardplan(
                          planname: plan['planname'],
                          details:
                              '${plan['duration']} Mins - ${plan['gestureAmount']} gestures',
                          imagePath: 'assets/images/ABS.png',
                          descriptionTopic: plan['planname'],
                          descriptionDetail: plan['description'],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
