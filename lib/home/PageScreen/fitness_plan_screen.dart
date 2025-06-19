import 'package:flutter/material.dart';
import 'package:myproject/home/profile_screen.dart';
import 'fitness_plan_screen_page.dart'; // อย่าลืม import หน้านี้

class FitnessPlanScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const FitnessPlanScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แผนของคุณ'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage:
                AssetImage("assets/images/Calendar--Streamline-Ultimate.png"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.network(
              'https://img.lovepik.com/png/20231112/trainer-clipart-cartoon-illustration-of-a-man-pointing-vector-cartoon_568493_wh1200.png',
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              'แผนของคุณพร้อมแล้ว!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'เราได้เลือกแผนนี้ที่เหมาะกับคุณที่สุด',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    'https://img.freepik.com/premium-vector/muscular-man-with-sixpack-gives-pose-vector-illustration_851674-44316.jpg?semt=ais_hybrid',
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ร่างกายทั้งตัว\nคำท้า 7X4',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'เริ่มการเดินทางของคุณในการทำรูปร่างร่างกาย\nเพื่อเน้นกล้ามเนื้อทุกกลุ่มและสร้างร่างกายที่คุณฝันในเวลา 4 สัปดาห์!',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // การทำงานเมื่อกดปุ่ม เริ่มเลย
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'เริ่มเลย',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FitnessPlanScreenPage(userData: userData),
                  ),
                );
              },
              child: Text(
                'ไปที่หน้าแรก',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
