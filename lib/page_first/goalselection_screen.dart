import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/page_first/focus_area_selection_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  final String gender;

  const GoalSelectionScreen({super.key, required this.gender});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String? selectedGoal;
  bool isLoading = false; //ตัวแปรโหลด

  final List<Map<String, String>> goals = [
    {"title": "ลดน้ำหนัก", "image": "assets/images/weight_loss.png"},
    {"title": "สร้างกล้ามเนื้อ", "image": "assets/images/muscle_gain.png"},
    {"title": "รักษาความฟิต", "image": "assets/images/maintain_fitness.png"},
  ];

  // ✅ บันทึกข้อมูลลง Firestore
  Future<void> saveGoalAndGenderToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser; // ดึงข้อมูลผู้ใช้ที่ล็อกอิน
    if (user != null && selectedGoal != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'gender': widget.gender, // บันทึกเพศของผู้ใช้
          'goal': selectedGoal, // บันทึกเป้าหมายที่เลือก
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)); // ใช้ merge:true เพื่อไม่ลบข้อมูลเก่า
      } catch (e) {
        print('Error saving data: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูล')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เลือกเป้าหมายออกกำลังกาย"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/genderPage");
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.orange.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "คุณต้องการออกกำลังกายเพื่ออะไร?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // ✅ แสดงตัวเลือกเป้าหมาย
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    var goal = goals[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGoal = goal["title"];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: selectedGoal == goal["title"]
                              ? Colors.orangeAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            if (selectedGoal == goal["title"])
                              const BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Image.asset(goal["image"]!,
                                  width: 70, height: 100),
                              const SizedBox(width: 20),
                              Text(
                                goal["title"]!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // ✅ ปุ่ม "ถัดไป"
              ElevatedButton(
                onPressed: isLoading
                    ? null // ปิดปุ่มหากกำลังโหลด
                    : () async {
                        if (selectedGoal == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('กรุณาเลือกเป้าหมายออกกำลังกาย'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        setState(() => isLoading = true); // เริ่มโหลด

                        await saveGoalAndGenderToFirestore();

                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FocusAreaSelectionScreen(
                                gender: widget.gender,
                                goal: selectedGoal!,
                              ),
                            ),
                          );
                        }

                        setState(() => isLoading = false); // หยุดโหลด
                      },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'ถัดไป',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
