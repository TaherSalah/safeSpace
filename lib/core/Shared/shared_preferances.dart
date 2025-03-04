import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _userObj = "userObj";
  static const String _isEmergencyUser = "isEmergencyUser";
  static const String _isUserLogin = "isUserLogin";

  /// Save User Object
  static Future<void> saveUserObj(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userObj, jsonEncode(user));
  }

  /// Get User Object
  static Future<Map<String, dynamic>?> getUserObj() async {
    final prefs = await SharedPreferences.getInstance();
    String? userStringData = prefs.getString(_userObj);
    if (userStringData != null) {
      return jsonDecode(userStringData);
    }
    return null;
  }

  /// Remove User Data (Logout)
  static Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userObj);
    await prefs.remove(_isEmergencyUser);
  }

  /// Save Emergency User Flag
  static Future<void> saveIsEmergencyUser(bool isEmergencyUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isEmergencyUser, isEmergencyUser);
  }

  static Future<void> saveIsUserLogin(bool isUserLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isUserLogin, isUserLogin);
  }

  /// Get Emergency User Flag
  static Future<bool> getIsEmergencyUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isEmergencyUser) ?? false;
  }

  static Future<bool> getIsUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isUserLogin) ?? false;
  }
}
