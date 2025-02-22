import 'package:shared_preferences/shared_preferences.dart';

import 'shared_obj.dart';

class SharedPref {
  static const String _userObj = "userObj";
  static const String _userSubjects = "userSubjects";
  static const String _language = "language_code";
  static const String _deviceId = "device_id";

  static const String _intro = "intro";

  // static Future<bool?> saveUserObj({required User user}) async {
  //   return await SharedObj().prefs?.setString(_userObj, jsonEncode(user.toJson()));
  // }
  //
  // static User getUserObg() {
  //   if(SharedObj().prefs!.containsKey(_userObj))
  //     {
  //       String? userStringData = SharedObj().prefs?.getString(_userObj);
  //       return User.fromJson(jsonDecode(userStringData!));
  //     }
  //   else {
  //     return User(id: -1, name: '', token: '', email: '', phone: '', image: '',
  //         studentInfo: StudentInfo(infoId: 0, countryId: 0, countryName: '', countryImage: '', gradeId: 0, gradeName: '', current: false), status: '');
  //   }
  //  // return null;
  //   // if (userStringData == null) return null;
  //   // return User.fromJson(jsonDecode(userStringData));
  // }
  //
  // static bool isUserLogIn() {
  //   return SharedObj().prefs?.getString(_userObj) != null;
  // }

  static Future<void> logOut() async {
    await SharedObj().prefs?.remove(_userObj);
  }

  static String? getCurrentLang() {
    return SharedObj().prefs?.getString(_language);
  }

  static Future<void> setCurrentLang({required String lang}) async {
    await SharedObj().prefs?.setString(_language, lang);
  }

  Future<String> getValueFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getString(key) ?? '';
    } else {
      return '';
    }
  }
  // // saving Device Id
  // static Future<void> setDeviceID({required String deviceID}) async {
  //   await SharedObj().prefs?.setString(_deviceId, deviceID);
  // }

  // getting Device Id
  // static String? getDeviceID() {
  //   return SharedObj().prefs?.getString(_deviceId);
  // }

  static Future<void> saveWatchIntro() async {
    await SharedObj().prefs?.setBool(_intro, true);
  }

  static bool isWatchIntro() {
    return SharedObj().prefs?.getBool(_intro) ?? false;
  }
}
