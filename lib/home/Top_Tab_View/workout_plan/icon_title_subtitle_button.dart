import 'package:flutter/material.dart';

class IconTitleSubtitleButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onPressed;

  const IconTitleSubtitleButton(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
