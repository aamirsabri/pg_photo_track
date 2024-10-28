import 'package:pg_photo_track/app/apis.dart';
import 'package:pg_photo_track/model/request.dart';

class VisitRepository {
  Future<dynamic> getCategories() async {
    return await AppServiceClient.getAllPhotoCategories();
  }
}
