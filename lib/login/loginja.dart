import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/common_widget/toast.dart';
import 'package:myproject/home/PageScreen/fitness_plan_screen_page.dart';
import 'package:myproject/login/signupja.dart';
import 'package:myproject/widget/firebase_auth_sevices.dart';
import 'package:myproject/widget/form_container_widget.dart';

class Loginja extends StatefulWidget {
  const Loginja({super.key});

  @override
  State<Loginja> createState() => _LoginjaState();
}

class _LoginjaState extends State<Loginja> {
  bool _isSigning = false; // สถานะโหลดขณะล็อกอิน

  final FirebaseAuthSevices _auth = FirebaseAuthSevices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
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
                Icon(Icons.fitness_center, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isPasswordField: false,
                    textColor: Colors.white),
                SizedBox(height: 10),
                FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                    textColor: Colors.white),
                SizedBox(height: 30),

                // ปุ่ม Login
                GestureDetector(
                  onTap: _signIn,
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
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: Center(
                      child: _isSigning
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupja()));
                      },
                      child: Text(" Register",
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold)),
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

  // ฟังก์ชันล็อกอินด้วยอีเมลและรหัสผ่าน
  void _signIn() async {
    setState(() {
      _isSigning = true; // แสดง loading indicator
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // เรียกใช้งานเมธอดล็อกอินของ FirebaseAuthSevices
    User? user = await _auth.signinWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false; // ซ่อน loading indicator
    });

    if (user != null) {
      showtoast(message: "User is successfully signed in");

      // ดึงชื่อผู้ใช้ (displayName) จาก user object
      String username = user.displayName ?? 'No Name';

      // สร้างตัวแปรเก็บข้อมูลที่ต้องการส่งไปหน้า FitnessPlanScreenPage
      var userData = {
        'uid': user.uid,
        'email': user.email,
        'username': username, // เพิ่มชื่อผู้ใช้เข้าไปในข้อมูล
      };

      // ส่งข้อมูล userData ไปหน้า FitnessPlanScreenPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FitnessPlanScreenPage(userData: userData),
        ),
      );
    } else {
      showtoast(message: "Some error occurred");
    }
  }
}
