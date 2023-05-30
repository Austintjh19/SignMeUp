import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapplication/src/features/authentication/screens/login/LoginScreen.dart';
import 'firebase_options.dart';

// flutter build apk --build-name=1.0 --build-number=1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      defaultTransition: Transition.cupertinoDialog,
      transitionDuration: Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
