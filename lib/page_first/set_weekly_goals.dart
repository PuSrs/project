import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/hg_kg_bmi/hg_kg_bmi.dart';
import 'package:intl/intl.dart';

class SetWeeklyGoals extends StatefulWidget {
  final String userId;
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;
  final int pushUpCount;
  final int activityLevel;

  const SetWeeklyGoals({
    super.key,
    required this.userId,
    required this.gender,
    required this.goal,
    required this.focusAreas,
    required this.inspiration,
    required this.pushUpCount,
    required this.activityLevel,
  });

  @override
  State<SetWeeklyGoals> createState() => _SetWeeklyGoalsState();
}

class _SetWeeklyGoalsState extends State<SetWeeklyGoals> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int selectedTargetDays = 3;
  int selectedDay = DateTime.now().weekday % 7;

  final List<String> _weekDays = [
    "อาทิตย์",
    "จันทร์",
    "อังคาร",
    "พุธ",
    "พฤหัสบดี",
    "ศุกร์",
    "เสาร์"
  ];

  String _getWeekId() {
    DateTime now = DateTime.now();
    int weekNumber = int.parse(DateFormat("w").format(now));
    return "${now.year}-W$weekNumber";
  }

  Future<void> _saveWeeklyGoal() async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      debugPrint("❌ Error: userId is null");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("กรุณาเข้าสู่ระบบก่อน")),
      );
      return;
    }
    debugPrint("✅ userId: $userId");
    debugPrint("🔹 Saving Data: ${widget.toString()}");

    try {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userDoc.set({
        'gender': widget.gender,
        'goal': widget.goal,
        'focusAreas': widget.focusAreas,
        'inspiration': widget.inspiration,
        'pushUpCount': widget.pushUpCount,
        'activityLevel': widget.activityLevel,
        'targetDays': selectedTargetDays,
        'startDay': selectedDay,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("บันทึกเป้าหมายเรียบร้อย!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HgKgBmi(
            gender: widget.gender,
            goal: widget.goal,
            focusAreas: widget.focusAreas,
            inspiration: widget.inspiration,
            pushUpCount: widget.pushUpCount,
            activityLevel: widget.activityLevel,
            targetDays: selectedTargetDays,
            startDay: selectedDay,
          ),
        ),
      );
    } catch (e, stacktrace) {
      debugPrint("🔥 Error saving data: $e");
      debugPrint("🛑 Stacktrace: $stacktrace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาด: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade400,
        title: Text("ตั้งเป้าหมายรายสัปดาห์",
            style:
                GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("ตั้งเป้าหมายรายสัปดาห์",
                style: GoogleFonts.kanit(
                    fontSize: 22, fontWeight: FontWeight.w700)),
            SizedBox(height: 10),
            Text(
                "ขอแนะนำให้เทรนอย่างน้อย 3 วันต่อสัปดาห์ เพื่อผลลัพธ์ที่ดีที่สุด",
                style: GoogleFonts.kanit(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 20),
            Text("🎯 จำนวนวันการเทรนต่อสัปดาห์",
                style: GoogleFonts.kanit(fontSize: 18)),
            Wrap(
              spacing: 10,
              children: List.generate(
                  7,
                  (index) => ChoiceChip(
                        label: Text("${index + 1}"),
                        selected: selectedTargetDays == (index + 1),
                        onSelected: (bool selected) =>
                            setState(() => selectedTargetDays = index + 1),
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                            color: selectedTargetDays == (index + 1)
                                ? Colors.white
                                : Colors.black),
                      )),
            ),
            SizedBox(height: 20),
            Text("🗓 วันแรกของสัปดาห์", style: GoogleFonts.kanit(fontSize: 18)),
            DropdownButton<int>(
              value: selectedDay,
              onChanged: (int? newValue) =>
                  setState(() => selectedDay = newValue ?? selectedDay),
              items: List.generate(
                  _weekDays.length,
                  (index) => DropdownMenuItem<int>(
                        value: index,
                        child:
                            Text(_weekDays[index], style: GoogleFonts.kanit()),
                      )),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveWeeklyGoal,
                child: Text("ถัดไป", style: GoogleFonts.kanit(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
