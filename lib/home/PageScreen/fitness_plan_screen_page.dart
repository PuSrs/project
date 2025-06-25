import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // สำหรับจัดรูปแบบวันที่
import 'package:myproject/home/PageScreen/day_details_page.dart'; // หน้ารายละเอียดของวัน
import 'package:myproject/home/PageScreen/fitness_search_screen.dart'; // หน้าค้นหา
import 'package:myproject/home/PageScreen/loadingscreen.dart';
import 'package:myproject/login/fillprofile.dart'; // หน้าแก้ไขโปรไฟล์
import 'package:myproject/login/levelpage.dart'; // หน้ารายงานผล

// StatefulWidget สำหรับหน้าหลักของแผนการออกกำลังกาย
class FitnessPlanScreenPage extends StatefulWidget {
  final Map<String, dynamic> userData; // รับข้อมูลผู้ใช้ที่ล็อกอินเข้ามา

  const FitnessPlanScreenPage({super.key, required this.userData});

  @override
  _FitnessPlanScreenPageState createState() => _FitnessPlanScreenPageState();
}

class _FitnessPlanScreenPageState extends State<FitnessPlanScreenPage> {
  int _selectedIndex = 0; // เก็บตำแหน่งเมนูที่เลือกใน BottomNavigationBar

  // ฟังก์ชันเมื่อผู้ใช้แตะที่ BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // เปลี่ยนหน้าจอไปตาม index ที่ผู้ใช้เลือก
    switch (index) {
      case 0: // หน้าแผนการฝึก
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FitnessPlanScreenPage(userData: widget.userData)),
        );
        break;
      case 1: // หน้า Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FitnessSearchScreen()),
        );
        break;
      case 2: // หน้า รายงานผล
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Levelpage()),
        );
        break;
      case 3: // หน้า ตั้งค่า
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FillProfilePage()),
        );
        break;
    }
  }

  // ฟังก์ชันเปิดหน้ารายละเอียดของวัน (เมื่อแตะวันที่)
  void _viewDayDetails(BuildContext context, DateTime date) {
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(date); // แปลงรูปแบบวันที่
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DayDetailsPage(date: formattedDate, dateTime: date),
      ),
    );
  }

  // ฟังก์ชันเปิดหน้ารายละเอียดกล้ามเนื้อ
  void _navigateToBodyPartDetails(BuildContext context, String bodyPart) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyPartDetailsPage(bodyPart: bodyPart),
      ),
    );
  }

  // ฟังก์ชันเปิดหน้ารายละเอียดโภชนาการอาหาร
  void _navigateToFoodDetails(BuildContext context, String foodName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(foodName: foodName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDay = DateTime.now(); // วันที่ปัจจุบัน

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แผนการออกกำลังกาย', // หัวข้อหลัก
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Icon(Icons.local_fire_department,
              color: Colors.redAccent), // ไอคอนแสดงพลัง
          SizedBox(width: 10),
          Icon(Icons.workspace_premium, color: Colors.orange), // ไอคอนแสดงระดับ
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงหัวข้อ เป้าหมายรายสัปดาห์
            Text(
              'เป้าหมายรายสัปดาห์',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // สร้างแถวของปุ่มสำหรับแต่ละวัน (7 วันถัดไป)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final day =
                    DateTime.now().add(Duration(days: index)); // วันลำดับถัดไป
                bool isToday = currentDay.day == day.day &&
                    currentDay.month == day.month &&
                    currentDay.year ==
                        day.year; // เช็คว่าเป็นวันปัจจุบันหรือไม่

                return GestureDetector(
                  onTap: () =>
                      _viewDayDetails(context, day), // คลิกเพื่อดูรายละเอียดวัน
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isToday
                          ? Colors.blue
                          : Colors.white, // สีต่างกันถ้าเป็นวันนี้
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E')
                              .format(day), // แสดงชื่อวัน (Mon, Tue, etc.)
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd').format(day), // แสดงวันที่
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),

            // ข้อความให้กำลังใจผู้ใช้งาน
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/body_focus.png"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ทุกขั้นตอนการก้าวไปข้างหน้ามีค่า จงเดินหน้าต่อไป!',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // หัวข้อเลือกกล้ามเนื้อ
            Text(
              'คำนวน Calories',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // แถบเลื่อนแนวนอนของปุ่ม calories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoadingScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/images/lock.png',
                              width: 150, height: 100),
                          const SizedBox(height: 5),
                          const Text(
                            'Calories',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'เลือกกล้ามเนื้อที่ต้องการฝึก',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // แถบเลื่อนแนวนอนของปุ่มกล้ามเนื้อ
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBodyPartButton(
                      context, 'หน้าท้อง', 'assets/images/abs.png'),
                  _buildBodyPartButton(
                      context, 'แขน', 'assets/images/arms.png'),
                  _buildBodyPartButton(
                      context, 'หน้าอก', 'assets/images/chest.png'),
                  _buildBodyPartButton(context, 'ขา', 'assets/images/legs.png'),
                  _buildBodyPartButton(context, 'ไหล่และหลัง',
                      'assets/images/shouldersandback.png'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // หัวข้อเลือกอาหาร
            Text(
              'เลือกอาหารที่ต้องการทราบโภชนาการ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // แถบเลื่อนแนวนอนของปุ่มอาหาร
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFoodButton(context, 'ข้าว', 'assets/images/rice.png'),
                  _buildFoodButton(
                      context, 'อกไก่', 'assets/images/chicken.png'),
                  _buildFoodButton(
                      context, 'ผัก', 'assets/images/vegetables.png'),
                  _buildFoodButton(
                      context, 'ผลไม้', 'assets/images/fruits.png'),
                ],
              ),
            ),
          ],
        ),
      ),

      // เมนูด้านล่าง (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex, // ตำแหน่งเมนูที่ถูกเลือก
        onTap: _onItemTapped, // ฟังก์ชันที่เรียกเมื่อแตะ
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'การฝึก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'ค้นหา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'รายงานผล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
          ),
        ],
      ),
    );
  }

  // ปุ่มกล้ามเนื้อแต่ละส่วน
  Widget _buildBodyPartButton(
      BuildContext context, String bodyPart, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToBodyPartDetails(
          context, bodyPart), // คลิกไปหน้ารายละเอียดกล้ามเนื้อ
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Column(
          children: [
            Image.asset(imagePath,
                width: 150, height: 100), // แสดงรูปกล้ามเนื้อ
            SizedBox(height: 5),
            Text(
              bodyPart, // ชื่อกล้ามเนื้อ
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // ปุ่มอาหารแต่ละชนิด
  Widget _buildFoodButton(
      BuildContext context, String foodName, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToFoodDetails(
          context, foodName), // คลิกไปหน้ารายละเอียดอาหาร
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 100, height: 100), // แสดงรูปอาหาร
            SizedBox(height: 5),
            Text(
              foodName, // ชื่ออาหาร
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyPartDetailsPage extends StatelessWidget {
  final String bodyPart;

  const BodyPartDetailsPage({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ฝึก $bodyPart'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'แผนการฝึก $bodyPart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _getWorkoutPlanForBodyPart(bodyPart),
          ],
        ),
      ),
    );
  }

  // แสดงแผนการฝึกสำหรับแต่ละกล้ามเนื้อ
  Widget _getWorkoutPlanForBodyPart(String bodyPart) {
    switch (bodyPart) {
      case 'หน้าท้อง':
        return Text(
            'แนะนำการออกกำลังกายสำหรับหน้าท้อง:\n1. Crunches\n2. Leg raises\n3. Plank');
      case 'แขน':
        return Text(
            'แนะนำการออกกำลังกายสำหรับแขน:\n1. Push-ups\n2. Tricep Dips');
      case 'หน้าอก':
        return Text(
            'แนะนำการออกกำลังกายสำหรับหน้าอก:\n1. Push-ups\n2. Bench Press');
      case 'ขา':
        return Text('แนะนำการออกกำลังกายสำหรับขา:\n1. Squats\n2. Lunges');
      case 'ไหล่และหลัง':
        return Text(
            'แนะนำการออกกำลังกายสำหรับไหล่และหลัง:\n1. Shoulder Press\n2. Deadlifts');
      default:
        return Center(child: Text('ไม่มีแผนการฝึกสำหรับส่วนนี้'));
    }
  }
}

class FoodDetailsPage extends StatelessWidget {
  final String foodName;
  const FoodDetailsPage({super.key, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โภชนาการของ $foodName'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'ข้อมูลโภชนาการของ $foodName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _getFoodDetails(foodName),
          ],
        ),
      ),
    );
  }

  // แสดงข้อมูลโภชนาการของอาหาร
  Widget _getFoodDetails(String foodName) {
    switch (foodName) {
      case 'ข้าว':
        return Text(
            'โภชนาการของข้าว:\n1. พลังงาน: 130 Kcal\n2. โปรตีน: 3 g\n3. คาร์โบไฮเดรต: 28 g');
      case 'อกไก่':
        return Text(
            'โภชนาการของไก่:\n1. พลังงาน: 165 Kcal\n2. โปรตีน: 31 g\n3. ไขมัน: 3.6 g');
      case 'ผัก':
        return Text(
            'โภชนาการของผัก:\n1. พลังงาน: 50 Kcal\n2. โปรตีน: 2 g\n3. ไฟเบอร์: 5 g');
      case 'ผลไม้':
        return Text(
            'โภชนาการของผลไม้:\n1. พลังงาน: 52 Kcal\n2. โปรตีน: 0.5 g\n3. คาร์โบไฮเดรต: 14 g');
      default:
        return Center(child: Text('ไม่มีข้อมูลโภชนาการสำหรับอาหารนี้'));
    }
  }
}
