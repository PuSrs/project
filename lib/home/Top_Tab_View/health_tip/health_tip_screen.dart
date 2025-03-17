import 'package:flutter/material.dart';
import 'package:myproject/home/Top_Tab_View/health_tip/health_tip_row.dart';

class HealthTipScreen extends StatefulWidget {
  const HealthTipScreen({super.key});

  @override
  State<HealthTipScreen> createState() => _HealthTipScreenState();
}

class _HealthTipScreenState extends State<HealthTipScreen> {
  // สร้าง List ของข้อมูลที่ใช้แสดงผลใน ListView
  final List<Map<String, String>> listArr = [
    {
      "title": "A Diet Without Exercise is Useless.",
      "subtitle":
          "Interval training is a form of exercise in which you alternate between or more exercises.",
      "image": "assets/images/exercise1.png",
    },
    {
      "title": "Garlic.",
      "subtitle": "Garlic is the plant that helps with exercise and overall health.",
      "image": "assets/images/exercise2.png", // ใช้ key "image" ให้ตรงกับที่ใช้ใน HealthTipRow
    },
    {
      "title": "Garlic1.",
      "subtitle": "Garlic is a natural remedy that supports immune function and stamina.",
      "image": "assets/images/exercise3.png", // ใช้ key "image" ให้ตรงกับที่ใช้ใน HealthTipRow
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // กำหนดระยะห่างรอบ ListView
        itemCount: listArr.length, // จำนวนรายการที่ต้องการแสดง
        itemBuilder: (context, index) {
          var obj = listArr[index]; // ดึงข้อมูลแต่ละรายการ

          return HealthTipRow(
            obj: obj, // ส่งข้อมูลไปยัง HealthTipRow
            onPressed: () {
              // เมื่อกดที่รายการ จะแสดงชื่อ Title ใน Console
              print("Selected: ${obj["title"]}");
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20), // กำหนดระยะห่างระหว่างรายการ
      ),
    );
  }
}
