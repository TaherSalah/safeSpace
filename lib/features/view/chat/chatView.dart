import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/features/viewModel/chat_controllar.dart';

class Chatview extends StatefulWidget {
  const Chatview({super.key});

  @override
  ChatviewState createState() => ChatviewState();
}

class ChatviewState extends StateMVC<Chatview> {
  late ChatController con;

  ChatviewState() : super(ChatController()) {
    con = controller as ChatController;
    ();
    con.initServices(); // ✅ Initialize speech-to-text and TTS on load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPT Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: con.scrollController,
              itemCount: con.messages.length + (con.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == con.messages.length && con.isLoading) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 10),
                          const Text("Typing...",
                              style: TextStyle(fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  );
                }
                var msg = con.messages[index];
                return Align(
                  alignment: msg["role"] == "user"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg["role"] == "user"
                          ? KColors.primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      msg["content"] ?? "",
                      style: TextStyle(
                        color:
                            msg["role"] == "user" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: con.controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(con.isListening ? Icons.mic : Icons.mic_none,
                      color: con.isListening ? Colors.red : Colors.black),
                  onPressed: () {
                    if (con.isListening) {
                      con.stopListening();
                    } else {
                      con.startListening();
                    }
                    setState(() {}); // ✅ Update mic icon
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: KColors.primaryColor,
                  ),
                  onPressed: con.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
