import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/provider.dart';
import 'package:flutter_application_1/auth/main_page.dart';
import 'package:flutter_application_1/src/localeString.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await dotenv.load(fileName: '.env');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('locale') ?? 'en_US';
  List<String> localeParts = localeCode.split('_');
  Locale initialLocale = Locale(localeParts[0], localeParts[1]);

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return GetMaterialApp(
            title: 'OKKAMLANGKAI',
            translations: LocaleString(),
            locale: initialLocale,
            fallbackLocale: const Locale('en', 'US'),
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: MainPage(),
          );
        },
      ),
    );
  }
}
