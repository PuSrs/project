import 'package:flutter/material.dart';

class HealthTipRow extends StatelessWidget {
  final Map<String, String> obj; // รับข้อมูลของแต่ละรายการ
  final VoidCallback onPressed; // ฟังก์ชันที่ทำงานเมื่อมีการกด

  const HealthTipRow({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // กำหนดให้คลิกที่รายการแล้วทำงานฟังก์ชัน onPressed
      borderRadius: BorderRadius.circular(12), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // สีพื้นหลังของกล่อง
          borderRadius: BorderRadius.circular(12), 
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)], // ใส่เงาให้กล่อง
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // จัดข้อความชิดซ้าย
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)), // กำหนดให้ขอบรูปภาพด้านบนโค้งมน
              child: Image.asset(
                obj["image"] ?? "", // ดึง path ของรูปจาก obj
                width: double.infinity, // ให้รูปขยายเต็มพื้นที่แนวนอน
                height: 150, // กำหนดความสูงของรูปภาพ
                fit: BoxFit.cover, // ให้รูปเต็มขนาดโดยไม่ผิดสัดส่วน
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10), // กำหนดระยะห่างรอบๆ ข้อความ
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // จัดข้อความชิดซ้าย
                children: [
                  Text(
                    obj["title"] ?? "No Title", // แสดงหัวข้อของ health tip
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold), // กำหนดขนาดและความหนาของข้อความ
                  ),
                  const SizedBox(height: 5), // เพิ่มระยะห่างระหว่าง Title และ Subtitle
                  Text(
                    obj["subtitle"] ?? "No Subtitle", // แสดงรายละเอียดเพิ่มเติม
                    style: const TextStyle(fontSize: 14, color: Colors.black54), // กำหนดสีและขนาดของข้อความ
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
