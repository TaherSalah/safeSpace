import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/features/view/contactUser/emergencyView.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../viewModel/main_coontrollar.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  EmergencyViewState createState() => EmergencyViewState();
}

class EmergencyViewState extends StateMVC<EmergencyView> {
  late HomeController con;

  EmergencyViewState() : super(HomeController()) {
    con = controller as HomeController;
    ();
    con.fetchData();
  }

  @override
  Widget build(BuildContext context) {

    String url({required String longitude, latitude}) =>
        //       //  طول//
        "https://www.google.com/maps/place/$latitude,$longitude";
    Future<void> launchURL({dynamic latitude, longitude}) async {
      Uri uri = Uri.parse(url(longitude: "$longitude", latitude: "$latitude"));
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw "Could not launch $url";
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: Image.asset("assets/images/menu.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 35.h,
                child: Image.asset("assets/images/User plus.png"),
              ),
            ),
            CardItemBuilderWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>       ChatScreen(friendEmail: con.auth.currentUser?.email??""),
                      ));
                },
                title: "Contact with Taher Salah",
                iconPath: "assets/images/Message circle.png"),
            CardItemBuilderWidget(
                onTap: () async {
                  await launchURL(
                      latitude: con.latitude, longitude: con.longitude);
                  print(con.latitude);
                  print(con.longitude);
                },
                title: "Breathing techniques",
                iconPath: "assets/images/location_on@2x.png"),
          ],
        ),
      ),
    ));
  }
}


Future<void> sendMessage(String senderEmail, String receiverEmail, String message) async {
  String chatId = generateChatId(senderEmail, receiverEmail); // توليد معرف المحادثة

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
      widget.friendEmail = "sos@gmail.com";
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
                  return Center(child: Text("لا توجد رسائل بعد"));
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
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message['sender'] == _auth.currentUser!.email
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(color: message['sender'] == _auth.currentUser!.email ? Colors.white : Colors.black),
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
                IconButton(icon: Icon(Icons.send), onPressed: () {
                  if (messageController.text.trim().isNotEmpty) {
                    sendMessage(messageController.text.trim());
                    messageController.clear(); // مسح حقل الإدخال بعد الإرسال
                  }
                },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



