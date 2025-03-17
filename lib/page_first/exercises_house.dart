import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisesHouse extends StatelessWidget {
  const ExercisesHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ส่วนหัวของหน้าจอ
      appBar: AppBar(
        title: Text(
          "Before After Exercises",
          style: GoogleFonts.kanit(
            color: Colors.blue,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/inspiration");
          },
          color: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวข้อของหน้า
            Text(
              "ออกกำลังกายที่บ้านเปลี่ยนร่างกายของคุณอย่างไร",
              style: GoogleFonts.kanit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // ส่วนแสดงภาพ Before และ After
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // รูปภาพ 
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/before.png', // ใส่รูปภาพ 
                            width: 100,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text("Before", style: GoogleFonts.kanit(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  
                  // ไอคอนลูกศรแสดงการเปลี่ยนแปลง
                  Icon(Icons.arrow_forward, size: 40, color: Colors.green),
                  
                  // รูปภาพ After
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/after.png', // ใส่รูปภาพ 
                            width: 100,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text("After", style: GoogleFonts.kanit(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // ข้อความอธิบายผลลัพธ์ของการออกกำลังกาย
            Text(
              "เราสามารถช่วยคุณเผาผลาญไขมันได้อย่างมีประสิทธิภาพ สร้างกล้ามเนื้อ ปรับปรุงท่าทาง และเพิ่มความเป็นอยู่ที่ดีโดยรวม",
              style: GoogleFonts.kanit(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            
            const Spacer(),
            
            // ปุ่มไปหน้าถัดไป
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/toptabviewscreen");
              },
              child: Text(
                "ถัดไป",
                style: GoogleFonts.kanit(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
