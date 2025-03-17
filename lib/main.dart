import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myproject/common_widget/splash_screen.dart';
import 'package:myproject/home/home_page.dart';
import 'package:myproject/home/setting_screen.dart';
import 'package:myproject/home/Top_Tab_View/top_tab_view_screen.dart';
import 'package:myproject/page_first/exercises_house.dart';
import 'package:myproject/page_first/focus_area_selection_screen.dart';
import 'package:myproject/login/fillprofile.dart';
import 'package:myproject/page_first/genderpage.dart';
import 'package:myproject/login/levelpage.dart';
import 'package:myproject/page_first/inspiration.dart';
import 'package:myproject/page_first/push_ups_screen.dart';
import 'package:myproject/page_first/year.dart';
import 'package:myproject/login/targetpage.dart';
import 'package:myproject/login/welcome_page.dart';
import 'package:myproject/login/pagefirst.dart';
import 'package:myproject/hg_kg_bmi/hg_kg_bmi.dart';
import 'package:myproject/login/loginja.dart';
import 'package:myproject/login/signupja.dart';
import 'package:myproject/page_first/goalselection_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ใช้งาน firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ใช้ SplashScreen เป็นหน้าแรก 
      home: SplashScreen(child: GenderPage()), //GenderPage

      //  เพิ่ม routes สำหรับการนำทางในแอป
      // เส้นทางสำหรับของแต่ละหน้า 
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => Loginja(), // ล็อคอิน
        "/signup": (context) => Signupja(), // หน้าสมัคร
        // "/hgkgbmi": (context) => HgKgBmi(),  // หน้าน้ำหนัก ส่วนสูง ค่า BMI
        "/welcomePage": (context) => WelcomePage(), // หน้า welcome page
        "/pagefirst": (context) => Pagefirst(), 
        "/genderPage": (context) => GenderPage(),
        "/yearPage": (context) => YearPage(),
        "/targetPage": (context) => Targetpage(),
        "/levelPage": (context) => Levelpage(),  
        "/fillprofilePage": (context) => FillProfilePage(), //โปรไฟล์
        "/settingscreen": (context) => SettingScreen(),  
        "/toptabviewscreen": (context) => TopTabViewScreen(), //หน้าหลัก แสดงหน้าตาของแอพเมื่อกดข้อมูลทั้งหมดเสร็จ
        // "/goalselectionscreen": (context) => GoalSelectionScreen(),  // หน้าเป้าหมายการออกกำลังกาย
        // "/focusareaselectionscreen": (context) => FocusAreaSelectionScreen(), //หน้า เลือกส่วนที่จะออกกำลังกาย
        "/exerciseshouse": (context) => ExercisesHouse(), 
        // "/inspiration": (context) => Inspiration(),  //แรงบันดาลใจ
        // "/pushupsscreen": (context) => PushUpsScreen(),  //วิดพื้น

      },
    );
  }
}
