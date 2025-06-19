import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/page_first/inspiration.dart';

class FocusAreaSelectionScreen extends StatefulWidget {
  final String userId;
  final String gender;
  final String goal;

  const FocusAreaSelectionScreen({
    super.key,
    required this.gender,
    required this.goal, required this.userId,
  });

  @override
  State<FocusAreaSelectionScreen> createState() =>
      _FocusAreaSelectionScreenState();
}

class _FocusAreaSelectionScreenState extends State<FocusAreaSelectionScreen> {
  String? selectedAreas;

  final List<String> focusAreas = [
    "ร่างกายทั้งหมด",
    "หน้าอก",
    "แขน",
    "หน้าท้อง",
    "ขา",
  ];

  // ฟังก์ชันบันทึกข้อมูลลง Firestore
  Future<void> saveFocusAreaToFirestore() async {
    try {
      User? users = FirebaseAuth.instance.currentUser;
      if (users != null && selectedAreas != null) {
        await FirebaseFirestore.instance.collection('users').doc(users.uid).set(
          {
            'gender': widget.gender,
            'goal': widget.goal,
            'focusAreas': selectedAreas,
            'timestamp': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true), // รวมข้อมูลเข้ากับข้อมูลเดิม
        );
      } else {
        throw Exception("ผู้ใช้ไม่สามารถบันทึกข้อมูลได้");
      }
    } catch (e) {
      print("Error saving focus area to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูล'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("เลือกพื้นที่ที่คุณต้องการโฟกัส"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "เลือกจุดที่คุณจะโฟกัส",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "รับแผนออกกำลังกายที่เหมาะสำหรับบริเวณที่คุณต้องการโฟกัสมากที่สุด",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // แสดงตัวเลือกโฟกัสกล้ามเนื้อ
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/body_focus.png",
                    height: MediaQuery.of(context).size.width * 0.7,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: focusAreas.map((area) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedAreas = area;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAreas == area
                                ? Colors.orangeAccent
                                : Colors.white,
                            minimumSize: const Size(180, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            shadowColor: selectedAreas == area
                                ? Colors.orange.withOpacity(0.5)
                                : Colors.transparent,
                            elevation: selectedAreas == area ? 5 : 0,
                          ),
                          child: Text(
                            area,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedAreas == area
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const Spacer(),

              // ปุ่ม "ถัดไป"
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedAreas == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณาเลือกพื้นที่ที่ต้องการโฟกัส'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      await saveFocusAreaToFirestore(); // บันทึกข้อมูลก่อนเปลี่ยนหน้า
                      if (mounted) {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InspirationScreen(
                                      userId: widget.userId,
                                      gender: widget.gender,
                                      goal: widget.goal,
                                      focusAreas: selectedAreas!,
                                    )),
                          );
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(200, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'ถัดไป',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
