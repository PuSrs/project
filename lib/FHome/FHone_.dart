import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/FHome/FHtwo_.dart';

class FHone extends StatelessWidget {
  final String userId;

  FHone({required this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fproject2.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 30),
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
                  color: Colors.grey.shade700
                      .withOpacity(0.7), // สีเทาเข้มโปร่งแสง
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

          // ปุ่มกลม ล่างสุดตรงกลาง
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createRoute());
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

  // การใส่ฟังก์ชันสร้าง Route กับ Animation (Slide + Fade)
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FHtwo(
        userId: userId,
      ), // หน้า FHtwo โดยรับ context และ animation สำหรับการเคลื่อนไหวหน้าจอ

      // กำหนด Animation ระหว่างการเปลี่ยนหน้า
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // กำหนดจุดเริ่มต้นของการเคลื่อนที่ (Offset)

        const begin = Offset(1.0,
            0.0); // เริ่มจากตำแหน่ง x=1.0 (นอกหน้าจอด้านขวา), y=0.0 (ไม่เลื่อนแนวตั้ง)

        const end = Offset
            .zero; // สิ้นสุดของการเคลื่อนที่ คือ หน้าถัดไปในตำแหน่งปกติของหน้า

        const curve = Curves
            .ease; // เลือก curve ของ animation เป็น ease (ค่อย ๆ เร็วขึ้นและช้าลง)

        var tween = Tween(begin: begin, end: end).chain(CurveTween(
            curve:
                curve)); // Tween สำหรับการเลื่อน (Slide) จาก begin → end พร้อมปรับความเร็วตาม curve

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(
            curve:
                curve)); // Tween สำหรับการเปลี่ยนความโปร่งแสง (opacity) จาก 0 (โปร่งใส) → 1 (ทึบ)

        return SlideTransition(
          // สร้าง Animation SlideTransition โดยใช้ tween ควบคุมตำแหน่ง
          position: animation.drive(tween),
          // ซ้อนด้วย FadeTransition เพื่อให้หน้าค่อย ๆ ปรากฏ (fade in)
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child, // child คือหน้าจอ FHtwo() ที่จะโชว์
          ),
        );
      },
    );
  }
}
