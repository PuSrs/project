import 'package:flutter/material.dart';

class Targetpage extends StatefulWidget {
  @override
  _TargetpageState createState() => _TargetpageState();
}

class _TargetpageState extends State<Targetpage> {
  List<String> goals = [
    "Get Fitter",
    "Gain Weight",
    "Lose Weight",
    "Building Muscles",
    "Improving Endurance",
    "Others"
  ];
  List<bool> selectedGoals = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ตั้งค่าพื้นหลังเป็นสีขาว
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("What is Your Goal?",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "You can choose more than one. Don't worry, you can always change it later.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoals[index] =
                            !selectedGoals[index]; // เปลี่ยนสถานะเมื่อกดเลือก
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedGoals[index]
                              ? Colors.orange
                              : Colors.blue, // สีกรอบเปลี่ยนตามสถานะ
                          width: 2,
                        ),
                        color: selectedGoals[index]
                            ? Colors.orange.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(goals[index],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          if (selectedGoals[index])
                            Icon(Icons.check, color: Colors.orange),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Colors.blue), // ปุ่มย้อนกลับสีฟ้า
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // ปุ่มถัดไปสีส้ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // ตรวจสอบว่าเลือกเป้าหมายหรือไม่
                    if (!selectedGoals.contains(true)) {
                      // ถ้ายังไม่ได้เลือกเป้าหมาย จะให้แสดง Snackbar แจ้งเตือน
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select at least one goal.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // ถ้าเลือกเป้าหมายแล้ว ให้ไปหน้าถัดไป
                      Navigator.pushNamed(context, "/levelPage");
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      "Next",
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
    );
  }
}
