import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/common_widget/toast.dart';
import 'package:myproject/FHome/FHone_.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลผู้ใช้ที่ล็อกอินอยู่ในปัจจุบันจาก FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        // ชื่อหน้าด้านบนแทป (AppBar)
        title: const Text(
          'Welcome Home Buddy',
          style: TextStyle(color: Colors.white), // สีข้อความบน AppBar
        ),
        centerTitle: true, //จัดกลาง
        backgroundColor: Colors.blueAccent, // สีพื้นหลัง AppBar
        actions: [
          //ปุ่ม Logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // ออกจากระบบ Firebase
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                    context, '/login'); // กลับไปหน้า Login
                showtoast(
                    message:
                        "Successfully Signed Out"); // แจ้งเตือนว่าล็อกเอาท์สำเร็จ
              }
            },
          ),
        ],
      ),

      // เนื้อหาหลักของหน้าจอ App
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่กลางแนวตั้ง
          children: [
            const Icon(Icons.fitness_center,
                size: 100, color: Colors.blueAccent), // ไอคอนดัมเบล fitness_center
            const SizedBox(height: 20),
            const Text(
              'Welcome to FitSpark!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            // แสดงอีเมลของผู้ใช้ หรือ Guest ถ้าไม่มี
            Text(
              user != null ? 'Hello, ${user.email}' : 'Hello, Guest',
              style: const TextStyle(fontSize: 20, color: Colors.orangeAccent),
            ),
            const SizedBox(height: 20),

            // ปุ่มกดเพื่อไปยังหน้าแรกของระบบ (FHone)
            ElevatedButton.icon(
              onPressed: () {
                if (user != null) {
                  // ถ้ามีการล็อกอิน → ไปหน้า FHone พร้อมส่ง userId ไป
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FHone(userId: user.uid), // ส่ง userId ไป
                    ),
                  );
                } else {
                  // ถ้าไม่มีการล็อกอิน → แจ้งเตือน → ส่งกลับหน้า Login
                  showtoast(message: "Please login first.");
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              icon: const Icon(Icons.directions_run, color: Colors.white),
              label: const Text('Go to Main Page'), // ข้อความปุ่ม
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent, // สีปุ่ม
                foregroundColor: Colors.white, // สีข้อความ
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12), // ขนาด padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // มุมโค้ง
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
