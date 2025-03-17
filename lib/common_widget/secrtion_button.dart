import 'package:flutter/material.dart';

class SecrtionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SecrtionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "more",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
