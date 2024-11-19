import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:pg_photo_track/data/providers/category_provider.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';

import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/label_value_widget.dart';
import 'package:pg_photo_track/utils/locationinfo.dart';
import 'package:provider/provider.dart';

class ReviewAndSubmitScreen extends StatefulWidget {
  @override
  State<ReviewAndSubmitScreen> createState() => _ReviewAndSubmitScreenState();
}

class _ReviewAndSubmitScreenState extends State<ReviewAndSubmitScreen> {
  TextEditingController _remarkController = TextEditingController();
  VisitDetailProvider? _visitDetailProvider;
  CategoryProvider? _categoryProvider;
  LoginProvider? _loginProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _visitDetailProvider = Provider.of<VisitDetailProvider>(context);
    _categoryProvider = Provider.of<CategoryProvider>(context);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _remarkController.text = _visitDetailProvider?.visitDetail?.remarks ?? '';
    super.didChangeDependencies();
  }

  Future<void> submitVisitDetails() async {
    EasyLoading.showInfo("Fetching Location...",
        duration: Duration(seconds: 3));
    // EasyLoading.show();
    _visitDetailProvider!.setLoading(true);
    // Position position = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    // );
    MyLocation location = await LocationInfo.getUserLocation();
    await location.setFullAddress();
    await location.setCityName();
    await location.setPinCode();
    print("location address" + location.fullAddress.toString());
    // Extract latitude and longitude
    // _visitDetailProvider!.visitDetail.lat = position.latitude;
    // _visitDetailProvider!.visitDetail.lng = position.longitude;
    _visitDetailProvider!.visitDetail.locationDetail = location;
    // _visitDetailProvider!.visitDetail.lng = location.longitude;
    EasyLoading.show();

    await _visitDetailProvider!
        .submitVisitDetailsWithPhotos(_loginProvider?.user);

    EasyLoading.dismiss();
    // longitude = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review and Submit")),
      body: _visitDetailProvider!.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Field Visit Detail",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  LabelValueWidget(
                    label: "Photo Location Detail",
                    value: _visitDetailProvider!.visitDetail.label,
                  ),
                  LabelValueWidget(
                    label: "Purpose",
                    value: _visitDetailProvider!
                            .visitDetail.selectedCategory?.name ??
                        '',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Captured Photo",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Image.file(_visitDetailProvider!.photos[0].photo,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Remark",
                    style: getMediumStyle(
                        fontColor: ColorManager.primaryFontOpacity70,
                        fontSize: FontSize.mediumSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      style: getMediumStyle(
                          fontColor: ColorManager.darkgrey,
                          fontSize: FontSize.mediumLargeSize,
                          fontWeight: FontWeight.bold),
                      controller: _remarkController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Enter Remark',
                        hintStyle: getMediumStyle(
                            fontColor: ColorManager.darkgrey,
                            fontSize: FontSize.mediumLargeSize,
                            fontWeight: FontWeight.bold),
                      ),
                      minLines: 3,
                      maxLines: 3,
                      onChanged: (value) {
                        _visitDetailProvider!.visitDetail.setRemarkd(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Spacer(),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                "BACK",
                style: getMediumStyle(
                    fontColor: ColorManager.white,
                    fontSize: FontSize.mediumSize),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await submitVisitDetails();
                  print("submit done");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Photos uploaded successfully")),
                  );
                  // Navigator.popUntil(
                  //     context, ModalRoute.withName(Routes.visetDetail));
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to upload visit details")),
                  );
                }
              },
              child: Text(
                "SUBMIT",
                style: getMediumStyle(
                    fontColor: ColorManager.white,
                    fontSize: FontSize.mediumSize),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
