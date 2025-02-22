// import 'dart:developer';
// import 'dart:io';
// import 'package:geolocator/geolocator.dart';
// import 'package:guidlle/Utilities/helper.dart';
// import 'package:guidlle/Utilities/toast_helper.dart';
// import 'package:location/location.dart' as loc;
//
// class LocationService {
//   static bool serviceEnabled = false;
//   static double? lat, lon;
//
//   static Future<Position?> determinePosition() async {
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       log('aaaaaaaaaaaaaaaaaaaaaaaaaa');
//
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       ToastHelper.showError(message: 'gps_warning'.tr);
//       await Future.delayed(const Duration(seconds: 3));
//       if (Platform.isAndroid) {
//         await Geolocator.openLocationSettings();
//         return await determinePosition();
//       }
//       return null;
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return null;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return null;
//     }
//     // if(permission == LocationPermission.always|| permission == LocationPermission.whileInUse)
//
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//   }
//
//   static Future<Position?> getPosition() async {
//     Position? position = await determinePosition();
//
//     lat = position?.latitude;
//     lon = position?.longitude;
//     // if (position?.isMocked == true) {
//     //   print('location is mocked !!!!');
//     //   ToastHelper.showError(message: 'location is mocked ya basha');
//     //   return null;
//     // }
//     return position;
//   }
//
//   static loc.Location? location;
//   // static Future<bool> setupLocation() async {
//   //   location ??= loc.Location();
//   //   var _serviceEnabled = await location!.serviceEnabled();
//   //   if (!_serviceEnabled) {
//   //     _serviceEnabled = await location!.requestService();
//   //     if (!_serviceEnabled) {
//   //       return false;
//   //     }
//   //   }
//   //
//   //   var _permissionGranted = await location!.hasPermission();
//   //   if (_permissionGranted == loc.PermissionStatus.denied) {
//   //     _permissionGranted = await location!.requestPermission();
//   //     if (_permissionGranted != loc.PermissionStatus.granted) {
//   //       return false;
//   //     }
//   //   }
//   //   return true;
//   // }
// }
