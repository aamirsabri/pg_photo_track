import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/model/visit_detail.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/screens/recent_photos/photo_view_screen.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/date_widget.dart';

class RecentUploadCard extends StatelessWidget {
  RecentUpload visit;
  // Function(int visitId) onTap;
  RecentUploadCard({
    super.key,
    required this.visit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: ColorManager.white,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DateWidget(date: getDateFromString(visit.date, "yyyy-MM-dd")),
              Expanded(
                child: Column(
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
                        "Location: ${visit.visitUniqueIdentifier}",
                        style: getRegularStyle(
                            fontColor: ColorManager.darkgrey,
                            fontSize: FontSize.mediumSize),
                      ),
                    // Text(
                    //   "Photos Uploaded: ${visit.totalUploadedPhotos}",
                    //   style: getRegularStyle(
                    //       fontColor: ColorManager.darkgrey,
                    //       fontSize: FontSize.regularSize),
                    // ),
                    if (visit.city != null && visit.city != '')
                      Text(
                        "City: ${visit.city} - Pincode: ${visit.pinCode}",
                        style: getRegularStyle(
                            fontColor: ColorManager.lightGrey,
                            fontSize: FontSize.regularSize),
                      ),

                    Text(
                      "Latitude: ${visit.visitLat.toString()} \nLongitude: ${visit.visitLng.toString()}",
                      style: getRegularStyle(
                          fontColor: ColorManager.lightGrey,
                          fontSize: FontSize.regularSize),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8),
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //           onTap: () {},
              //           child: Icon(
              //             Icons.remove_red_eye,
              //             size: 25,
              //           )),
              //       Text('View Photo'),
              //     ],
              //   ),
              // ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PhotoDisplayScreen(visitId: visit.visitId);
                    }));
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    size: 35,
                  )),
            ],
          ),
        ));
    ;
  }
}
