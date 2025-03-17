import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/page_first/push_ups_screen.dart';

class InspirationScreen extends StatefulWidget {
  final String gender;
  final String goal;
  final String focusAreas;

  const InspirationScreen({
    Key? key,
    required this.gender,
    required this.goal,
    required this.focusAreas,
  }) : super(key: key);

  @override
  _InspirationScreenState createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> {
  int? selectedIndex; // ตัวแปรเก็บ index ของตัวเลือกที่ถูกเลือก
  String? selectedInspiration;

  // รายการตัวเลือกแรงบันดาลใจ
  final List<Map<String, String>> options = [
    {"emoji": "😃", "text": "ออกกำลังกายเพื่อเรียกความมั่นใจ"},
    {"emoji": "🎈", "text": "ออกกำลังกายคลายเครียด"},
    {"emoji": "💪", "text": "ดูแลสุขภาพตัวเอง"},
  ];

  // ฟังก์ชันบันทึกข้อมูลลง Firestore
  Future<void> _onNextPressed() async {
    if (selectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("โปรดเลือกแรงบันดาลใจก่อนดำเนินการต่อ"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      String selectedText = options[selectedIndex!]["text"]!;
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception("ไม่พบผู้ใช้ที่ล็อกอิน");
      }

      // บันทึกข้อมูลลง Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'gender': widget.gender,
        'goal': widget.goal,
        'focusAreas': widget.focusAreas,
        'inspiration': selectedText,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PushUpsScreen(
                    gender: widget.gender,
                    goal: widget.goal,
                    focusAreas: widget.focusAreas,
                    inspiration: selectedText,
                  )),
        );
      }
    } catch (e) {
      print("Error saving data to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("เกิดข้อผิดพลาดในการบันทึกข้อมูล"),
          backgroundColor: Colors.red,
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
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "แรงบันดาลใจ",
          style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "อะไรคือแรงบันดาลใจของคุณ?",
                style: GoogleFonts.kanit(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Column(
                children: List.generate(options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Colors.orangeAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: selectedIndex == index
                              ? [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.4),
                                    blurRadius: 5,
                                  )
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(options[index]["emoji"]!,
                                style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 10),
                            Text(
                              options[index]["text"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: _onNextPressed,
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: selectedIndex != null ? Colors.orange : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("ถัดไป",
                        style: GoogleFonts.kanit(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
