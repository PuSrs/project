import 'package:flutter/material.dart';
import 'recommendation_screen.dart';

class ResultScreen extends StatelessWidget {
  final int kcal = 2000; // สมมุติค่าคำนวณ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('คำนวณ Kcal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('แคลอรี่ ที่ร่างกายต้องการต่อวันคือ'),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Text('$kcal Kcal', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendationScreen()),
                );
              },
              child: Text('ถัดไป'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
