import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/page_first/loading_screen.dart';

class WeightGoalPage extends StatefulWidget {
  // รับค่าพารามิเตอร์จากหน้าก่อนหน้าเพื่อใช้ในหน้านี้
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

  const WeightGoalPage({
    super.key,
    required this.gender,
    required this.goal,
    required this.focusAreas,
    required this.inspiration,
    required this.pushUpCount,
    required this.activityLevel,
    required this.targetDays,
    required this.startDay,
    required this.weights,
    required this.heights,
  });

  @override
  _WeightGoalPageState createState() => _WeightGoalPageState();
}

class _WeightGoalPageState extends State<WeightGoalPage> {
  int? currentWeight;
  int targetWeight = 50;

  @override
  void initState() {
    super.initState();
    currentWeight = widget.weights; // กำหนดน้ำหนักปัจจุบันจากค่าที่รับมา
    targetWeight = widget.weights -
        5; // ตั้งค่าเป้าหมายลดน้ำหนักให้เริ่มต้นที่ 5 กก. น้อยกว่าปัจจุบัน
  }

  // คำนวณค่า BMI (Body Mass Index)
  double calculateBMI() {
    if (widget.heights > 0) {
      return widget.weights / ((widget.heights / 100) * (widget.heights / 100));
    } else {
      return 0.0;
    }
  }

  // บันทึกเป้าหมายลง Firestore
  Future<void> saveWeightGoal() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // ดึงข้อมูลผู้ใช้ปัจจุบัน
      if (user == null) {
        print("❌ ไม่พบข้อมูลผู้ใช้");
        return;
      }

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.update({
        'targetWeight': targetWeight, // น้ำหนักเป้าหมาย
        'weightToLose': currentWeight! - targetWeight, // คำนวณน้ำหนักที่ต้องลด
        'goalStatus': 'กำลังดำเนินการ', // สถานะเป้าหมาย
        'updatedAt': FieldValue.serverTimestamp(), // เวลาที่อัปเดตล่าสุด
        'bmi': calculateBMI(), // บันทึกค่า BMI ลง Firestore
      });

      print("✅ เป้าหมายลดน้ำหนักถูกบันทึกแล้ว!");
    } catch (e) {
      print("❌ เกิดข้อผิดพลาด: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    int weightToLose =
        (currentWeight ?? 0) - targetWeight; // คำนวณน้ำหนักที่ต้องลด

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
                    "กำหนดเป้าหมายของคุณ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "น้ำหนักปัจจุบัน: ${currentWeight ?? '...'} kg",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text("น้ำหนักเป้าหมายของคุณ:",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: targetWeight - 30),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          targetWeight = index + 30;
                        });
                      },
                      children: List.generate(71, (index) {
                        return Center(
                          child: Text("${index + 30} kg",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.blueAccent)),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    weightToLose > 0
                        ? "คุณต้องลดน้ำหนัก $weightToLose kg"
                        : "เป้าหมายต้องน้อยกว่าน้ำหนักปัจจุบัน",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: weightToLose > 0 ? Colors.green : Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("BMI ของคุณ: ${calculateBMI().toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: weightToLose > 0
                    ? () async {
                        await saveWeightGoal();

                        // ส่งข้อมูลไปยังหน้า LoadingScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingScreen(
                              gender: widget.gender,
                              goal: widget.goal,
                              focusAreas: widget.focusAreas,
                              inspiration: widget.inspiration,
                              pushUpCount: widget.pushUpCount,
                              activityLevel: widget.activityLevel,
                              targetDays: widget.targetDays,
                              startDay: widget.startDay,
                              weights: widget.weights,
                              heights: widget.heights,
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("บันทึกเป้าหมาย",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void navigateToWeightGoalPage(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("❌ ไม่พบ User ID");
    return;
  }

  DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  if (!userDoc.exists) {
    print("❌ ไม่พบข้อมูลผู้ใช้ใน Firestore");
    return;
  }

  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoadingScreen(
        gender: userData['gender'] ?? 'ไม่ระบุ',
        goal: userData['goal'] ?? 'ไม่ระบุ',
        focusAreas: userData['focusAreas'] ?? 'ไม่ระบุ',
        inspiration: userData['inspiration'] ?? 'ไม่มีแรงบันดาลใจ',
        pushUpCount: userData['pushUpCount'] ?? 0,
        activityLevel: userData['activityLevel'] ?? 1,
        targetDays: userData['targetDays'] ?? 7,
        startDay: userData['startDay'] ?? 1,
        weights: userData['weight'] ?? 70,
        heights: (userData['height'] ?? 170).toDouble(),
      ),
    ),
  );
}
