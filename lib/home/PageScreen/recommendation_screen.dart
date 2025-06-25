import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('อาหารที่แนะนำ')),
      body: Center(
        child: Text(
          'เร็วๆ นี้...',
          style: TextStyle(fontSize: 36, color: Colors.grey),
        ),
      ),
    );
  }
}
