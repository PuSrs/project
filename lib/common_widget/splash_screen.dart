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
      // ลบการเรียกใช้ฟังก์ชันผิดจาก widget.child
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.child!), // ไม่ต้องใช้ '()' ที่นี่
        (route) => false, // ลบ route อื่นทั้งหมด
      );
    });
  }

  @override
  Widget build(BuildContext context) { //ตกแต่ง
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to Flutter App",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
