import 'package:flutter/material.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';

class LabelValueWidget extends StatelessWidget {
  String? label, value;
  LabelValueWidget({super.key, this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: getMediumStyle(
                fontColor: ColorManager.primaryFontOpacity70,
                fontSize: FontSize.regularSize),
          ),
          Text(
            value == '' ? 'N/A' : value ?? 'N/A',
            style: getMediumStyle(
                fontColor: ColorManager.primaryFont,
                fontSize: FontSize.mediumSize),
          ),
        ],
      ),
    );
  }
}
