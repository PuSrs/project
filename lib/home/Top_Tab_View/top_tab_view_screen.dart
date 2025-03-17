import 'package:flutter/material.dart';

import 'package:myproject/home/Top_Tab_View/exercises/exercises_tab_screen.dart';
import 'package:myproject/home/Top_Tab_View/health_tip/health_tip_screen.dart';
import 'package:myproject/home/Top_Tab_View/top_tab_button.dart';
import 'package:myproject/home/Top_Tab_View/workout_plan/workout_plan_screen.dart';

class TopTabViewScreen extends StatefulWidget {
  const TopTabViewScreen({super.key});

  @override
  State<TopTabViewScreen> createState() => _TopTabViewScreenState();
}

class _TopTabViewScreenState extends State<TopTabViewScreen>
    with SingleTickerProviderStateMixin {
  final List<String> tapArr = [
    "Health Tip",
    "Exercises",
    "Workout Plan",
    "Challenges",
    "Trainers",
    "Dietician"
  ];

  late TabController controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tapArr.length, vsync: this);
    controller.addListener(() {
      setState(() {
        selectTab = controller.index;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        leading: Container(),
        leadingWidth: 20,
        title: const Text(
          "FitSpark",
          style: TextStyle (
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tapArr.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TopTabButton(
                      title: tapArr[index],
                      isSelect: selectTab == index,
                      onPressed: () {
                        setState(() {
                          selectTab = index;
                          controller.animateTo(index);
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                HealthTipScreen(),  // Health Tip Tab
                ExercisesTabScreen(),  // Exercise Tab (คุณต้องสร้างไฟล์นี้)
                WorkoutPlanScreen(),  // Workout Plan Tab (สร้างไฟล์นี้)
                Container(),  // Challenges Tab (สร้างไฟล์นี้)
                Container(),  // Trainers Tab (สร้างไฟล์นี้)
                Container(),  // Dietician Tab (สร้างไฟล์นี้)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
