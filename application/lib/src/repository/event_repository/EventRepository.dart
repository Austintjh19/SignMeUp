import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // void selectProfileImage() async {
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 600,
  //     maxWidth: 600,
  //     imageQuality: 100,
  //   );

  //   Reference ref =
  //       FirebaseStorage.instance.ref().child("/ProfilePictures/$identifier");

  //   await ref.putFile(File(image!.path));

  //   ref.getDownloadURL().then((value) async {
  //     setState(() {
  //       imageUrl = value;
  //     });
  //   });

  //   controller.profilePic.text = ref.fullPath;
  // }
}
