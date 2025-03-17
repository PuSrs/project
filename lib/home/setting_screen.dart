import 'package:flutter/material.dart';
import 'package:myproject/home/profile_screen.dart';
import 'package:myproject/home/setting_row.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // ปุ่มย้อนกลับที่ปรับแต่งเอง
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปยังหน้าก่อนหน้า
          },
        ),
        title: Text(
          "การตั้งค่า", // เปลี่ยนเป็นคำว่า "Setting" เป็น "การตั้งค่า"
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SettingRow(
              title: "โปรไฟล์", // เปลี่ยนเป็น "Profile" เป็น "โปรไฟล์"
              icon: "assets/images/capybara.png",
              isIconCircle: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
          SettingRow(
              title: "ตัวเลือกภาษา", //  Language options 
              icon: "assets/images/mouse.png",
              value: "Eng", // ค่าเริ่มต้นเป็น Eng
              onPressed: () {}),
          SettingRow(
              title: "ข้อมูล FitSpark", // FitSpark Data
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
          SettingRow(
              title: "การแจ้งเตือน", // Notification
              icon: "assets/images/mouse.png",
              value: "เปิด", // เปลี่ยนจาก "On" เป็น "เปิด"
              onPressed: () {}),
          SettingRow(
              title: "แนะนำเพื่อน", // Refer a Friend
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
          SettingRow(
              title: "ข้อเสนอแนะ", // Feedback
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
          SettingRow(
              title: "ให้คะแนนเรา", // Rate us
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
          SettingRow(
              title: "ออกจากระบบ", // Log out
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
        ],
      ),
    );
  }
}
