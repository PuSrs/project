import 'package:flutter/material.dart';
import 'package:myproject/page_first/genderpage.dart';

class Pagefirst extends StatelessWidget {
  final String? userId;
  const Pagefirst({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Start your\nFitness Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Start your fitness journey\nwith our app’s guidance and support.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_drink, size: 40, color: Colors.orangeAccent),
                  SizedBox(height: 10),
                  Text('Drink',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('150 ml', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // สมมุติว่าคุณมี selectedYear ที่นี่ ถ้ายังไม่มี ต้องกำหนดค่าให้ เช่น ปีปัจจุบัน - 20
                  int selectedYear = DateTime.now().year - 20;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderPage(
                        userId: userId ??
                            '', // กรณี userId เป็น null ให้ส่ง string ว่าง
                        year: selectedYear.toString(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Let's Start",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
