import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/page_first/activity_level_screen.dart';

class PushUpsScreen extends StatefulWidget {
  final String userId;
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;

  const PushUpsScreen(
      {super.key,
      required this.gender,
      required this.goal,
      required this.focusAreas,
      required this.inspiration,
      required this.userId});

  @override
  State<PushUpsScreen> createState() => _PushUpsScreenState();
}

class _PushUpsScreenState extends State<PushUpsScreen> {
  int _pushUpCount = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _savePushUpCount() async {
    String userId = _auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'pushUpCount': _pushUpCount,
    }, SetOptions(merge: true)); // ใช้ merge เพื่อไม่ให้ข้อมูลอื่นหาย
  }

  void _loadPushUpCount() async {
    String userId = _auth.currentUser!.uid;
    var doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      setState(() {
        _pushUpCount = doc['pushUpCount'] ?? 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPushUpCount();
  }

  void _incrementPushUp() {
    setState(() {
      _pushUpCount++;
    });
    _savePushUpCount();
  }

  void _decrementPushUp() {
    setState(() {
      if (_pushUpCount > 0) {
        _pushUpCount--;
      }
    });
    _savePushUpCount();
  }

  void _resetPushUp() {
    setState(() {
      _pushUpCount = 0;
    });
    _savePushUpCount();
  }

  Future<void> _savePushUpCountAndNavigate() async {
    await _savePushUpCount();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityLevelScreen(
            userId: widget.userId,
            gender: widget.gender,
            goal: widget.goal,
            focusAreas: widget.focusAreas,
            inspiration: widget.inspiration,
            pushUpCount: _pushUpCount, // ส่งค่าจำนวนวิดพื้นไปด้วย
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "วิดพื้น",
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.orange.shade400],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "คุณสามารถวิดพื้นได้ติดต่อกันกี่ครั้ง?",
                style: GoogleFonts.kanit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // แสดงวงกลมโหลดระหว่างดึงข้อมูล
                  }

                  if (snapshot.hasError) {
                    return Text(
                      "เกิดข้อผิดพลาด",
                      style: GoogleFonts.kanit(fontSize: 20, color: Colors.red),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text(
                      '0', // ถ้าไม่มีข้อมูลให้แสดงค่าเริ่มต้นเป็น 0
                      style: GoogleFonts.kanit(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }

                  int pushUpCount = snapshot.data!['pushUpCount'] ?? 0;

                  return Text(
                    '$pushUpCount', // แสดงค่าจำนวนวิดพื้นที่ได้จาก Firestore
                    style: GoogleFonts.kanit(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementPushUp,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Icon(Icons.remove, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _incrementPushUp,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPushUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "รีเซ็ต",
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _savePushUpCountAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "ถัดไป",
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    color: Colors.white,
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
