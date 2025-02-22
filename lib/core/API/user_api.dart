// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:schoopedia_app/Models/user_model.dart';
// import 'package:schoopedia_app/Modules/UserAuth/Authentication/login_screen.dart';
// import 'package:schoopedia_app/Shared/shared_preferances.dart';
// import 'package:schoopedia_app/Utilities/Layout/helper.dart';
// import 'package:schoopedia_app/Utilities/toast_helper.dart';
// import 'package:schoopedia_app/models/user_grade.dart';
//
// import 'api.dart';
//
// class UserApi
// {
//   static Future<bool> login({required String email,required String password})
//   async
//   {
//     var response = await API.postRequest(
//     url: API.login,
//     body: {
//     "email" :email,
//     "password":password,
//     });
//
//     if(response["status"] == true)
//       {
//         User user = User.fromJson(response["data"]);
//          SharedPref.saveUserObj(user: user);
//
//
//         return true;
//       }
//     else
//       {
//         ToastHelper.showError(message: response["message"]);
//         return false;
//       }
//   }
//
//   static Future<bool> loginWithFacebook({required String name, required String email, required String facebookId, required String image})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.loginWithFacebook,
//         body: {
//           "name": name,
//           "email": email,
//           "facebook_id": facebookId,
//           "image": image,
//      });
//
//     if(response['status'] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       SharedPref.saveUserObj(user: User.fromJson(response['data']));
//       return true;
//     }
//
//     else
//     {
//       ToastHelper.showError(message: response['message']);
//       return false;
//     }
//   }
//
//   static Future<bool> loginWithGmail({required String name, required String email, required String googleId, required String image})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.loginWithGmail,
//         body: {
//       "name": name,
//       "email": email,
//       "google_id": googleId,
//       "image": image,
//     });
//
//     if(response['status'] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//        SharedPref.saveUserObj(user: User.fromJson(response['data']));
//       return true;
//     }
//
//     else
//     {
//       ToastHelper.showError(message: response['message']);
//       return false;
//     }
//   }
//
//   static Future<bool> loginWithApple({required String name, required String email, required String appleId, required String image})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.loginWithFacebook,
//         body: {
//       "name": name,
//       "email": email,
//       "apple_id": appleId,
//       "image": image,
//     });
//
//     if(response['status'] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       SharedPref.saveUserObj(user: User.fromJson(response['data']));
//       return true;
//     }
//
//     else
//     {
//       ToastHelper.showError(message: response['message']);
//       return false;
//     }
//   }
//
//   static Future<bool> logout({required BuildContext context}) async {
//    var response = await API.postRequest(
//      url: API.logout,
//      body: {},
//    );
//
//     if(response['status'] == true)
//       {
//         SharedPref.logOut();
//         ToastHelper.showSuccess(message: response['message']);
//         return true;
//       }
//
//     else
//       {
//         if(response['message'] == "Unauthenticated.")
//           {
//             Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//           }
//         else
//           {
//             ToastHelper.showError(message: response['message']);
//           }
//         return false;
//       }
//
//   }
//
//   static Future<bool> register({required String name,required String email,
//     required String password,required String confirmPassword})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.register,
//         body: {
//           "name" :name,
//           "email":email,
//           "password":password,
//           "password_confirmation":confirmPassword,
//         });
//
//     if(response["status"] == true)
//     {
//       //ToastHelper.showSuccess(message: response['message']);
//       return response["status"];
//     }
//     else
//     {
//       ToastHelper.showError(message: response['message']);
//       return response["status"];
//     }
//   }
//
//
//   // static Future<bool> updateProfile({required String name,required String email,File? selectedImage,
//   //   required String phone, required User user})
//   // async
//   // {
//   //   Uint8List imagebytes;
//   //   String imageBase64 = "";
//   //   if(selectedImage != null)
//   //     {
//   //       imagebytes = await selectedImage.readAsBytes();
//   //       imageBase64 = base64.encode(imagebytes);
//   //     }//convert to bytes
//   //
//   //   var response = await API.postRequest(
//   //       url: API.updateProfile,
//   //       headers: {
//   //         "Accept":"application/json",
//   //         "Authorization":'Bearer ${user.token}'
//   //       },
//   //       body: {
//   //         "name" :name.isEmpty ? user.name : name,
//   //         "email":email.isEmpty ? user.email : email,
//   //         "phone":phone.isEmpty ?  user.phone.isEmpty ? "": user.phone: phone,
//   //         "image": selectedImage != null ? "data:image/jpeg;base64,$imageBase64" : user.image,
//   //       });
//   //
//   //   if(response["status"] == true)
//   //   {
//   //      user.name = response['data']['name'];
//   //      user.email = response['data']['email'];
//   //      user.phone = response['data']['phone'];
//   //      user.image = response['data']['image'];
//   //
//   //      SharedPref.saveUserObj(user: user);
//   //
//   //     return response["status"];
//   //   }
//   //   else
//   //   {
//   //     ToastHelper.showError(message: response['message']);
//   //     return response["status"];
//   //   }
//   // }
//
//
//   static Future<bool> updateProfileWithProfileImage({required String name,required String email,required File selectedImage,required BuildContext context,
//     required String phone, required User user})
//   async
//   {
//
//     Uint8List imagebytes = await selectedImage.readAsBytes();
//     String imageBase64  = base64.encode(imagebytes);
//
//
//     var response = await API.postRequest(
//         url: API.updateProfile,
//         body: {
//           "name" :name.isEmpty ? user.name : name,
//           "email":email.isEmpty ? user.email : email,
//           "phone":phone.isEmpty ?  user.phone.isEmpty ? "": user.phone: phone,
//           "image": "data:image/jpeg;base64,$imageBase64",
//         });
//
//     if(response["status"] == true)
//     {
//       user.name = response['data']['name'] ??"";
//       user.email = response['data']['email'] ?? "";
//       user.phone = response['data']['phone'] ?? "";
//       user.image = response['data']['image'];
//
//       SharedPref.saveUserObj(user: user);
//
//       ToastHelper.showSuccess(message: "edit_profile_done".tr);
//       return response["status"];
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return response["status"];
//     }
//   }
//
//
//   static Future<bool> updateProfileWithoutProfileImage({required String name,required String email, required BuildContext context,
//     required String phone, required User user})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.updateProfile,
//         body: {
//           "name" :name.isEmpty ? user.name : name,
//           "email":email.isEmpty ? user.email : email,
//           "phone":phone.isEmpty ? user.phone: phone,
//         });
//
//     if(response["status"] == true)
//     {
//       user.name = response['data']['name'];
//       user.email = response['data']['email'];
//       user.phone = response['data']['phone'] ?? "";
//       user.image = response['data']['image'];
//
//       SharedPref.saveUserObj(user: user);
//
//       ToastHelper.showSuccess(message: "edit_profile_done".tr);
//
//       return response["status"];
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return response["status"];
//     }
//   }
//
//   static Future<bool> activateAccount({required String email,required String activationCode, required BuildContext context})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.activateAccount,
//         body: {
//           "email" :email,
//           "active_code":activationCode,
//         });
//
//     if(response["status"] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return response["status"];
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return response["status"];
//     }
//   }
//
//   static Future<bool> resendActivationCode({required String email})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.resendActivationCode,
//         body: {
//           "email" :email,
//         });
//
//     if(response["status"] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return response["status"];
//     }
//     else
//     {
//       ToastHelper.showError(message: response['message']);
//       return response["status"];
//     }
//   }
//
//   static Future<bool> sendOtpForForgotPassword({required String email, required BuildContext context})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.forgetPassword,
//         body: {
//           "email" :email,
//         });
//
//     if(response["status"] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return response["status"];
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return response["status"];
//     }
//   }
//
//   static Future<bool> checkForgetPasswordCode({required String email,required String forgotCode, required BuildContext context})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.checkForgetPasswordCode,
//         body: {
//           "email" :email,
//           "forget_code":forgotCode,
//         });
//
//     if(response["status"] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return response["status"];
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return response["status"];
//     }
//   }
//
//   static Future<bool> changePassword({required String email,required String newPassword, required BuildContext context})
//   async
//   {
//     var response = await API.postRequest(
//         url: API.changePassword,
//         body: {
//           "email" :email,
//           "new_password":newPassword,
//         });
//
//     if(response["status"] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return true;
//     }
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return false;
//     }
//   }
//
//   static Future<bool> deleteAccount({required BuildContext context}) async {
//     var response = await API.deleteRequest(
//       url: API.deleteAccount
//     );
//
//     if(response['status'] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return true;
//     }
//
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return false;
//     }
//
//   }
//
//   static Future<bool> contactUs({required String title,required String description, required BuildContext context}) async {
//     var response = await API.postRequest(
//       url: API.contactUs, body: {
//         "title": title,
//         "description": description
//     },
//     );
//
//     if(response['status'] == true)
//     {
//       ToastHelper.showSuccess(message: response['message']);
//       return true;
//     }
//
//     else
//     {
//       if(response["message"] == "Unauthenticated.")
//       {
//         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(Route<dynamic> route) => false);
//       }
//       else
//       {
//         ToastHelper.showError(message: response["message"]);
//       }
//       return false;
//     }
//
//   }
// }
