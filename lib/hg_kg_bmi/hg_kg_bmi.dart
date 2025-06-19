import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/page_first/weight_goal_page.dart';

class HgKgBmi extends StatefulWidget {
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;
  final int pushUpCount;
  final int activityLevel;
  final int targetDays;
  final int startDay;

  const HgKgBmi({
    super.key,
    required this.gender,
    required this.goal,
    required this.focusAreas,
    required this.inspiration,
    required this.pushUpCount,
    required this.activityLevel,
    required this.targetDays,
    required this.startDay,
  });

  @override
  _HgKgBmiState createState() => _HgKgBmiState();
}

class _HgKgBmiState extends State<HgKgBmi> {
  int selectedWeight = 50;
  double selectedHeight = 160;

  Future<void> savehgkgbmi() async {
    try {
      User? user =
          FirebaseAuth.instance.currentUser; // ดึงข้อมูลผู้ใช้ที่ล็อกอินอยู่
      if (user == null) {
        print("เกิดข้อผิดพลาด: ไม่พบข้อมูลผู้ใช้");
        return;
      }

      double bmi = calculateBMI();
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'gender': widget.gender,
        'goal': widget.goal,
        'focusAreas': widget.focusAreas,
        'inspiration': widget.inspiration,
        'pushUpCount': widget.pushUpCount,
        'activityLevel': widget.activityLevel,
        'targetDays': widget.targetDays,
        'startDay': widget.startDay,
        'weight': selectedWeight,
        'height': selectedHeight,
        'bmi': bmi,
        'bmiCategory': getBMICategory(bmi), // เพิ่มประเภทของ BMI
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("บันทึกข้อมูลสำเร็จ");
    } catch (e) {
      print("เกิดข้อผิดพลาดในการบันทึกข้อมูล: $e");
    }
  }

  double calculateBMI() {
    double heightInMeters = selectedHeight / 100;
    return selectedWeight / (heightInMeters * heightInMeters);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "ผอมเกินไป";
    } else if (bmi < 24.9) {
      return "น้ำหนักปกติ";
    } else if (bmi < 29.9) {
      return "เริ่มอ้วน";
    } else {
      return "อ้วนมาก";
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "น้ำหนักของคุณคือ ?",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "$selectedWeight kg",
                        style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedWeight - 30),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedWeight = index + 30;
                        });
                      },
                      children: List.generate(71, (index) {
                        return Center(
                          child: Text(
                            "${index + 30}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.blueAccent),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "ส่วนสูงของคุณคือ ?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    min: 100,
                    max: 220,
                    divisions: 120,
                    label: "$selectedHeight cm",
                    value: selectedHeight,
                    onChanged: (value) {
                      setState(() {
                        selectedHeight = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "BMI: ${bmi.toStringAsFixed(1)} (${getBMICategory(bmi)})",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Colors.blueAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      await savehgkgbmi();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeightGoalPage(
                            gender: widget.gender,
                            goal: widget.goal,
                            focusAreas: widget.focusAreas,
                            inspiration: widget.inspiration,
                            pushUpCount: widget.pushUpCount,
                            activityLevel: widget.activityLevel,
                            targetDays: widget.targetDays,
                            startDay: widget.startDay,
                            weights: selectedWeight,
                            heights: selectedHeight,
                          ),
                        ),
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
