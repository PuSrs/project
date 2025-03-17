import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/page_first/set_weekly_goals.dart';

class ActivityLevelScreen extends StatefulWidget {
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;
  final int pushUpCount;

  const ActivityLevelScreen(
      {super.key,
      required this.gender,
      required this.goal,
      required this.focusAreas,
      required this.inspiration,
      required this.pushUpCount});

  @override
  _ActivityLevelScreenState createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  int selectedAtvt = 1; // Default selection

  final List<Map<String, dynamic>> activityLevels = [
    {
      'title': 'อยู่ประจำ',
      'desc': 'ฉันนั่งที่โต๊ะทำงานทั้งวัน',
      'icon': Icons.laptop
    },
    {
      'title': 'ใช้งานน้อย',
      'desc': 'ฉันออกกำลังกายหรือเดินเป็นครั้งคราว',
      'icon': Icons.directions_walk
    },
    {
      'title': 'ใช้งานปานกลาง',
      'desc': 'ฉันออกกำลังกายทุกวัน',
      'icon': Icons.directions_run
    },
    {
      'title': 'ใช้งานมาก',
      'desc': 'ฉันรักการออกกำลังกาย',
      'icon': Icons.fitness_center
    },
  ];

  // ฟังก์ชันบันทึกข้อมูลลง Firestore
  Future<void> saveActivityLevelToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'gender': widget.gender,
            'goal': widget.goal,
            'focusAreas': widget.focusAreas,
            'inspiration': widget.inspiration,
            'activityLevel': selectedAtvt,
            'timestamp': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      } else {
        throw Exception("ผู้ใช้ไม่สามารถบันทึกข้อมูลได้");
      }
    } catch (e) {
      print("Error saving activity level to Firestore: $e");
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
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ระดับกิจกรรมของคุณ', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: activityLevels.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedAtvt == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAtvt = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange.shade100 : Colors.white,
                      border: Border.all(
                          color:
                              isSelected ? Colors.orange : Colors.grey.shade300,
                          width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(activityLevels[index]['icon'],
                            size: 40,
                            color: isSelected ? Colors.orange : Colors.grey),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activityLevels[index]['title'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(height: 5),
                              Text(activityLevels[index]['desc'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle,
                              color: Colors.orange, size: 28),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () async {
                await saveActivityLevelToFirestore();
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetWeeklyGoals(
                        gender: widget.gender,
                        goal: widget.goal,
                        focusAreas: widget.focusAreas,
                        inspiration: widget.inspiration, // เพิ่มค่า inspiration
                        pushUpCount: widget.pushUpCount, // เพิ่มค่า pushUpCount
                        activityLevel: selectedAtvt,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Center(
                child: Text('ขั้นตอนต่อไป',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
