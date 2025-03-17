import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:myproject/common_widget/toast.dart'; 

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key}); // Constructor ที่รับ key เพื่อใช้ระบุ widget ใน widget tree

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลผู้ใช้ที่ล็อกอินอยู่ในปัจจุบันจาก FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold( // Scaffold เป็นโครงสร้างหลักของหน้าจอ
      appBar: AppBar( // ส่วนบนของหน้าจอที่แสดงชื่อแอปและปุ่ม logout
        title: const Text( // ข้อความตรงกลางแถบ AppBar
          'Welcome Home Buddy',
          style: TextStyle(color: Colors.white), // สีข้อความเป็นสีขาว
        ),
        centerTitle: true, // จัดตำแหน่งข้อความตรงกลาง
        backgroundColor: Colors.blueAccent, // สีพื้นหลังของ AppBar เป็นสีฟ้า
        actions: [ // แสดงไอคอน logout ที่มุมขวา
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // ไอคอน logout สีขาว
            onPressed: () async { // เมื่อกดปุ่มนี้จะทำการ logout
              await FirebaseAuth.instance.signOut(); // ออกจากระบบ Firebase
              if (context.mounted) { // ตรวจสอบว่าหน้ายังอยู่ใน tree หรือไม่ก่อนทำการนำทาง
                Navigator.pushReplacementNamed(context, '/login'); // ย้ายไปหน้าล็อกอินและแทนที่หน้าเดิม
                showtoast(message: "Successfully Signed Out"); // แสดงข้อความ toast แจ้งเตือน
              }
            },
          ),
        ],
      ),
      
      body: Center( // เนื้อหาหลักของหน้าจอจะอยู่ตรงกลาง
        child: Column( // แสดง widget ในแนวตั้ง
          mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่งตรงกลางในแนวตั้ง
          children: [
            const Icon(Icons.fitness_center, size: 100, color: Colors.blueAccent), // ไอคอนดัมเบลสีฟ้า
            const SizedBox(height: 20), // เว้นระยะห่าง 20 พิกเซล
            const Text(
              'Welcome to FitSpark!', // ข้อความทักทาย
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent), // สไตล์ข้อความ
            ),
            const SizedBox(height: 10), // เว้นระยะห่าง 10 พิกเซล
            Text(
              user != null ? 'Hello, ${user.email}' : 'Hello, Guest', // แสดงอีเมลของผู้ใช้หรือคำว่า Guest
              style: const TextStyle(fontSize: 20, color: Colors.orangeAccent), // ข้อความสีส้ม
            ),
            const SizedBox(height: 20), // เว้นระยะห่าง 20 พิกเซล
            ElevatedButton.icon( // ปุ่มที่มีไอคอนและข้อความ
              onPressed: () => Navigator.pushNamed(context, '/pagefirst'), // เมื่อกดจะไปหน้าติดตามน้ำหนัก
              icon: const Icon(Icons.directions_run, color: Colors.white), // ไอคอนวิ่งสีขาว
              label: const Text('Track Your Weight'), // ข้อความในปุ่ม
              style: ElevatedButton.styleFrom( // ปรับสไตล์ปุ่ม
                backgroundColor: Colors.orangeAccent, // สีพื้นหลังสีส้ม
                foregroundColor: Colors.white, // สีข้อความสีขาว
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // ขนาด padding ของปุ่ม
                shape: RoundedRectangleBorder( // รูปทรงปุ่มเป็นมุมโค้ง
                  borderRadius: BorderRadius.circular(12), // มุมโค้ง 12 พิกเซล
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
