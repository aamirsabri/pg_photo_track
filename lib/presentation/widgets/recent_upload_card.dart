import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/model/visit_detail.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/date_widget.dart';

class RecentUploadCard extends StatelessWidget {
  RecentUpload visit;
  RecentUploadCard({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: ColorManager.white,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              DateWidget(date: getDateFromString(visit.date, "yyyy-MM-dd")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${visit.visitCategory}",
                    style: getRegularStyle(
                        fontColor: ColorManager.secondary,
                        fontSize: FontSize.mediumLargeSize),
                  ),
                  if (visit.visitUniqueIdentifier != null &&
                      visit.visitUniqueIdentifier != '')
                    Text(
                      "Visit Identifier: ${visit.visitUniqueIdentifier}",
                      style: getRegularStyle(
                          fontColor: ColorManager.darkgrey,
                          fontSize: FontSize.regularSize),
                    ),
                  Text(
                    "Photos Uploaded: ${visit.totalUploadedPhotos}",
                    style: getRegularStyle(
                        fontColor: ColorManager.darkgrey,
                        fontSize: FontSize.regularSize),
                  ),
                  Text(
                    "Latitude: ${visit.visitLat.toString()} \nLongitude: ${visit.visitLng.toString()}",
                    style: getRegularStyle(
                        fontColor: ColorManager.lightGrey,
                        fontSize: FontSize.smallSize),
                  ),
                ],
              ),
            ],
          ),
        ));
    ;
  }
}
