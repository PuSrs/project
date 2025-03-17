import 'package:flutter/material.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController controller; // เพิ่ม final TextEditingController controller
  final String hintText;
  final String icon;
  final bool obscureText;
  final String rIcon;
  final TextInputType keyboardType; // เพิ่ม keyboardType
  final EdgeInsets? margin;

  const RoundTextfield({
    super.key,
    required this.controller, // required controller
    required this.hintText,
    required this.icon,

    this.obscureText = false,
    this.rIcon = "", // กำหนดค่าเริ่มต้นให้ rIcon เป็นค่าว่าง
    this.keyboardType = TextInputType.text, // เพิ่มค่าเริ่มต้น keyboardType
    this.margin,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 246, 246),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller, // เพิ่ม controller
        keyboardType: keyboardType, // เพิ่ม keyboardType
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          suffixIcon: rIcon.isNotEmpty // ตรวจสอบว่ามี rIcon หรือไม่ & ตกแต่ง ในตัว rIcon
              ? Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    rIcon,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                )
              : null,
          prefixIcon: Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: Colors.grey,
            ),
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
