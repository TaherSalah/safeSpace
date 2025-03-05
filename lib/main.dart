import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Shared/shared_obj.dart';
import 'package:safeSpace/core/Utilities/fcm_handler.dart';
import 'package:safeSpace/core/Utilities/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyFirebaseMessagingService.initialize();
  await MyFirebaseMessagingService.requestPermission();
  FirebaseMessaging.onBackgroundMessage(MyFirebaseMessagingService.firebaseMessagingBackgroundHandler);
  await MyFirebaseMessagingService.subscribeToTopic("rate-update");
  SharedObj shared = SharedObj();
  shared.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'safe space',
            initialRoute: Routes.mainRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) =>
                RouteGenerator.getRoute(settings, context),
            theme: ThemeData(useMaterial3: true));
      },
    );
  }
}




