import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;

  DateWidget({required this.date});

  @override
  Widget build(BuildContext context) {
    // Format the day, month, and year
    String day = DateFormat('d').format(date);
    String month = DateFormat('MMM').format(date);
    print("date + $date");
    String year = DateFormat('y').format(date);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          month,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorManager.lightGrey),
        ),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: ColorManager.primary, // Background color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            day,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Text(
          year,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorManager.lightGrey),
        ),
      ],
    );
  }
}
