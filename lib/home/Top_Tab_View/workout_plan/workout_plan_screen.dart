import 'package:flutter/material.dart';
import 'package:myproject/common_widget/round_button.dart';
import 'package:myproject/common_widget/secrtion_button.dart';
import 'package:myproject/home/Top_Tab_View/workout_plan/icon_title_subtitle_button.dart';

class WorkoutPlanScreen extends StatefulWidget {
  const WorkoutPlanScreen({super.key});

  @override
  State<WorkoutPlanScreen> createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  List muscleArr = [];
  List gainArr = [
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              IconTitleSubtitleButton(
                title: "Find a Workout Plan",
                subtitle: "Perfect Workout",
                icon: "assets/images/google.png",
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButton(
                  title: "My Plan",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              IconTitleSubtitleButton(
                title: "สร้าง plan ใหม่",
                subtitle: "Perfect Workout",
                icon: "assets/images/google.png",
                onPressed: () {},
              ),
              SecrtionButton(title: "Muscle Building", onPressed: () {}),
              SecrtionButton(title: "Gain Strength", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
