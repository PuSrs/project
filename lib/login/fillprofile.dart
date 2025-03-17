import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FillProfilePage extends StatefulWidget {
  @override
  _FillProfilePageState createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // ฟังก์ชันเลือกภาพโปรไฟล์จากแกลเลอรี่หรือกล้อง
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // ฟังก์ชันอัพโหลดภาพไปยัง Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      // อัพโหลดภาพไปยัง Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // ฟังก์ชันตรวจสอบและบันทึกข้อมูล
  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      String weight = _weightController.text;
      String height = _heightController.text;
      String age = _ageController.text;

      try {
        // ดึงข้อมูลผู้ใช้จาก Firebase Authentication
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String? profileImageUrl;
          
          // ถ้ามีการเลือกภาพ โปรดอัพโหลดภาพไปยัง Firebase Storage
          if (_profileImage != null) {
            profileImageUrl = await _uploadImage(_profileImage!);
          }

          // เขียนข้อมูลลง Firestore
          await FirebaseFirestore.instance.collection('profiles').doc(user.uid).set({
            'weight': weight,
            'height': height,
            'age': age,
            'profileImageUrl': profileImageUrl ?? '',
            'createdAt': Timestamp.now(),
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Saved!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not logged in')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields correctly.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Your Profile'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // รูปโปรไฟล์
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(height: 20),

              // น้ำหนัก
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.fitness_center),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // ส่วนสูง
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // อายุ
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),

              // ปุ่มบันทึกข้อมูล
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.orangeAccent, // ปุ่มสีส้ม
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Save Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
