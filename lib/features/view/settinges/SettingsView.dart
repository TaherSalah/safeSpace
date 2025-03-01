import 'package:flutter/material.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffaeaff7),
      body: SafeArea(
          child: Column(
        children: [TextDefaultWidget(title: "SettingsView")],
      )),
    );
  }
}
