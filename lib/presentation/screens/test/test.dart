import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/utils/locationinfo.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  MyLocation? location;
  Future<void> fetchLocation() async {
    location = await LocationInfo.getUserLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await fetchLocation();
                  EasyLoading.showInfo("Updated ");
                },
                child: Text('Fetch Location')),
            (location != null)
                ? Text(
                    "Location : ${location!.latitude.toString()} , Longitude : ${location!.longitude.toString()}")
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
