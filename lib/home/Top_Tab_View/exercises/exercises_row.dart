import 'package:flutter/material.dart';

class ExercisesRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const ExercisesRow({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15), // กำหนดมุมโค้งเมื่อถูกกด
      onTap: onPressed, // กำหนดฟังก์ชันเมื่อถูกคลิก
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent, // สีพื้นหลังของกล่อง
          borderRadius: BorderRadius.circular(15), // มุมโค้งของกล่อง
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 2), // เพิ่มเงาให้กล่อง
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter, // จัดวางเนื้อหาให้อยู่ตรงกลางด้านบน
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15), // ป้องกันภาพเกินขอบ
              child: AspectRatio(
                aspectRatio: 2 / 1, // กำหนดอัตราส่วนของภาพ 2:1
                child: Image.asset(
                  obj["image"], // โหลดภาพจากพาธที่กำหนด
                  width: double.maxFinite, // ทำให้ภาพเต็มความกว้าง
                  height: double.maxFinite, // ทำให้ภาพเต็มความสูง
                  fit: BoxFit.cover, // ปรับขนาดภาพให้เต็มพื้นที่
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  width: MediaQuery.of(context).size.width * 0.4, // กำหนดความกว้างตามขนาดหน้าจอ
                  decoration: const BoxDecoration(
                    color: Colors.blue, // สีพื้นหลังของกล่องข้อความ
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), // มุมบนซ้ายโค้ง
                      bottomRight: Radius.circular(30), // มุมล่างขวาโค้ง
                    ),
                  ),
                  alignment: Alignment.center, // จัดให้อยู่ตรงกลางแนวนอน
                  child: Text(
                    obj["title"], // ข้อความที่แสดง
                    maxLines: 1, // จำกัดจำนวนบรรทัดเป็น 1 บรรทัด
                    style: const TextStyle(
                      color: Colors.white, // สีตัวอักษร
                      fontSize: 15, // ขนาดตัวอักษร
                      fontWeight: FontWeight.w600, // ความหนาของตัวอักษร
                    ),
                  ),
                ),
                const Spacer(), // เพิ่มช่องว่างเพื่อให้ข้อความอยู่ด้านซ้าย
              ],
            ),
          ],
        ),
      ),
    );
  }
}