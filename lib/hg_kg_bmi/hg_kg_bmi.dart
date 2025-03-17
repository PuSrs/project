import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HgKgBmi extends StatefulWidget {
  final String gender;
  final String goal;
  final String focusAreas;
  final String inspiration;
  final int pushUpCount;
  final int activityLevel;
  final int targetDays;
  final int startDay;

  const HgKgBmi({
    super.key,
    required this.gender,
    required this.goal,
    required this.focusAreas,
    required this.inspiration,
    required this.pushUpCount,
    required this.activityLevel,
    required this.targetDays,
    required this.startDay,
  });

  @override
  _HgKgBmiState createState() => _HgKgBmiState();
}

class _HgKgBmiState extends State<HgKgBmi> {
  int selectedWeight = 50; // ค่าน้ำหนักเริ่มต้น (50 กิโลกรัม)
  double selectedHeight = 160; // ค่าความสูงเริ่มต้น (160 เซนติเมตร)
  bool isKg = true; // กำหนดหน่วยเริ่มต้นเป็นกิโลกรัม
  String gender = "Male"; // ค่าเริ่มต้นเพศชาย

  // ฟังก์ชันการคำนวณ BMI
  double calculateBMI() {
    double heightInMeters =
        selectedHeight / 100; // แปลงความสูงจากเซนติเมตรเป็นเมตร
    return selectedWeight /
        (heightInMeters * heightInMeters); // ใช้สูตรคำนวณ BMI
  }

  // ฟังก์ชันการตรวจสอบประเภทของค่า BMI
  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "คุณผอมเกินไป"; // Underweight
    } else if (bmi < 24.9) {
      return "คุณน้ำหนักปกติ"; // Normal weight
    } else if (bmi < 29.9) {
      return "คุณเริ่มอ้วน"; // Overweight
    } else {
      return "คุณอ้วนมาก"; // Obesity
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(); // คำนวณค่า BMI

    return Scaffold(
      backgroundColor: Colors.white, // ตั้งค่าพื้นหลังเป็นสีขาว
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // กำหนดระยะห่างรอบๆ ภายในหน้าจอ
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // จัดตำแหน่งให้เนื้อหาอยู่ด้านบนและล่าง
            children: [
              Column(
                children: [
                  const SizedBox(height: 10), // ระยะห่างระหว่างส่วนต่างๆ
                  // ส่วนเลือกน้ำหนัก
                  const Text(
                    "น้ำหนักของคุณคือ ?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent, // ใช้สีฟ้า
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ToggleButton สำหรับเลือกหน่วยน้ำหนัก
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(20),
                    selectedColor: Colors.white, // สีของข้อความเมื่อเลือก
                    fillColor: Colors.orangeAccent, // สีพื้นหลังเมื่อเลือก
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("lb"), // แสดงหน่วยปอนด์
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("kg"), // แสดงหน่วยกิโลกรัม
                      ),
                    ],
                    isSelected: [
                      !isKg,
                      isKg
                    ], // ตรวจสอบว่าเลือกกิโลกรัมหรือปอนด์
                    onPressed: (index) {
                      setState(() {
                        isKg = index == 1; // เปลี่ยนค่า isKg เมื่อเลือกหน่วย
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // การแสดงน้ำหนักที่เลือก
                  Container(
                    height: 150,
                    width: double.infinity, // ใช้ความกว้างเต็มหน้าจอ
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "$selectedWeight kg", // แสดงน้ำหนักในหน่วยกิโลกรัม
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent, // สีของข้อความ
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Picker สำหรับเลือกน้ำหนัก
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent, // พื้นหลังโปร่งใส
                      itemExtent: 50, // ความสูงของแต่ละรายการใน Picker
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedWeight -
                              30), // กำหนดจุดเริ่มต้นการแสดงผลของ Picker
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedWeight = index + 30; // ปรับน้ำหนักเมื่อเลือก
                        });
                      },
                      children: List.generate(71, (index) {
                        return Center(
                          child: Text(
                            "${index + 30}", // แสดงน้ำหนักในช่วง 30-100 กิโลกรัม
                            style: const TextStyle(
                                fontSize: 20, color: Colors.blueAccent),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // ส่วนเลือกความสูง
                  const Text(
                    "ส่วนสูงของคุณคือ ?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent, // ใช้สีฟ้า
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Slider สำหรับเลือกความสูง
                  Slider(
                    min: 100,
                    max: 220,
                    divisions: 120, // จำนวนขั้นของ Slider
                    label: "$selectedHeight cm", // แสดงค่าเมื่อผู้ใช้เลื่อน
                    value: selectedHeight, // ค่าเริ่มต้นของความสูง
                    onChanged: (value) {
                      setState(() {
                        selectedHeight =
                            value; // ปรับค่าความสูงเมื่อผู้ใช้เลื่อน
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // แสดงค่าดัชนีมวลกาย (BMI) และหมวดหมู่
                  Text(
                    "BMI: ${bmi.toStringAsFixed(1)} (${getBMICategory(bmi)})", // แสดงผล BMI และหมวดหมู่
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent, // ใช้สีแดงสำหรับข้อความ
                    ),
                  ),
                ],
              ),

              // ปุ่มย้อนกลับและไปหน้าถัดไป
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // จัดตำแหน่งให้ปุ่มอยู่ด้านซ้ายและขวา
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.blueAccent), // ปุ่มย้อนกลับ
                    onPressed: () {
                      Navigator.pop(context); // นำผู้ใช้กลับไปหน้าก่อนหน้า
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // สีพื้นหลังปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // มุมปุ่มมน
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/yearPage"); // ไปหน้าถัดไป
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // ขนาดปุ่ม
                      child: Text(
                        "Next", // ข้อความในปุ่ม
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
