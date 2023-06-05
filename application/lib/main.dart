import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'firebase_options.dart';

// flutter build apk --build-name=1.0 --build-number=1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      defaultTransition: Transition.noTransition,
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }

  // @override
  //   Widget build(BuildContext context){
  //       return FutureBuilder<User>(
  //           future: FirebaseAuth.instance.currentUser,
  //           builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
  //                      if (snapshot.hasData){
  //                          FirebaseUser? user = snapshot.data; // this is your user instance
  //                          /// is because there is user already logged
  //                          return SignInScreen();
  //                       }
  //                        /// other way there is no user logged.
  //                        return Jo();
  //            }
  //         );
  //   }
}
