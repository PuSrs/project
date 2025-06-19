import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/home/PageScreen/day_details_page.dart';
import 'package:myproject/home/PageScreen/fitness_search_screen.dart';
import 'package:myproject/login/fillprofile.dart';
import 'package:myproject/login/levelpage.dart';

class FitnessPlanScreenPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FitnessPlanScreenPage({super.key, required this.userData});

  @override
  _FitnessPlanScreenPageState createState() => _FitnessPlanScreenPageState();
}

class _FitnessPlanScreenPageState extends State<FitnessPlanScreenPage> {
  int _selectedIndex = 0;

  // ฟังก์ชันที่ใช้ในการเปลี่ยนหน้าหลังจากคลิกที่ BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // นำผู้ใช้ไปยังหน้าต่างต่างๆ ตาม index
    switch (index) {
      case 0: // หน้าหลัก
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FitnessPlanScreenPage(userData: widget.userData)),
        );
        break;
      case 1: // หน้าค้นหา
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FitnessSearchScreen()),
        );
        break;
      case 2: // หน้ารายงานผล
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Levelpage()),
        );
        break;
      case 3: // หน้าการตั้งค่า
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FillProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  // ฟังก์ชันที่ใช้ในการแสดงหน้ารายละเอียดของวันต่าง ๆ เมื่อคลิกที่วัน
  void _viewDayDetails(BuildContext context, DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DayDetailsPage(date: formattedDate, dateTime: date),
      ),
    );
  }

  // ฟังก์ชันที่ใช้ในการไปยังหน้ารายละเอียดการฝึกกล้ามเนื้อ
  void _navigateToBodyPartDetails(BuildContext context, String bodyPart) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyPartDetailsPage(bodyPart: bodyPart),
      ),
    );
  }

  // ฟังก์ชันที่ใช้ในการไปยังหน้ารายละเอียดโภชนาการของอาหาร
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
    final DateTime currentDay = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แผนการออกกำลังกาย',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Icon(Icons.local_fire_department, color: Colors.redAccent),
          SizedBox(width: 10),
          Icon(Icons.workspace_premium, color: Colors.orange),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนแสดงเป้าหมายรายสัปดาห์
            Text(
              'เป้าหมายรายสัปดาห์',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final day = DateTime.now().add(Duration(days: index));
                bool isToday = currentDay.day == day.day &&
                    currentDay.month == day.month &&
                    currentDay.year == day.year;

                // แต่ละวันสามารถคลิกเพื่อดูรายละเอียดการออกกำลังกาย
                return GestureDetector(
                  onTap: () => _viewDayDetails(context, day),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E').format(day),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd').format(day),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            // ข้อความกระตุ้นในการออกกำลังกาย
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
            // เลือกกล้ามเนื้อที่ต้องการฝึก
            Text(
              'เลือกกล้ามเนื้อที่ต้องการฝึก',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
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
                  _buildBodyPartButton(
                      context, 'ขา', 'assets/images/legs.png'),
                  _buildBodyPartButton(
                      context, 'ไหล่และหลัง','assets/images/shouldersandback.png'),
                ],
              ),
            ),
            SizedBox(height: 20),
            // เลือกอาหารที่ต้องการทราบโภชนาการ
            Text(
              'เลือกอาหารที่ต้องการทราบโภชนาการ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
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
      // BottomNavigationBar สำหรับการนำทาง
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

  // สร้างปุ่มสำหรับเลือกกล้ามเนื้อที่ต้องการฝึก
  Widget _buildBodyPartButton(
      BuildContext context, String bodyPart, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToBodyPartDetails(context, bodyPart),
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
            Image.asset(imagePath, width: 150, height: 100),
            SizedBox(height: 5),
            Text(
              bodyPart,
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

  // สร้างปุ่มสำหรับเลือกอาหารที่ต้องการทราบโภชนาการ
  Widget _buildFoodButton(
      BuildContext context, String foodName, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToFoodDetails(context, foodName),
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
            Image.asset(imagePath, width: 100, height: 100),
            SizedBox(height: 5),
            Text(
              foodName,
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
