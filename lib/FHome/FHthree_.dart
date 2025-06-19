import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/page_first/year.dart';

class FHthree extends StatelessWidget {
  final String userId;

  FHthree({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลังภาพเต็มหน้าจอ
          Positioned.fill(
            child: Image.asset(
              'assets/images/fproject3.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // ทับด้วย Container สีดำใส เพื่อให้ภาพพื้นหลังมืดลง ช่วยให้ข้อความเด่นขึ้น
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // SafeArea และเนื้อหากลางหน้าจอ (ชื่อและข้อความ)
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ชื่อแอป FitSpark ใช้ฟอนต์ Kanit ขนาดใหญ่ หนักตัวอักษร และสีขาว
                    Text(
                      "FitSpark",
                      style: GoogleFonts.kanit(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30), // เว้นระยะห่าง

                    // คำอธิบายแอป ขนาดเล็กลงเล็กน้อย และยังคงใช้ฟอนต์ Kanit สีขาว
                    Text(
                      "Create free time as an opportunity\nFor your health and good figure\nBy FitSpark",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ปุ่มกลับ (ย้อนกลับหน้าก่อนหน้า) อยู่ด้านล่างซ้าย
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // กลับไปยังหน้าก่อนหน้าใน stack
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700.withOpacity(0.7), // สีเทาเข้มโปร่งแสง
                  shape: BoxShape.circle, // ทำปุ่มเป็นวงกลม
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // เงาดำโปร่งแสง
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          // ปุ่มถัดไป (ไปหน้าถัดไป) อยู่ล่างกลางจอ
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createRoute()); // กดแล้วเปิดหน้าจอใหม่แบบ Animation
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ฟังก์ชันสร้าง Route พร้อม Animation (เลื่อนจากขวา + Fade in)
  Route _createRoute() {
    return PageRouteBuilder(
      // หน้าที่จะเปิดไป คือ FHage() (ถ้าเปลี่ยนเป็นหน้าอื่น ให้แก้ที่นี่)
      pageBuilder: (context, animation, secondaryAnimation) => YearPage(userId: userId,),

      // กำหนด Animation ระหว่างเปลี่ยนหน้า
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // เริ่มเลื่อนมาจากขวา (x=1.0) ไปตำแหน่งปกติ (0,0)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease; // ความเร็ว Animation แบบ ease-in-out

        // สร้าง Tween การเคลื่อนที่ (slide) พร้อมปรับความเร็วตาม curve
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        // สร้าง Tween การเปลี่ยนความโปร่งแสง (fade) จาก 0 ถึง 1
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween), // ขยับตำแหน่งของหน้าจอไปมา
          child: FadeTransition(
            opacity: animation.drive(fadeTween), // ค่อย ๆ ปรากฏ (fade in)
            child: child, // หน้าจอที่จะแสดง (year)
          ),
        );
      },
    );
  }
}
