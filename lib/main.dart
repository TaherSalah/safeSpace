import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/core/Utilities/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
            title: 'safe space App',
            initialRoute: Routes.onBoardingRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) =>
                RouteGenerator.getRoute(settings, context),
            theme: ThemeData(useMaterial3: true));
      },
    );
  }
}
