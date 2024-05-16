import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'leaderboard_page.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General Settings'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.mood,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'theme'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: theme,
                    activeColor: const Color.fromRGBO(221, 45, 74, 0.05),
                    onChanged: (bool value) {
                      setState(() {
                        theme = value;
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'language'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
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
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? select) {
                          setState(() {
                            option = select!;
                            if (option == 'English') {
                              Get.updateLocale(Locale('en', 'US'));
                            } else if (option == 'Thai') {
                              Get.updateLocale(Locale('th', 'TH'));
                            }
                          });
                        },
                        icon: null,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'English',
                            child: Text('English'.tr),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Thai',
                            child: Text('Thai'.tr),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
