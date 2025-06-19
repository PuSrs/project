import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/page_first/genderpage.dart'; // เพิ่มเพื่อใช้ Firestore

class YearPage extends StatefulWidget {
  final String userId;

  const YearPage({Key? key, required this.userId}) : super(key: key);

  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  int currentYear = DateTime.now().year;
  int selectedYear = DateTime.now().year - 20;

  Map<String, dynamic> getExercisePlanByAge(int age) {
    if (age >= 5 && age <= 12) {
      return {
        'ageGroup': 'เด็ก 5-12 ปี',
        'exerciseDaysPerWeek': 3,
        'recommendation': 'ออกกำลังกายกลางแจ้งและเล่นกีฬาที่มีการเคลื่อนไหวสูง',
      };
    } else if (age >= 13 && age <= 17) {
      return {
        'ageGroup': 'วัยรุ่น 13-17 ปี',
        'exerciseDaysPerWeek': 4,
        'recommendation':
            'เน้นออกกำลังกายแบบผสมผสาน เช่น วิ่ง ว่ายน้ำ หรือฟิตเนส',
      };
    } else if (age >= 18 && age <= 39) {
      return {
        'ageGroup': 'วัยทำงาน 18-39 ปี',
        'exerciseDaysPerWeek': 5,
        'recommendation': 'ออกกำลังกายแบบคาร์ดิโอและเวทเทรนนิ่งสลับกัน',
      };
    } else if (age >= 40 && age <= 59) {
      return {
        'ageGroup': 'วัยกลางคน 40-59 ปี',
        'exerciseDaysPerWeek': 4,
        'recommendation': 'ออกกำลังกายแบบคาร์ดิโอเบา ๆ และเน้นยืดหยุ่นร่างกาย',
      };
    } else if (age >= 60) {
      return {
        'ageGroup': 'วัยสูงอายุ 60 ปีขึ้นไป',
        'exerciseDaysPerWeek': 3,
        'recommendation': 'เน้นเดินช้า ๆ โยคะและกิจกรรมเบา ๆ เพื่อสุขภาพ',
      };
    } else {
      return {
        'ageGroup': 'ต่ำกว่า 5 ปี',
        'exerciseDaysPerWeek': 0,
        'recommendation': 'ยังไม่แนะนำให้เริ่มออกกำลังกาย',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "ปีเกิดของคุณ?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "$selectedYear",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      itemExtent: 40,
                      scrollController: FixedExtentScrollController(
                        initialItem: currentYear - selectedYear,
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedYear = currentYear - index;
                        });
                      },
                      children: List.generate(100, (index) {
                        int birthYear = currentYear - index;
                        bool isSelected = birthYear == selectedYear;
                        return Center(
                          child: Text(
                            "$birthYear",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color:
                                  isSelected ? Colors.blueAccent : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Colors.blueAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    onPressed: () async {
                      int age = currentYear - selectedYear;
                      var exercisePlan = getExercisePlanByAge(age);

                      Map<String, dynamic> dataToSave = {
                        'birthYear': selectedYear,
                        'age': age,
                        'ageGroup': exercisePlan['ageGroup'],
                        'exerciseDaysPerWeek':
                            exercisePlan['exerciseDaysPerWeek'],
                        'recommendation': exercisePlan['recommendation'],
                        'timestamp': FieldValue.serverTimestamp(),
                      };

                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userId)
                            .set(dataToSave, SetOptions(merge: true));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenderPage(
                              userId: widget.userId,
                              year: selectedYear.toString(), // ✅ แก้ตรงนี้
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('บันทึกข้อมูลล้มเหลว: $e')),
                        );
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
