import 'package:flutter/material.dart';
import 'package:myproject/home/Top_Tab_View/exercises/exercises_cell.dart';
import 'package:myproject/home/Top_Tab_View/exercises/exercises_name_screen.dart';

class ExercisesTabScreen extends StatefulWidget {
  const ExercisesTabScreen({super.key});

  @override
  State<ExercisesTabScreen> createState() => _ExercisesTabScreenState();
}

class _ExercisesTabScreenState extends State<ExercisesTabScreen> {
  // รายการข้อมูลสำหรับแสดงผลใน GridView
  final List<Map<String, String>> listArr = [
    {
      "title": "Chest",
      "subtitle": "16 Exercises",
      "image": "assets/images/ex1.png",
    },
    {
      "title": "Back",
      "subtitle": "16 Exercises",
      "image": "assets/images/ex2.png",
    },
    {
      "title": "Biceps",
      "subtitle": "16 Exercises",
      "image": "assets/images/ex3.png",
    },
    {
      "title": "Triceps",
      "subtitle": "16 Exercises",
      "image": "assets/images/ex4.png",
    },
    {
      "title": "Shoulders",
      "subtitle": "16 Exercises",
      "image": "assets/images/ex5.png",
      
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // กำหนดจำนวนคอลัมน์ใน GridView เป็น 2 คอลัมน์
          childAspectRatio: 1, // อัตราส่วนกว้าง-สูงของแต่ละไอเท็ม
          crossAxisSpacing: 15, // ระยะห่างระหว่างไอเท็มในแนวนอน
          mainAxisSpacing: 15, // ระยะห่างระหว่างไอเท็มในแนวตั้ง
        ),
        itemCount: listArr.length, // จำนวนไอเท็มใน GridView
        itemBuilder: (context, index) {
          var obj = listArr[index]; // ดึงข้อมูลแต่ละไอเท็มจาก listArr

          return ExercisesCell(
            obj: obj,
            onPressed: () {
              // เมื่อกดที่ไอเท็ม ให้ไปยังหน้าถัดไป (ซึ่งอาจต้องเปลี่ยนให้เหมาะสม)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisesNameScreen(),
                ),
                
              );
            },
          );
        },
      ),
    );
  }
}