import 'package:flutter/material.dart';

class FitnessSearchScreen extends StatefulWidget {
  @override
  _FitnessSearchScreenState createState() => _FitnessSearchScreenState();
}

class _FitnessSearchScreenState extends State<FitnessSearchScreen> {
  final ScrollController _scrollController = ScrollController(); // ตัวควบคุมการเลื่อน GridView
  final TextEditingController _searchController = TextEditingController(); // ควบคุม TextField (ช่องค้นหา)

  // ข้อมูลหมวดหมู่การออกกำลังกาย (แสดงใน GridView)
  List<Map<String, String>> categories = [
    {'title': 'Sixpack', 'image': 'assets/images/abs.png'},
    {'title': 'ArmsShoulders', 'image': 'assets/images/arms.png'},
    {'title': 'Chest', 'image': 'assets/images/chest.png'},
    {'title': 'Legs', 'image': 'assets/images/legs.png'},
  ];

  // รายการที่ถูกกรอง ตามคำค้นหา (เริ่มต้น = ทั้งหมด)
  List<Map<String, String>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories); // ก๊อปข้อมูลทั้งหมดมาใส่ตัวกรองตอนเริ่ม
  }

  // ฟังก์ชันกรองรายการ ตามคำค้นหาจาก TextField
  void _filterCategories(String query) {
    setState(() {
      filteredCategories = categories
          .where((category) =>
              category['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหา', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // --------------------- Search Bar ---------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController, // ควบคุมค่าในช่องค้นหา
              onChanged: _filterCategories, // เมื่อพิมพ์ จะเรียก _filterCategories
              decoration: InputDecoration(
                hintText: 'ค้นหา...',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
            ),
          ),

          // --------------------- GridView รายการ ---------------------
          Expanded(
            child: Scrollbar( // แถบ Scrollbar ด้านขวา
              controller: _scrollController,
              child: GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // จำนวนคอลัมน์ใน 1 แถว
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1, // อัตราส่วน กว้าง:สูง = 1:1
                ),
                itemCount: filteredCategories.length, // จำนวนไอเท็มที่แสดง
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // --------------------- เมื่อกดที่ไอเท็ม ---------------------
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetailPage(
                          title: filteredCategories[index]['title']!,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(filteredCategories[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            filteredCategories[index]['title']!, // ชื่อหมวดหมู่
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------- CATEGORY DETAIL PAGE ---------------------
class CategoryDetailPage extends StatelessWidget {
  final String title;
  CategoryDetailPage({required this.title});

  // แผนที่เก็บ path รูป GIF ตามชื่อ title
  final Map<String, String> exerciseDetails = {
    'Sixpack': 'assets/images/abs_workout.gif',
    'ArmsShoulders': 'assets/images/arms_workout.gif',
    'Chest': 'assets/images/chest_workout.gif',
    'Legs': 'assets/images/legs_workout.gif',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)), // ชื่อหัวข้อหมวดหมู่
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // รูปภาพตัวอย่างการออกกำลังกาย (GIF หรือ PNG)
            Image.asset(exerciseDetails[title] ?? 'assets/images/arms_workout.gif',
                fit: BoxFit.cover),
            SizedBox(height: 16.0),

            // --------------------- รายละเอียด ---------------------
            Text('$title Workout Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(
              'คำอธิบายเกี่ยวกับการออกกำลังกายและวิธีการทำท่าต่างๆ',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
