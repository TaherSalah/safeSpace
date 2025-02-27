import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/viewModel/chat_controllar.dart';

class Chatview extends StatefulWidget {
  const Chatview({super.key});

  @override
  State<StatefulWidget> createState() => _ChatViewBuilderState();
}

class _ChatViewBuilderState extends StateMVC<Chatview> {
  /// Let the 'business logic' run in a Controller
  _ChatViewBuilderState() : super(ChatController()) {
    /// Acquire a reference to the passed Controller.
    con = controller as ChatController;
  }
  late ChatController con;

  @override
  void initState() {
    super.initState();
    // Ensure appState is initialized before using it
    if (rootState != null) {
      appState = rootState!;
      var con = appState.controller;
      // Retrieve the correct controller by type or ID
      con = appState.controllerByType<ChatController>();
      con = appState.controllerById(con?.keyId);
    } else {
      // Handle the case where rootState is not initialized
      print('rootState is null');
    }
  }
}

late AppStateMVC appState;

class _ChatviewState extends State<Chatview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(),
    );
  }
}
