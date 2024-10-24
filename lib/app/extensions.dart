import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/constants.dart';

extension NonNullString on String? {
  String isEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

extension TimeOfDayExtension on TimeOfDay? {
  int compareTo(TimeOfDay? other) {
    if (this!.hour < other!.hour) return -1;
    if (this!.hour > other.hour) return 1;
    if (this!.minute < other.minute) return -1;
    if (this!.minute > other.minute) return 1;
    return 0;
  }
}
