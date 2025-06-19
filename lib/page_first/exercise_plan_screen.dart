import 'package:flutter/material.dart';

class ExercisePlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('แผนออกกำลังกายสำหรับคุณ')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('อายุ: ${args['age']} ปี', style: const TextStyle(fontSize: 22)),
            Text('ช่วงอายุ: ${args['ageGroup']}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text(
              'แนะนำให้ออกกำลังกาย ${args['exerciseDaysPerWeek']} วัน/สัปดาห์',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text('คำแนะนำ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(args['recommendation'], style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
