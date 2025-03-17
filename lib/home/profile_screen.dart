import 'package:flutter/material.dart';
import 'package:myproject/home/setting_row.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
          },
          icon: Icon(
            Icons.arrow_back, // ใช้ไอคอนลูกศรกลับ
            color: Colors.blue, // กำหนดสีของไอคอนตามต้องการ
            size: 24, // กำหนดขนาดของไอคอน
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/capybara.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Arhi nani",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "123132132",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "email@email.com",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/user.png",
                          width: 12,
                          height: 12,
                        ),
                        Text(
                          "Thailand",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
          SettingRow(
              title: "Complete Task",
              icon: "assets/images/mouse.png",
              value: "3",
              onPressed: () {}),
          SettingRow(
              title: "Level ",
              icon: "assets/images/mouse.png",
              value: "Beginner",
              onPressed: () {}),
          SettingRow(
              title: "Goals",
              icon: "assets/images/mouse.png",
              value: "Mass Gain",
              onPressed: () {}),
          SettingRow(
              title: "Challenges",
              icon: "assets/images/mouse.png",
              value: "4",
              onPressed: () {}),
          SettingRow(
              title: "Plans",
              icon: "assets/images/mouse.png",
              value: "2",
              onPressed: () {}),
          SettingRow(
              title: "Fitness Device",
              icon: "assets/images/mouse.png",
              value: "Mi",
              onPressed: () {}),
          SettingRow(
              title: "Refer a Friend",
              icon: "assets/images/mouse.png",
              value: "",
              onPressed: () {}),
        ],
      ),
    );
  }
}
