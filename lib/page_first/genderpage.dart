import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/page_first/goalselection_screen.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender; // ตัวแปรเก็บค่าเพศที่ผู้ใช้เลือก

  // ฟังก์ชันบันทึกค่าที่เลือกไปที่ Firestore
  Future<void> _saveGenderToFirestore() async {
    if (selectedGender == null) return;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print(
            "บันทึกเพศ: $selectedGender ของผู้ใช้ ${user.uid}"); // ✅ Debugging

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'gender': selectedGender,
            'timestamp': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('บันทึกเพศสำเร็จ ✅')),
          );
        }
      } else {
        throw Exception("ไม่พบผู้ใช้ที่ล็อกอิน ❌");
      }
    } catch (e) {
      print('Error saving gender: $e'); // ✅ Debugging
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูล ❌')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  'โปรดเลือกเพศของคุณ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'เพื่อมอบประสบการณ์และผลลัพธ์ที่ดีขึ้นให้กับคุณ เราจำเป็นต้องทราบเพศของคุณ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // ตัวเลือกเพศ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGenderOption('Male', Icons.male, Colors.blue),
                    const SizedBox(width: 30),
                    _buildGenderOption('Female', Icons.female, Colors.pink),
                  ],
                ),
                const Spacer(),

                // ปุ่มถัดไป
                ElevatedButton(
                  onPressed: () async {
                    if (selectedGender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณาเลือกเพศของคุณ.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    await _saveGenderToFirestore(); // บันทึกข้อมูลก่อนเปลี่ยนหน้า

                    if (mounted) {
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GoalSelectionScreen(gender: selectedGender!),
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 56),
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
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้าง Widget ตัวเลือกเพศ
  Widget _buildGenderOption(String gender, IconData icon, Color color) {
    bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white12,
          shape: BoxShape.circle,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 5,
              ),
          ],
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white54,
            size: 50,
          ),
        ),
      ),
    );
  }
}
