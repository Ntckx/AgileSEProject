import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leaderboard_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool theme = true;
  String option = 'English';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedOption = prefs.getString('locale');
    if (savedOption != null) {
      setState(() {
        option = savedOption == 'en_US' ? 'English' : 'Thai';
      });
    }
  }

  Future<void> _saveLanguagePreference(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localeCode = language == 'English' ? 'en_US' : 'th_TH';
    await prefs.setString('locale', localeCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings'.tr)),  // Use localized string
        backgroundColor: const Color(0xFFDA2D4A),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General Settings'.tr,  // Use localized string
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.mood,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Theme'.tr,  // Use localized string
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
                  ),
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
                      const SizedBox(width: 10),
                      Text(
                        'Language'.tr,  // Use localized string
                        style: const TextStyle(
                          color: Colors.black,
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
                      color: const Color.fromRGBO(221, 45, 74, 0.05),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        value: option,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? select) {
                          setState(() {
                            option = select!;
                            if (option == 'English') {
                              Get.updateLocale(const Locale('en', 'US'));
                              _saveLanguagePreference('English');
                            } else if (option == 'Thai') {
                              Get.updateLocale(const Locale('th', 'TH'));
                              _saveLanguagePreference('Thai');
                            }
                          });
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: 'English',
                            child: Text('english'.tr),  // Use localized string
                          ),
                          DropdownMenuItem<String>(
                            value: 'Thai',
                            child: Text('thai'.tr),  // Use localized string
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
