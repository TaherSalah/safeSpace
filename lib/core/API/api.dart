import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Shared/shared_preferances.dart';

class API {
  static const String _baseURL = "https://app.schoopedia.com/api/";

  //=========================== api parameters ====================================
  static const String login = "login";
  static const String loginWithFacebook = "auth/facebook";
  static const String loginWithGmail = "auth/google";
  static const String loginWithApple = "auth//apple";
  static const String logout = "logout";
  static const String register = "register";
  static const String activateAccount = "active-account";
  static const String forgetPassword = "forget-password";
  static const String checkForgetPasswordCode = "forget-password/code";
  static const String changePassword = "forget-password/new-password";
  static const String getCountries = "get-countries";
  static const String storeStudentInfo = "student/store-info";
  static const String addComment = "comment/store";
  static const String reportComment = "comment/report/store";
  static const String showFavorites = "show-Favorites-videos";
  static const String addToFavorite = "store-Favorites-videos";
  static const String deleteFavorite = "delete-Favorites-videos/9493";
  static const String rateVideo = "rate/store";
  static const String studentGrades = "student/country-grades";
  static const String changeGrade = "student/change-grade";
  static const String deleteAccount = "delete-account";
  static const String contactUs = "complaints/store";
  static const String resendActivationCode = "resend-code/active-account";
  static const String updateProfile = "edit-profile";
  static const String storeStudentVideoLog = "store-student-videos-log";

  // apis with query parameters ...............................................

  static String getGrades(int? countryId) =>
      "get-grades?active=true&country_id=$countryId";

  static String getGradeStandard(int? gradeId) =>
      "get-grade-standards?grade_id=$gradeId";

  static String currentGradeStandard(int? infoId) =>
      "student/current-standards/$infoId";

  static String getSubjectsForUser(int? studentInfo, int? gradeId) =>
      "get/subject/$studentInfo/$gradeId";

  static String getVideosInLesson(String? subjectId, String? lessonId) =>
      "get-video-links/$subjectId/$lessonId";

  static String getLessonOfSubject(int? subjectId) =>
      "subject/lesson/$subjectId";

  static String getVideoDetails(int? videoId) => "get-video/$videoId";

  static String updateComment(int? commentId) => "comment/update/$commentId";

  static String deleteComment(int? commentId) => "comment/delete/$commentId";

  static String deleteFromFavorite(int? videoId) =>
      "delete-Favorites-videos/$videoId";

  static String updateVideoRate(int? rateIdId) => "rate/update/$rateIdId";

  static String updateStudentInfo(int? studentInfoId) =>
      "student/update-info/$studentInfoId";

  static Future postRequest({
    required String url,
    required Map<String, String> body,
    List<http.MultipartFile> files = const [],
    Map<String, String>? headers,
  }) async {
    debugPrint(body.toString());
    debugPrint("$_baseURL$url");
    var request = MultipartRequest(
      'POST',
      Uri.parse('$_baseURL$url'),
      onProgress: (int bytes, int total) async {
        final progress = bytes / total;
        log(">>>>>>>>> progress: $progress");
      },
    );

    request.fields.addAll(body);
    for (int i = 0; i < files.length; i++) {
      request.files.add(files[i]);
    }

    request.headers
        .addAll({'Accept': 'application/json', 'Authorization': 'Bearer }'});
    // if (SharedPref.getUserObg() != null) {
    //   request.headers.addAll(
    //       {'Authorization': 'Bearer ${SharedPref.getUserObg()?.accessToken??''}'});
    // }
    if (headers != null) request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    log(response.statusCode.toString());
    // if (response.statusCode == 401) {
    //   Modular.to.pushReplacementNamed(LoginScreen.routeName);
    //   return;
    // }
    log(result.toString());
    try {
      return json.decode(result);
    } catch (e) {
      return null;
    }
  }

  static Future postRequestWithDynamicBody(
      {required Map<String, dynamic> body,
      // Map<String, String>? headers,
      required String url}) async {
    debugPrint(body.toString());
    debugPrint("$_baseURL$url");

    try {
      var response = await Dio().post('$_baseURL$url',
          data: body,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer }'
          }, followRedirects: false));
      log("response in dio = ${response.data.toString()}");
      if (response.statusCode == 200) {
        return jsonDecode(response.toString());
      }

      //  return jsonDecode(response.toString());
    } on DioException catch (e) {
      log("error = $e");
      // if (e.response?.statusCode == 422) {
      //   final errors = e.response?.data['errors'];
      //   print("error = $errors");
      // } else {
      //   print("error = $e");
      // }
    }
  }

  static Future getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    debugPrint('$_baseURL$url');

    var request = http.Request('GET', Uri.parse('$_baseURL$url'));
    request.headers
        .addAll({'Accept': 'application/json', 'Authorization': 'Bearer '});
    if (headers != null) request.headers.addAll(headers);
    // debugPrint(request.headers.toString());

    http.StreamedResponse response = await request.send();

    String result = await response.stream.bytesToString();
    log(response.statusCode.toString());
    if (response.statusCode == 401) {
      //Modular.to.pushReplacementNamed(LoginScreen.routeName);
      return;
    }
    log(result.toString());
    return json.decode(result);
  }

  static Future deleteRequest({
    required String url,
    List<http.MultipartFile> files = const [],
    Map<String, String>? headers,
  }) async {
    debugPrint("$_baseURL$url");
    var request = MultipartRequest(
      'DELETE',
      Uri.parse('$_baseURL$url'),
      onProgress: (int bytes, int total) async {
        final progress = bytes / total;
        log(">>>>>>>>> progress: $progress");
      },
    );
    request.headers.addAll({
      'Accept': 'application/json',
      'lang': SharedPref.getCurrentLang() ?? "en",
    });
    // if (SharedPref.getUserObg() != null) {
    //   request.headers.addAll(
    //       {'Authorization': 'Bearer ${SharedPref.getUserObg()?.accessToken??''}'});
    // }
    if (headers != null) request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    log(response.statusCode.toString());
    // if (response.statusCode == 401) {
    //   Modular.to.pushReplacementNamed(LoginScreen.routeName);
    //   return;
    // }
    log(result.toString());
    try {
      return json.decode(result);
    } catch (e) {
      return null;
    }
  }

  static Future<Uint8List?> getDataFromUrl({
    required String? url,
    Map<String, String>? headers,
  }) async {
    try {
      if (url == null) return null;
      var request = http.Request('GET', Uri.parse(url));
      request.headers
          .addAll({'Accept': 'application/json', 'Authorization': 'Bearer '});
      if (headers != null) request.headers.addAll(headers);
      debugPrint(request.headers.toString());

      http.StreamedResponse response = await request.send();
      return await response.stream.toBytes();
    } catch (e) {
      log(">>>>>>>>>>>>>>>::$e");
      return null;
    }
  }
}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);
  final void Function(int bytes, int totalBytes) onProgress;

  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
