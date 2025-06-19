/// day_details_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DayDetailsPage extends StatelessWidget {
  final String date;
  final DateTime dateTime;

  const DayDetailsPage({super.key, required this.date, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดวันที่ $formattedDate'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: dateTime,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              onDaySelected: (selectedDay, focusedDay) {
                print("Selected Day: ${selectedDay.toString()}");
              },
            ),
          ],
        ),
      ),
    );
  }
}

