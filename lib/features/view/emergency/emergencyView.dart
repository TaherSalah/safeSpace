import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/fcm_handler.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/custom_button_widget.dart';
import 'package:safeSpace/core/Widgets/custom_textfeild_widget.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModel/main_coontrollar.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  EmergencyViewState createState() => EmergencyViewState();
}

class EmergencyViewState extends StateMVC<EmergencyView> {
  late HomeController con;
  String? savedEmail; // متغير لتخزين الإيميل المُدخل بعد الحفظ

  EmergencyViewState() : super(HomeController()) {
    con = controller as HomeController;
    ();
    con.fetchData();
    con.fetchEmail();
  }
  @override
  void initState() {
    super.initState();
    _loadSavedEmail(); // Load saved email when the widget initializes
  }

  // Function to load saved email from SharedPreferences
  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedEmail = prefs.getString("saveEmail"); // Retrieve saved email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7E8DA),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();

                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: MediaQuery.sizeOf(context).width > 600
                            ? MediaQuery.sizeOf(context).height / 2
                            : MediaQuery.sizeOf(context).height / 1.5,
                        child: Form(
                          key: con.key,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomTextFieldWidget(
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return "Please enter your email";
                                    } else if (!val.contains('@')) {
                                      return "Please enter a valid email address";
                                    } else {
                                      return null;
                                    }
                                  },
                                  backGroundColor: Theme.of(context).cardColor,
                                  label: "Email",
                                  controller: con.emailController,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    size: 14.sp,
                                  ),
                                  hint: "Enter your email",
                                  borderRadiusValue: 15,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: CustomButton(
                                  verticalPadding: 12.h,
                                  borderColor: Color(0xffFBA2AB),
                                  radius: 9.r,
                                  title: "Add New Friend",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  backgroundColor: Color(0xffFBA2AB),
                                  onTap: () async {
                                    if (con.key.currentState!.validate()) {
                                      FirebaseFirestore fire =
                                          FirebaseFirestore.instance;
                                      String targetEmail = con.emailController
                                          .text; // Target user email
                                      try {
                                        // Fetch the user document based on email
                                        DocumentSnapshot userDoc = await fire
                                            .collection("users")
                                            .doc(targetEmail)
                                            .get();

                                        if (userDoc.exists) {
                                          Map<String, dynamic>? userData =
                                              userDoc.data()
                                                  as Map<String, dynamic>?;

                                          if (userData != null &&
                                              userData.containsKey("token") &&
                                              userData.containsKey("userId")) {
                                            String fcmToken = userData["token"];
                                            String userId = userData["userId"];
                                            // Send notification dynamically
                                            NotificationsHelper()
                                                .sendNotifications(
                                              fcmToken:
                                                  fcmToken, // Dynamic FCM Token
                                              title: "User Notification",
                                              body: "User need to help Now",
                                              userId: userId, // Dynamic User ID
                                            );

                                            setState(() {
                                              savedEmail = targetEmail;
                                              prefs.setString(
                                                  "saveEmail", targetEmail);
                                            });
                                            if (savedEmail != targetEmail) {
                                              prefs.clear();
                                              setState(() {});
                                            }
                                            Navigator.pop(context);
                                          } else {
                                            print(
                                                "Error: Required fields (token/userId) are missing in Firestore.");
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          ToastHelper.showError(
                                              message: "Email Not Found");
                                          print(
                                              "Error: User document does not exist in Firestore.");
                                          Navigator.pop(context);
                                        }
                                      } catch (e) {
                                        print("Error retrieving user data: $e");
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: 35.h,
                      child: Image.asset("assets/images/User plus.png"),
                    ),
                  ),
                ),
                CardItemBuilderWidget(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(friendEmail: savedEmail ?? ""),
                          ));
                    },
                    title:
                        "Contact with ${savedEmail?.substring(0, savedEmail?.indexOf("@"))}",
                    iconPath: "assets/images/Message circle.png"),
                CardItemBuilderWidget(
                    onTap: () async {
                      await con.launchURL(
                          latitude: con.latitude, longitude: con.longitude);
                    },
                    title: "Breathing techniques",
                    iconPath: "assets/images/location_on@2x.png"),
              ],
            ),
          ),
        ));
  }
}

Future<void> sendMessage(
    String senderEmail, String receiverEmail, String message) async {
  String chatId =
      generateChatId(senderEmail, receiverEmail); // توليد معرف المحادثة

  final chatMessage = ChatMessage(
    senderId: senderEmail,
    receiverId: receiverEmail,
    text: message,
    timestamp: Timestamp.now(),
  );

  await FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .add(chatMessage.toMap());
}

// دالة توليد معرف المحادثة بناءً على البريد الإلكتروني للطرفين
String generateChatId(String email1, String email2) {
  List<String> emails = [email1, email2];
  emails.sort(); // ترتيب لمنع تكرار الشات بأسماء مختلفة
  return emails.join("_");
}

class ChatScreen extends StatefulWidget {
  String? friendEmail;

  ChatScreen({super.key, required this.friendEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();

  String getChatId(String? userEmail, String? friendEmail) {
    List<String> emails = [userEmail!, friendEmail!];
    emails.sort(); // ترتيب الإيميلات لضمان نفس الـ chatId للطرفين
    return emails.join('_'); // مثل: "sos@gmail.com_user@gmail.com"
  }

  @override
  void initState() {
    super.initState();
    // تحديد البريد الإلكتروني للصديق تلقائيًا
    String userEmail = _auth.currentUser?.email ?? "";
    if (userEmail == "user@gmail.com") {
      widget.friendEmail = widget.friendEmail;
    } else {
      widget.friendEmail = "user@gmail.com";
    }
  }

  void sendMessage(String text) {
    String? userEmail = _auth.currentUser?.email ?? "";
    String? chatId = getChatId(userEmail, widget.friendEmail);

    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'sender': userEmail,
      'receiver': widget.friendEmail,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with ${widget.friendEmail}")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(getChatId(_auth.currentUser!.email!, widget.friendEmail))
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data!.docs[index];
                    return Align(
                      alignment: message['sender'] == _auth.currentUser!.email
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message['sender'] == _auth.currentUser!.email
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                              color:
                                  message['sender'] == _auth.currentUser!.email
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: "اكتب رسالة..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.trim().isNotEmpty) {
                      sendMessage(messageController.text.trim());
                      messageController.clear(); // مسح حقل الإدخال بعد الإرسال
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
