import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearPage extends StatefulWidget {
  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  int currentYear = DateTime.now().year;
  int selectedYear = DateTime.now().year - 20; 

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
                  // หัวข้อ
                  const Text(
                    "ปีเกิดของคุณ?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // กล่องแสดงปีเกิดที่เลือก
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
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.blueAccent : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),

              // ปุ่ม Back และ Next
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
                    onPressed: () {
                      Navigator.pushNamed(context, "/hgkgbmi");
                    },
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/toptabviewscreen");
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
