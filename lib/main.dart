import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myproject/login/loginja.dart'; // ✅ หน้าล็อกอิน
import 'package:myproject/home/home_page.dart';
import 'package:myproject/home/setting_screen.dart';
import 'package:myproject/home/Top_Tab_View/top_tab_view_screen.dart';
import 'package:myproject/page_first/exercise_plan_screen.dart';
import 'package:myproject/page_first/exercises_house.dart';
import 'package:myproject/login/levelpage.dart';
import 'package:myproject/login/targetpage.dart';
import 'package:myproject/login/welcome_page.dart';
import 'package:myproject/login/pagefirst.dart';
import 'package:myproject/login/signupja.dart';
import 'package:myproject/page_first/genderpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ ให้ Splash → Loginja() เป็นหน้าแรกเสมอ
      home: Loginja(),

      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => Loginja(),
        "/signup": (context) => Signupja(),
        "/welcomePage": (context) => WelcomePage(),
        "/pagefirst": (context) => Pagefirst(),
        "/targetPage": (context) => Targetpage(),
        "/levelPage": (context) => Levelpage(),
        "/settingscreen": (context) => SettingScreen(),
        "/toptabviewscreen": (context) => TopTabViewScreen(),
        "/exerciseshouse": (context) => ExercisesHouse(),
        "/exercisePlanScreen": (context) => ExercisePlanScreen(),
      },
    );
  }
}
