import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
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
  bool _isLoading = false;
  RecentVisitProvider? recentVisitProvider;
  LoginProvider? loginProvider;
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      recentVisitProvider =
          Provider.of<RecentVisitProvider>(context, listen: false);
      await recentVisitProvider!.loadRecentUploads();
      _isLoading = false;

      // await getLocation(21.5184434, 70.4601779);
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
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
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/pgvclicon.jpg',
                width: 32,
                height: 32,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<LoginProvider>(context, listen: false)
                      .logOut(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (_isLoading == true)
              ? Center(child: CircularProgressIndicator())
              : ((recentVisitProvider?.recentUploads.length == 0 ||
                      recentVisitProvider!.errorMessage != null)
                  ? Center(
                      child: Text(
                        recentVisitProvider!.errorMessage != null
                            ? recentVisitProvider!.errorMessage.toString()
                            : 'No Recent Upload',
                        style: getBoldStyle(
                            fontColor: ColorManager.lightGrey,
                            fontSize: FontSize.bigSize),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Recent Uploads",
                            style: getRegularStyle(
                                fontColor: ColorManager.secondary,
                                fontSize: FontSize.mediumSize),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                recentVisitProvider!.recentUploads.length,
                            itemBuilder: (context, index) {
                              final visit =
                                  recentVisitProvider!.recentUploads[index];
                              print(
                                  "visit identifier  ${visit?.visitUniqueIdentifier.toString()}");
                              return Card(
                                  color: ColorManager.white,
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        DateWidget(
                                            date: getDateFromString(
                                                visit.date, "yyyy-MM-dd")),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${visit.visitCategory}",
                                              style: getRegularStyle(
                                                  fontColor:
                                                      ColorManager.secondary,
                                                  fontSize:
                                                      FontSize.mediumLargeSize),
                                            ),
                                            if (visit.visitUniqueIdentifier !=
                                                    null &&
                                                visit.visitUniqueIdentifier !=
                                                    '')
                                              Text(
                                                "Visit Identifier: ${visit.visitUniqueIdentifier}",
                                                style: getRegularStyle(
                                                    fontColor:
                                                        ColorManager.darkgrey,
                                                    fontSize:
                                                        FontSize.regularSize),
                                              ),
                                            Text(
                                              "Photos Uploaded: ${visit.totalUploadedPhotos}",
                                              style: getRegularStyle(
                                                  fontColor:
                                                      ColorManager.darkgrey,
                                                  fontSize:
                                                      FontSize.regularSize),
                                            ),
                                            Text(
                                              "Latitude: ${visit.visitLat.toString()} \nLongitude: ${visit.visitLng.toString()}",
                                              style: getRegularStyle(
                                                  fontColor:
                                                      ColorManager.lightGrey,
                                                  fontSize: FontSize.smallSize),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (_isLoading || recentVisitProvider?.errorMessage != null)
              ? null
              : () async {
                  Navigator.pushNamed(context, Routes.visetDetail);
                },
          tooltip: 'Add',
          child: Icon(
            Icons.add,
            color: (_isLoading || recentVisitProvider?.errorMessage != null)
                ? ColorManager.darkgrey
                : ColorManager.primary,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat, // Optional: position of the button
      ),
    );
  }
}
