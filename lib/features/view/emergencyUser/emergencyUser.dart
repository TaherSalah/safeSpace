import 'package:flutter/material.dart';
import 'package:safeSpace/features/view/emergencyUser/widget/emergencyViewItemBuilder.dart';

class EmergencyUser extends StatelessWidget {
  const EmergencyUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8E8DB),
      body: SafeArea(child: EmergencyViewItemBuilder()),
    );
  }
}
