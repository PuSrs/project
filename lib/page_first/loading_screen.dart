import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:myproject/home/PageScreen/fitness_plan_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;
  final int pushUpCount;
  final int activityLevel;
  final int targetDays;
  final int startDay;
  final int weights;
  final double heights;

  const LoadingScreen(
      {super.key,
      required this.gender,
      required this.goal,
      required this.focusAreas,
      required this.inspiration,
      required this.pushUpCount,
      required this.activityLevel,
      required this.targetDays,
      required this.startDay,
      required this.weights,
      required this.heights});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;
  late Timer _timer;
  final double _progressThreshold = 0.9; // กำหนดให้ Timer หยุดที่ 90%
  final int _timerIntervalMs = 10; // อัปเดตทุกๆ 10 มิลลิวินาที (เพื่อความสมูทสูงสุด)
  final double _progressIncrement = 0.003; // เพิ่มขึ้น 0.3% ในแต่ละช่วงเวลา

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    // เริ่ม Timer แบบวนซ้ำเพื่อสร้างแอนิเมชันของ Progress Bar
    _timer = Timer.periodic(Duration(milliseconds: _timerIntervalMs), (timer) {
      setState(() {
        // เพิ่มค่า progress ทีละน้อยจนกว่าจะถึงเกณฑ์ที่กำหนด
        if (progress < _progressThreshold) {
          progress += _progressIncrement;
          // ตรวจสอบให้แน่ใจว่า progress ไม่เกินเกณฑ์ (กรณีเพิ่มเกิน)
          if (progress > _progressThreshold) {
            progress = _progressThreshold;
          }
        } else {
          // หาก progress ถึงหรือเกินเกณฑ์ ให้ยกเลิก Timer
          _timer.cancel();
          // จากนั้น ดึงข้อมูลผู้ใช้ (จำลองการทำงานจริง)
          _fetchUserData();
        }
      });
    });
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("❌ ไม่พบข้อมูลผู้ใช้");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่พบข้อมูลผู้ใช้ กรุณาลองใหม่อีกครั้ง')),
        );
        Navigator.pop(context); // กลับไปหน้าก่อนหน้าหากไม่พบผู้ใช้
      }
      return;
    }

    // จำลองเวลาในการประมวลผล/ดึงข้อมูลจริง (ยังคง 1 วินาทีเท่าเดิม)
    await Future.delayed(const Duration(seconds: 1)); 

    // เมื่อการทำงานจำลองเสร็จสิ้น ให้อัปเดต progress เป็น 100%
    if (mounted) {
      setState(() {
        progress = 1.0; // ตรวจสอบให้แน่ใจว่า progress ถึง 100% พอดี
      });
    }

    // หน่วงเวลาเล็กน้อยเพื่อให้แอนิเมชัน 100% แสดงผลก่อนนำทาง
    await Future.delayed(const Duration(milliseconds: 300));

    // ดึงข้อมูลที่ส่งมาจากหน้า WeightGoalPage
    Map<String, dynamic> userData = {
      'gender': widget.gender,
      'goal': widget.goal,
      'focusAreas': widget.focusAreas,
      'inspiration': widget.inspiration,
      'pushUpCount': widget.pushUpCount,
      'activityLevel': widget.activityLevel,
      'targetDays': widget.targetDays,
      'startDay': widget.startDay,
      'weights': widget.weights,
      'heights': widget.heights,
    };

    print("✅ ดึงข้อมูลสำเร็จ: $userData");

    // ไปยังหน้าถัดไปพร้อมข้อมูลที่โหลดแล้ว
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FitnessPlanScreen(userData: userData),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // ยกเลิก Timer เมื่อ widget ถูกทำลาย
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "สร้างแผนของคุณ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              child: LiquidCircularProgressIndicator(
                value: progress, // เปอร์เซ็นต์โหลด
                backgroundColor: Colors.grey.shade200, // สีพื้นหลัง
                valueColor: AlwaysStoppedAnimation(Colors.redAccent), // สีแดงของน้ำที่ไหล
                borderColor: Colors.redAccent, // สีขอบเป็นสีแดง
                borderWidth: 2.0, // ความหนาของขอบ
                direction: Axis.vertical, // ทิศทางการไหลของคลื่น
                center: Text(
                  "${(progress * 100).toInt()} %",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "กำลังโหลดข้อมูลส่วนบุคคลของคุณ...",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}