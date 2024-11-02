import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/data/repositories/recent_visit_provider.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/date_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecentVisitProvider? recentVisitProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      recentVisitProvider =
          Provider.of<RecentVisitProvider>(context, listen: false);
      await recentVisitProvider!.loadRecentUploads();
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // recentVisitProvider =
    //     Provider.of<RecentVisitProvider>(context, listen: true);
    // recentVisitProvider!.loadRecentUploads();
    // // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        //do your logic here:

        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want    to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        );

        // Return    the result to the previous route
        return shouldPop;
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Visit Photo Track App'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: recentVisitProvider == null
              ? Center(child: CircularProgressIndicator())
              : (recentVisitProvider!.recentUploads.length == 0
                  ? Center(
                      child: Text(
                        'No Recent Upload',
                        style: getBoldStyle(
                            fontColor: ColorManager.lightGrey,
                            fontSize: FontSize.bigSize),
                      ),
                    )
                  : ListView.builder(
                      itemCount: recentVisitProvider!.recentUploads.length,
                      itemBuilder: (context, index) {
                        final visit = recentVisitProvider!.recentUploads[index];
                        return Card(
                            color: ColorManager.white,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  DateWidget(
                                      date: getDateFromString(
                                          visit.date, "yyyy-mm-dd")),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${visit.visitCategory}",
                                        style: getRegularStyle(
                                            fontColor: ColorManager.darkgrey,
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
                            )
                            // ListTile(
                            //   title: Text(
                            //       "Visit ID: ${visit.visitUniqueIdentifier}"),
                            //   subtitle: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text("Category: ${visit.visitCategory}"),
                            //       Text(
                            //           "Date: ${getFormattedDateStringFromString(visit.date, "yyyy-mm-dd", "dd-mm-yyyy")}"),
                            //       Text("Remark: ${visit.remark}"),
                            //     ],
                            //   ),
                            // ),
                            );
                      },
                    )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Define what happens when the button is pressed
            print('Floating Action Button Pressed');
            Navigator.pushNamed(context, Routes.visetDetail);
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat, // Optional: position of the button
      ),
    );
  }
}
