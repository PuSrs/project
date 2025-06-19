import 'package:flutter/material.dart';

// หน้ารายละเอียดของกล้ามเนื้อแต่ละส่วน
class BodyPartDetailsPage extends StatelessWidget {
  final String bodyPart;

  const BodyPartDetailsPage({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ฝึก $bodyPart'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'แผนการฝึกสำหรับ $bodyPart',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}