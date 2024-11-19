import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
import 'package:pg_photo_track/data/repositories/recent_visit_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/date_widget.dart';
import 'package:pg_photo_track/presentation/widgets/recent_upload_card.dart';
import 'package:provider/provider.dart';

class ViewPhotosScreen extends StatefulWidget {
  const ViewPhotosScreen({super.key});

  @override
  State<ViewPhotosScreen> createState() => _ViewPhotosScreenState();
}

class _ViewPhotosScreenState extends State<ViewPhotosScreen> {
  // RecentVisitProvider? recentVisitProvider;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<RecentVisitProvider>(context, listen: false)
          .loadRecentUploads();

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
    final recentVisitProvider = Provider.of<RecentVisitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/pgvclicon.jpg',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'View Photos',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<RecentVisitProvider>(
            builder: (context, recentVisitProvider, child) {
          if (recentVisitProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (recentVisitProvider.hasError) {
            return Center(
              child: Text(
                recentVisitProvider.errorMessage ??
                    'Something wrong! please try again',
                style: getBoldStyle(
                  fontColor: ColorManager.lightGrey,
                  fontSize: FontSize.bigSize,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (recentVisitProvider.recentUploads.isEmpty) {
            return Center(
              child: Text(
                'No Recent Uploads',
                style: getBoldStyle(
                  fontColor: ColorManager.lightGrey,
                  fontSize: FontSize.bigSize,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return RecentUploadList(
            recentUploads: recentVisitProvider.recentUploads,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Routes.visetDetail);
        },
        tooltip: 'Add',
        child: Icon(
          Icons.add,
          color: (recentVisitProvider.isLoading ||
                  recentVisitProvider?.errorMessage != null)
              ? ColorManager.darkgrey
              : ColorManager.primary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Optional: position of the button
    );
  }
}

class RecentUploadList extends StatelessWidget {
  List<RecentUpload> recentUploads;
  Category? lastCatgory;
  RecentUploadList({
    required this.recentUploads,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: recentUploads.length,
        itemBuilder: (context, index) {
          final lastCat = recentUploads[index].visitCategory;
          if (index > 1) {
            if (lastCat != recentUploads[index - 1].visitCategory) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    lastCat,
                    style: getMediumStyle(
                        fontColor: ColorManager.darkgrey,
                        fontSize: FontSize.mediumLargeSize),
                  ),
                  RecentUploadCard(
                    visit: recentUploads[index],
                  ),
                ],
              );
            }
          }
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  lastCat,
                  style: getMediumStyle(
                      fontColor: ColorManager.darkgrey,
                      fontSize: FontSize.mediumLargeSize),
                ),
                RecentUploadCard(
                  visit: recentUploads[index],
                ),
              ],
            );
          }
          return RecentUploadCard(
            visit: recentUploads[index],
          );
        });
  }
}
