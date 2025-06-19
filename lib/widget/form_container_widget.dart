import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller; // ควบคุมค่าข้อมูลใน TextField

  final Key? fieldKey; // คีย์สำหรับการระบุฟิลด์

  final bool? isPasswordField; // ตรวจสอบว่าฟิลด์นี้คือรหัสผ่านหรือไม่

  final String? hintText; // ข้อความแนะนำในฟิลด์เมื่อไม่มีข้อมูล

  final String? labelText; // ข้อความป้ายกำกับ (ถ้ามี)

  final String? helperText; // ข้อความช่วยเหลือ (ถ้ามี)

  final FormFieldSetter<String>? onSaved; // ฟังก์ชันที่ถูกเรียกเมื่อบันทึกค่า

  final FormFieldValidator<String>?
      validator; // ฟังก์ชันที่ใช้ตรวจสอบความถูกต้อง

  final ValueChanged<String>?
      onFieldSubmitted; // ฟังก์ชันที่เรียกเมื่อผู้ใช้กดยืนยัน

  final TextInputType? inputType; // ประเภทของคีย์บอร์ดที่ต้องการ

  final Color textColor; // สีของข้อความในช่องกรอก

  const FormContainerWidget({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    required this.textColor, // ต้องระบุสีตัวอักษร
  });

  @override
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool obscureText =
      true; // ตัวแปรที่ใช้ในการปิด/เปิดการแสดงข้อความในฟิลด์รหัสผ่าน

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ช่องกรอกข้อมูลมีความกว้างเต็มที่
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.35), // สีพื้นหลังของ Container
        borderRadius: BorderRadius.circular(10), // มุมของ Container เป็นโค้ง
      ),
      child: TextFormField(
        style: TextStyle(color: widget.textColor), // ใช้สีที่ส่งมาจากภายนอก

        controller: widget.controller, // ควบคุมค่าข้อมูล

        keyboardType: widget.inputType, // กำหนดประเภทของคีย์บอร์ด

        key: widget.fieldKey, // กำหนดคีย์สำหรับฟิลด์

        obscureText: (widget.isPasswordField ?? false)
            ? obscureText
            : false, // ถ้าฟิลด์คือรหัสผ่านให้ซ่อนข้อความ

        onSaved: widget.onSaved, // เมื่อบันทึกข้อมูลจะเรียกฟังก์ชันนี้

        validator: widget.validator, // ใช้ในการตรวจสอบความถูกต้องของข้อมูล

        onFieldSubmitted:
            widget.onFieldSubmitted, // เมื่อผู้ใช้กดยืนยันจะเรียกฟังก์ชันนี้

        decoration: InputDecoration(
          border: InputBorder.none, // ไม่มีขอบ

          filled:
              false, // ปิดการใช้งาน filled เพื่อให้ Container จัดการสีพื้นเอง

          hintText: widget.hintText, // ข้อความแนะนำในช่องกรอก

          hintStyle:
              const TextStyle(color: Colors.black45), // กำหนดสีของ hintText

          suffixIcon: (widget.isPasswordField ?? false) // ถ้าเป็นฟิลด์รหัสผ่าน

              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText =
                          !obscureText; // เปลี่ยนสถานะการแสดง/ซ่อนข้อความ
                    });
                  },
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off
                        : Icons.visibility, // เปลี่ยนไอคอนแสดง/ซ่อนรหัสผ่าน
                    color: obscureText
                        ? Colors.grey
                        : Colors.blue, // เปลี่ยนสีไอคอน
                  ),
                )
              : null, // ถ้าไม่ใช่ฟิลด์รหัสผ่าน ให้เป็น null
        ),
      ),
    );
  }
}
