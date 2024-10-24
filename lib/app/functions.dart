import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../presentation/color_manager.dart';

String getFormattedDateFromDate(DateTime date) {
  var formatter = new DateFormat("yyyy-MM-dd hh:mm:ss");
  return formatter.format(date);
}

String getFormattedDateDDMMYYYY(DateTime date) {
  var formatter = new DateFormat("dd-MMM-yyyy");

  return formatter.format(date);
}

String getFormattedDateYYYYMMDD(DateTime date) {
  var formatter = new DateFormat("yyyy-MM-dd");
  return formatter.format(date);
}

String? getStringFromDate(DateTime date, String format) {
  if (date == null) {
    return null;
  }
  var formatter = new DateFormat(format);
  return formatter.format(date);
}

String? getFormattedDateStringFromString(
    String date, String sourceFormat, String convertedFormat) {
  if (date == null) {
    return null;
  }
  var formatter = new DateFormat(convertedFormat);
  return formatter.format(getDateFromString(date, sourceFormat));
}

String getFormattedDateFromYYtoDD(String? date) {
  if (date == null) {
    return "";
  }
  print("string date" + date);
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
  var formatter = new DateFormat("dd-MMM-yyyy");
  print(formatter.format(tempDate));
  return formatter.format(tempDate);
}

String getFormattedDateTimeFromDate(DateTime date) {
  var formatter = new DateFormat("yyyy-MM-dd HH:mm:ss");
  return formatter.format(date);
}

String getTodaysFormattedDate() {
  var formatter = new DateFormat("dd-MMM-yyyy");
  return formatter.format(DateTime.now());
}

bool? getBoolean(String flag) {
  if (flag.toLowerCase() == "false") {
    return false;
  } else if (flag.toLowerCase() == "true") {
    return true;
  } else {
    return null;
  }
}

String? getStringFromTIme(TimeOfDay? selectedTime) {
  if (selectedTime == null) {
    return null;
  }
  return '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}';
}

String getFormattedTimeFromDateTime(DateTime date) {
  TimeOfDay time = TimeOfDay.fromDateTime(date);
  return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}

getDateFromString(String date, String format) {
  DateTime newDate = new DateFormat(format).parse(date);
  return DateTime.utc(
      newDate.year, newDate.month, newDate.day, newDate.hour, newDate.minute);
}

DateTime convertStringToDate(String date) {
  return new DateFormat("yyyy-MM-dd hh:mm").parse(date);
}

String calculateHours(DateTime start, DateTime end) {
  Duration d = end.difference(start);
  print(start.toString());
  print(end.toString());
  int hours = d.inHours.floor();
  int minutes = (d.inMinutes % 60).floor();
  return hours.toString() + ":" + minutes.toString();
}

String getHHMMFromDate(String date) {
  var formatter = new DateFormat("hh:mm");
  DateTime punchInDateTime = new DateFormat("yyyy-MM-dd hh:mm").parse(date);
  return formatter.format(punchInDateTime);
}

String getPunchTypeMessage(String punchType) {
  if (punchType == "PUNCH_IN") {
    return "Punch In Done Successfully";
  } else {
    return "Punch out Done Successfully";
  }
}

Color getStatusColorFromStatus(String status) {
  if (status == "Pending") {
    return ColorManager.pendingColor;
  } else if (status == "Approve") {
    return ColorManager.approveColor;
  } else if (status == "Reject") {
    return ColorManager.rejectColor;
  }
  return ColorManager.primary;
}

String removeZeroFromNumber(double? number) {
  if (number == null) {
    return "";
  }
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return number.toString().replaceAll(regex, '');
}
