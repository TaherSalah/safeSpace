import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/features/viewModel/chat_controllar.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  ChatBotViewState createState() => ChatBotViewState();
}

class ChatBotViewState extends StateMVC<ChatBotView> {
  late ChatController con;

  ChatBotViewState() : super(ChatController()) {
    con = controller as ChatController;
    ();
    con.initServices(); // ✅ Initialize speech-to-text and TTS on load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPT Chat Bot"),
        leading: BackButton(
          onPressed: () {
            con.dispose();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Lottie.asset(
                'assets/images/Animation - 1741980046803.json',
                width: 150,
                height: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xffFCDDEC),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 35,
                icon: Icon(con.isListening ? Icons.mic : Icons.mic_none,
                    color: con.isListening ? Colors.red : Colors.black),
                onPressed: () {
                  if (con.isListening) {
                    con.stopListening();
                  } else {
                    con.startListening();
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: con.controller,
          //           decoration: const InputDecoration(
          //             hintText: "Speak or type...",
          //             border: OutlineInputBorder(),
          //           ),
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(con.isListening ? Icons.mic : Icons.mic_none,
          //             color: con.isListening ? Colors.red : Colors.black),
          //         onPressed: () {
          //           if (con.isListening) {
          //             con.stopListening();
          //           } else {
          //             con.startListening();
          //           }
          //           setState(() {});
          //         },
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.send, color: Colors.blue),
          //         onPressed: con.sendMessage,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
