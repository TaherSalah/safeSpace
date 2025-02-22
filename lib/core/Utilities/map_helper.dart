// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:guidlle/Utilities/toast_helper.dart';
// import 'package:location/location.dart' as loc;
//
// class MapHelper {
//   static Future<bool> checkGps() async {
//     loc.Location location = loc.Location();
//     if (!await location.serviceEnabled()) {
//       return await location.requestService();
//     } else {
//       return true;
//     }
//   }
//
//   static Future<String?> getAddressFromLatLng(LatLng? po) async {
//     try {
//       po ?? await getCurrentLocation();
//       if (po == null) return null;
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(po.latitude, po.longitude);
//       Placemark place = placemarks[0];
//       return place.street;
//     } catch (e) {
//       return null;
//     }
//   }
//
//   static Future<Position?> getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ToastHelper.showError(message: 'Location services are disabled.');
//       return null;
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ToastHelper.showError(message: 'Location permissions are denied');
//         return null;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ToastHelper.showError(
//           message:
//               'Location permissions are permanently denied, we cannot request permissions.');
//       return null;
//     }
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
// }
