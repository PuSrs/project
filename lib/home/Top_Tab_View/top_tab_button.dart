import 'package:flutter/material.dart';

class TopTabButton extends StatelessWidget {
  final String title;
  final bool isSelect;
  final VoidCallback onPressed;

  const TopTabButton(
      {super.key,
      required this.title,
      required this.isSelect,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isSelect ? Colors.yellowAccent : Colors.transparent,
                    width: 3))),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelect ? Colors.yellowAccent : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
