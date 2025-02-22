import 'package:flutter/material.dart';
import 'package:safespaceapp/core/Utilities/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'safe space App',
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) =>
            RouteGenerator.getRoute(settings, context),
        theme: ThemeData(useMaterial3: true));
  }
}
