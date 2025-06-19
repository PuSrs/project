import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/common_widget/toast.dart';
import 'package:myproject/login/loginja.dart';
import 'package:myproject/widget/firebase_auth_sevices.dart';
import 'package:myproject/widget/form_container_widget.dart';

class Signupja extends StatefulWidget {
  const Signupja({super.key});

  @override
  State<Signupja> createState() => _SignupjaState();
}

class _SignupjaState extends State<Signupja> {
  bool isSigningUp =
      false; // ตัวแปรสถานะบอกว่าอยู่ในระหว่างสมัครสมาชิกหรือไม่ (เพื่อต้องแสดง loading)
  final FirebaseAuthSevices _auth =
      FirebaseAuthSevices(); // สร้างอินสแตนซ์ (ตัวอย่าง) ช่วยการทำงานเกี่ยวกับ Firebase Auth

  // ตัวควบคุมสำหรับรับค่าจาก TextField (ชื่อผู้ใช้, อีเมล, รหัสผ่าน)
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // ปล่อยหน่วยความจำของ controller เมื่อ widget ถูกทำลาย (เพื่อป้องกัน memory leak)
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",
            style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อหน้าจอ
        backgroundColor: Colors.orangeAccent, // สีแถบแอพด้านบน
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // ใส่สีไล่เฉดสีฟ้า-ส้ม เป็นพื้นหลัง
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add, // ไอคอนสมัครสมาชิก
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  "Create Account", // หัวข้อหน้าจอ
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),

                // ช่องกรอกข้อมูล Username
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Username",
                  isPasswordField: false,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),

                // ช่องกรอกข้อมูล Email
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),

                // ช่องกรอกข้อมูล Password (ซ่อนข้อความ)
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                  textColor: Colors.white,
                ),
                SizedBox(height: 30),

                // ปุ่ม Sign Up
                GestureDetector(
                  onTap: () {
                    _signUp(); // เมื่อกดจะเรียกฟังก์ชันสมัครสมาชิก
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Center(
                      // ถ้า isSigningUp == true จะแสดง Loading indicator
                      // ถ้าไม่ใช่แสดงข้อความ "Sign Up"
                      child: isSigningUp
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // ข้อความลิงก์ไปหน้าล็อกอิน
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // ไปหน้าล็อกอินเมื่อกดข้อความ "Login"
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Loginja()),
                        );
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสมัครสมาชิก
  void _signUp() async {
    setState(() {
      isSigningUp = true; // แสดง loading indicator
    });

    String username =
        _usernameController.text.trim(); // ดึงข้อความจากช่อง username
    String email = _emailController.text.trim(); // ดึงข้อความจากช่อง email
    String password =
        _passwordController.text.trim(); // ดึงข้อความจากช่อง password

    // เช็คว่า กรอกข้อมูลครบหรือไม่ ถ้าว่างช่องใดช่องหนึ่ง แจ้งเตือนแล้วออกจากฟังก์ชัน
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      setState(() {
        isSigningUp = false; // ซ่อน loading indicator
      });
      return;
    }

    // เช็คว่าอีเมลที่กรอกลงท้ายด้วย '@gmail.com' เท่านั้น ถ้าไม่ใช่ แจ้งเตือนแล้วออกจากฟังก์ชัน
    if (!email.endsWith('@gmail.com')) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ต้องใช้บัญชี Gmail (@gmail.com) เท่านั้น'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      setState(() {
        isSigningUp = false; // ซ่อน loading indicator
      });
      return;
    }

    // เรียกฟังก์ชัน signupWithEmailAndPassword ของ _auth เพื่อสร้างบัญชีผู้ใช้ใน Firebase Auth
    User? user = await _auth.signupWithEmailAndPassword(email, password);

    if (user != null) {
      try {
        // อัปเดตชื่อ displayName ของ FirebaseAuth User ให้ตรงกับ username ที่กรอก
        await user.updateDisplayName(username);
        await user.reload(); // รีเฟรชข้อมูล user
        user = FirebaseAuth.instance.currentUser;

        // บันทึกข้อมูลผู้ใช้ลงใน Firestore collection 'users'
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'name': username, // ชื่อผู้ใช้
          'email': email, // อีเมล
          'uid': user.uid, // รหัสผู้ใช้
          'profileImageUrl': '', // กำหนดค่าเริ่มต้น รูปโปรไฟล์ยังไม่มี
        });

        if (mounted) {
          showtoast(message: "สมัครสมาชิกสำเร็จ"); // แสดงข้อความสมัครสำเร็จ
          Navigator.pushNamed(context, "/welcomePage"); // ไปหน้าหลังสมัครสำเร็จ
        }
      } catch (e) {
        print("Error saving user data: $e"); // แสดง error ใน console
        if (mounted) {
          showtoast(
              message:
                  "เกิดข้อผิดพลาดในการบันทึกข้อมูลผู้ใช้"); // แจ้ง error ให้ผู้ใช้ทราบ
        }
      }
    } else {
      if (mounted) {
        showtoast(
            message: "อีเมลนี้มีผู้ใช้แล้ว"); // สมัครไม่สำเร็จ
      }
    }

    setState(() {
      isSigningUp = false; // ซ่อน loading indicator เมื่อทำงานเสร็จ
    });
  }
}
