import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/provider.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool theme = true;
  String option = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings'.tr)), // Use localized string
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'General Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                       
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.mood,
                            
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Theme',
                            style: TextStyle(
                            
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: notifier.isDark,
                        onChanged: (value) => notifier.changeTheme() ,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.language,
                          
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Language',
                            style: TextStyle(
                          
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: const Color(0xFFDA2D4A)),
                            color: const Color.fromRGBO(221, 45, 74, 0.05)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            value: option,
                          
                            onChanged: (String? select) {
                              setState(() {
                                option = select!;
                              });
                            },
                            icon: null,
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'English',
                                child: Text('English'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Thai',
                                child: Text('Thai'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
