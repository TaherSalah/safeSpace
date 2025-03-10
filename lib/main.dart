import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Shared/shared_obj.dart';
import 'package:safeSpace/core/Utilities/fcm_handler.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyFirebaseMessagingService.initialize();
  await MyFirebaseMessagingService.requestPermission();
  FirebaseMessaging.onBackgroundMessage(
      MyFirebaseMessagingService.firebaseMessagingBackgroundHandler);
  await MyFirebaseMessagingService.subscribeToTopic("rate-update");
  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
      // Show local notification here
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked!");
    });
  }

  SharedObj shared = SharedObj();
  shared.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends StateMVC<MyApp> {
  late HomeController con;

  MyAppState() : super(HomeController()) {
    con = controller as HomeController;
    ();
    con.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'safe space',
            initialRoute: con.auth.currentUser?.email != null
                ? Routes.mainRoute
                : Routes.onBoardingRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) =>
                RouteGenerator.getRoute(settings, context),
            theme: ThemeData(useMaterial3: true));
      },
    );
  }
}
