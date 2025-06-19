import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.child!),
        (route) => false, // ลบ route อื่นทั้งหมด
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent, // สีฟ้าเข้ม
              Colors.orangeAccent, // สีส้ม
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ใช้ไอคอนหรือโลโก้ที่เกี่ยวกับการออกกำลังกาย
              Icon(
                Icons.fitness_center, // ไอคอนการออกกำลังกาย
                size: 100.0,
                color: Colors.white, // สีขาว
              ),
              SizedBox(height: 20),
              // ข้อความต้อนรับ
              Text(
                "Welcome to FitSpark", // ข้อความต้อนรับ
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              // ข้อความคำบรรยายสั้นๆ เกี่ยวกับแอป
              Text(
                "Your journey to a healthy lifestyle starts here",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 30),
              // ปุ่มที่สามารถใช้การเชื่อมต่อไปยังหน้าต่อไปได้
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
