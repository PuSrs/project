import 'package:flutter/material.dart';

class SettingRow extends StatelessWidget {
  final String title;
  final String icon;
  final String value;
  final bool isIconCircle;
  final VoidCallback onPressed;

  const SettingRow(
      {super.key,
      required this.title,
      required this.icon,
      this.value = "",
      this.isIconCircle = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(isIconCircle ? 15 : 0),
                child: Image.asset(
                  icon,
                  width: 22,
                  height: 22,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),),
              SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ));
  }
}
