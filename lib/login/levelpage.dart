import 'package:flutter/material.dart';

class Levelpage extends StatefulWidget {
  @override
  _LevelpageState createState() => _LevelpageState();
}

class _LevelpageState extends State<Levelpage> {
  int selectedLevel = -1; // เก็บค่าระดับที่ถูกเลือก (-1 หมายถึงยังไม่เลือก)

  List<String> activityLevels = ["Beginner", "Intermediate", "Advanced"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ตั้งค่าพื้นหลังเป็นสีขาว
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Physical Activity Level?",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Choose your regular activity level. This will help us to personalize plans for you.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: activityLevels.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLevel = index; // เปลี่ยนค่าที่เลือก
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedLevel == index ? Colors.orange : Colors.blue, // กรอบเปลี่ยนสีเมื่อถูกเลือก
                          width: 2,
                        ),
                        color: selectedLevel == index ? Colors.orange.withOpacity(0.2) : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          activityLevels[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue), // ปุ่มย้อนกลับสีฟ้า
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // ปุ่มถัดไปสีส้ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: selectedLevel == -1
                      ? null // ปิดการใช้งานปุ่มถ้ายังไม่เลือก
                      : () {
                          Navigator.pushNamed(context, "/toptabviewscreen"); // ไปหน้าถัดไป
                        },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
