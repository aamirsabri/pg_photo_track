import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pg_photo_track/data/repositories/recent_visit_provider.dart';
import 'package:provider/provider.dart';

class PhotoDisplayScreen extends StatefulWidget {
  int visitId;
  PhotoDisplayScreen({super.key, required this.visitId});
  @override
  _PhotoDisplayScreenState createState() => _PhotoDisplayScreenState();
}

class _PhotoDisplayScreenState extends State<PhotoDisplayScreen> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final recentUploadProvider = Provider.of<RecentVisitProvider>(context);
    imageBytes = await recentUploadProvider.fetchRecentPhoto(widget.visitId);
    setState(() {});
    // print('image bytes size ' + imageBytes!.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Display')),
      body: Center(
        child: imageBytes != null
            ? Image.memory(imageBytes!)
            : CircularProgressIndicator(),
      ),
    );
  }
}
