import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' ;
import 'package:firebase_core/firebase_core.dart';
import 'package:myapplication/src/cubits/rooms/rooms_cubit.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/utils/constants.dart';
//import 'package:myapplication/src/pages/splash_page.dart';

// flutter build apk --build-name=1.0 --build-number=1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jjigeygqpllkgktfjfvk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqaWdleWdxcGxsa2drdGZqZnZrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODY2NTI0NTcsImV4cCI6MjAwMjIyODQ1N30.aNBrOtjuxQLtAqf58ui3xYR_EytYoS-KTWNz8vB5VHM',
    authCallbackUrlHostname: 'login',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _eventRepository = Get.put(EventRepository());
    _eventRepository.updateEventsCollection();

    return bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider<UserProfilesCubit>(
            create: (context) => UserProfilesCubit()),
        bloc.BlocProvider<GroupProfilesCubit>(
            create: (context) => GroupProfilesCubit()),
        bloc.BlocProvider<RoomCubit>(
            create: (context) => RoomCubit()..initializeRooms(context)),
      ],
      child: const GetMaterialApp(
        defaultTransition: Transition.noTransition,
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
        initialRoute: '/',
      ),
    );
  }
}
