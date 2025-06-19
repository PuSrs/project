import 'package:cloud_firestore/cloud_firestore.dart'; // เชื่อมต่อกับ Firestore
import 'package:firebase_auth/firebase_auth.dart'; // ใช้งาน Firebase Authentication
import 'package:firebase_storage/firebase_storage.dart'; // ใช้อัพโหลดไฟล์ไป Firebase Storage
import 'package:image_picker/image_picker.dart'; // ใช้เลือกภาพจากเครื่องผู้ใช้
import 'package:flutter/material.dart'; // UI Flutter
import 'dart:io'; // จัดการไฟล์ (ภาพ)

// หน้า FillProfilePage แสดงและแก้ไขข้อมูลโปรไฟล์ผู้ใช้
class FillProfilePage extends StatefulWidget {
  final String? username; // รับค่าชื่อผู้ใช้จากหน้า Loginja

  FillProfilePage({this.username}); // รับค่าชื่อผู้ใช้ผ่าน constructor

  @override
  _FillProfilePageState createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  File? _profileImage;
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  String? _username; // ตัวแปรเก็บชื่อผู้ใช้ในหน้าโปรไฟล์
  String? _email;

  @override
  void initState() {
    super.initState();

    // ถ้ามี username ส่งมาจากหน้า Loginja ให้ใช้ค่าที่ส่งมาเลย
    if (widget.username != null && widget.username!.isNotEmpty) {
      _username = widget.username;
      _fetchUserProfileDataOnly(); // โหลดข้อมูลโปรไฟล์ส่วนอื่นๆ (ไม่โหลดชื่อซ้ำ)
    } else {
      // ถ้าไม่มี username ส่งมา โหลดข้อมูลทั้งหมดจาก FirebaseAuth และ Firestore
      _fetchUserProfile();
    }
  }

  // โหลดข้อมูลน้ำหนัก ความสูง อายุ และรูปภาพ (ไม่โหลด username)
  Future<void> _fetchUserProfileDataOnly() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email ?? "No Email";
      });

      try {
        DocumentSnapshot profileData = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(user.uid)
            .get();

        if (profileData.exists) {
          setState(() {
            _weightController.text = profileData.get('weight') ?? '';
            _heightController.text = profileData.get('height') ?? '';
            _ageController.text = profileData.get('age') ?? '';
            _profileImageUrl = profileData.get('profileImageUrl') ?? '';
          });
        }
      } catch (e) {
        print("Error fetching profile data: $e");
      }
    }
  }

  // โหลดข้อมูลทั้งหมดจาก FirebaseAuth และ Firestore (กรณีไม่มี username)
  Future<void> _fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email ?? "No Email";
      });

      try {
        // โหลดชื่อผู้ใช้จาก collection 'users' ใน Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          setState(() {
            _username = userData.get('name') ?? user.displayName ?? "No Name";
          });
        } else {
          setState(() {
            _username = user.displayName ?? "No Name";
          });
        }

        // โหลดข้อมูลโปรไฟล์น้ำหนัก ความสูง อายุ และรูปภาพ
        DocumentSnapshot profileData = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(user.uid)
            .get();

        if (profileData.exists) {
          setState(() {
            _weightController.text = profileData.get('weight') ?? '';
            _heightController.text = profileData.get('height') ?? '';
            _ageController.text = profileData.get('age') ?? '';
            _profileImageUrl = profileData.get('profileImageUrl') ?? '';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          _username = user.displayName ?? "No Name";
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName =
          '${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch}';
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? imageUrl = _profileImageUrl;

        if (_profileImage != null) {
          String? uploadedUrl = await _uploadImage(_profileImage!);
          if (uploadedUrl != null) {
            imageUrl = uploadedUrl;
          }
        }

        try {
          await FirebaseFirestore.instance
              .collection('profiles')
              .doc(user.uid)
              .set({
            'weight': _weightController.text.trim(),
            'height': _heightController.text.trim(),
            'age': _ageController.text.trim(),
            'profileImageUrl': imageUrl ?? '',
            'updatedAt': Timestamp.now(),
          }, SetOptions(merge: true));

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile updated successfully!")));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error saving: $e")));
        }
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : (_profileImageUrl != null &&
                              _profileImageUrl!.isNotEmpty
                          ? NetworkImage(_profileImageUrl!)
                          : null) as ImageProvider<Object>?,
                  child: (_profileImage == null &&
                          (_profileImageUrl == null ||
                              _profileImageUrl!.isEmpty))
                      ? const Icon(Icons.camera_alt,
                          size: 50, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              if (_username != null)
                Text("Username: $_username",
                    style: const TextStyle(fontSize: 16)),
              if (_email != null)
                Text("Email: $_email", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.fitness_center),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your weight'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your height'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your age'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Save Profile",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
