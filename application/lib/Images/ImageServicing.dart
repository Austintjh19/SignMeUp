import 'package:firebase_storage/firebase_storage.dart';

class ImageServicing {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> getImageURL(String imageName) async {
    String downloadUrl =
        await storage.ref('AppImages/$imageName').getDownloadURL();
    return downloadUrl;
  }
}
