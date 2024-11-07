import 'package:flutter/material.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: ColorManager.white,
                    fontSize: FontSize.mediumLargeSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
