import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/login/signupja.dart';
import 'package:myproject/login/loginja.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลัง (Background) ใช้ Gradient จากฟ้าไปส้ม
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.orangeAccent], // ไล่สีฟ้าและส้ม
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // เนื้อหาหลัก (Content)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่ตรงกลาง
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                // ชื่อแอป (Title)
                Text(
                  "FitSpark", // ชื่อแอป
                  style: GoogleFonts.kanit(
                    fontSize: 40, // ขนาดฟอนต์
                    fontWeight: FontWeight.bold, // น้ำหนักฟอนต์
                    color: Colors.white, // สีฟอนต์เป็นสีขาวเพื่อให้เด่นบนพื้นหลัง
                    letterSpacing: 3, // ระยะห่างระหว่างตัวอักษร
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 150), // ระยะห่างจากด้านบน

                // คำบรรยาย (Subtitle)
                Text(
                  "Create free time as an opportunity\nFor your health and good figure\nBy FitSpark",
                  style: GoogleFonts.kanit(
                    fontSize: 18, // ขนาดฟอนต์
                    fontWeight: FontWeight.w600, // น้ำหนักฟอนต์แบบกลาง
                    color: Colors.white, // สีตัวอักษรเป็นสีขาว
                  ),
                  textAlign: TextAlign.center, // จัดข้อความให้อยู่ตรงกลาง
                ),
                Spacer(),

                // ปุ่มหลัก (Primary Button) สำหรับการลงทะเบียน
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Loginja()), // ไปยังหน้า Register
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent, // สีพื้นหลังปุ่ม
                    padding: EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15), // ขนาดของปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // ความโค้งของปุ่ม
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.kanit(
                        fontSize: 16, // ขนาดฟอนต์ในปุ่ม
                        fontWeight: FontWeight.bold, // น้ำหนักตัวอักษร
                        color: Colors.white, // สีฟอนต์ในปุ่ม
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Signupja()), // ไปยังหน้า Register
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent, // สีพื้นหลังปุ่ม
                    padding: EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15), // ขนาดของปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // ความโค้งของปุ่ม
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: GoogleFonts.kanit(
                        fontSize: 16, // ขนาดฟอนต์ในปุ่ม
                        fontWeight: FontWeight.bold, // น้ำหนักตัวอักษร
                        color: Colors.white, // สีฟอนต์ในปุ่ม
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
