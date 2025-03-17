import 'package:flutter/material.dart';
import 'package:myproject/home/Top_Tab_View/exercises/exercises_row.dart';

class ExercisesNameScreen extends StatefulWidget {
  
  const ExercisesNameScreen({super.key});

  @override
  State<ExercisesNameScreen> createState() => _ExercisesNameScreenState();
}

class _ExercisesNameScreenState extends State<ExercisesNameScreen> {
  // สร้าง List ของข้อมูลที่ใช้แสดงผลใน ListView
  final List<Map<String, String>> listArr = [
    {
      "title": "44444.",
      "image": "assets/images/mouse.png",
    },
    {
      "title": "Garlic.",
      "image": "assets/images/mouse1.png",
    },
    {
      "title": "Garlic1.",
      "image": "assets/images/capybara.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: false,
        title: Text(
          "Chest",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.5),
            width: double.maxFinite,
            color: Colors.red,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/google.png",
                          width: 15,
                        ),
                      ),
                      hint: const Text(
                        "Select Level",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "Level 1",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Level 1",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Level 2",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Level 2",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (onsave) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20), // กำหนดระยะห่างรอบ ListView
                // จำนวนรายการที่ต้องการแสดง
                itemBuilder: (context, index) {
                  var obj =
                      listArr[index] as Map? ?? {}; // ดึงข้อมูลแต่ละรายการ

                  return ExercisesRow(
                    obj: obj,
                    onPressed: () {},
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20), // กำหนดระยะห่างระหว่างรายการ
                itemCount: listArr.length),
          ),
        ],
      ),
    );
  }
}
