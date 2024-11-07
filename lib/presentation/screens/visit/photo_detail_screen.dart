import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/screens/capture_review_photos/capture_review_photos.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class PhotoDetailScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  Category category;

  PhotoDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider =
        Provider.of<VisitDetailProvider>(context, listen: false);
    if (visitDetailProvider?.visitDetail?.label != null) {
      _controller.text = visitDetailProvider.visitDetail.label.toString();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Field Location Detail")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: getMediumStyle(
                      fontColor: ColorManager.primaryFont,
                      fontSize: FontSize.bigSize),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Add Location",
              style: getMediumStyle(
                  fontColor: ColorManager.primaryFontOpacity70,
                  fontSize: FontSize.mediumLargeSize),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                style: getMediumStyle(
                    fontColor: ColorManager.darkgrey,
                    fontSize: FontSize.mediumLargeSize,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'type detail about visit location',
                  hintStyle: getMediumStyle(
                      fontColor: ColorManager.darkgrey,
                      fontSize: FontSize.mediumLargeSize,
                      fontWeight: FontWeight.bold),
                ),
                minLines: 5,
                maxLines: 5,
                onChanged: (value) {
                  visitDetailProvider.visitDetail.label = value.toString();
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            CustomButton(
                label: 'Next - Take Photo',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.takePhoto);
                }),
          ],
        ),
      ),
    );
  }
}
