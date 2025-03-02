import 'package:flutter/material.dart';
import 'package:safe_space_app/features/view/emergencyUser/widget/emergencyViewItemBuilder.dart';

class EmergencyUser extends StatelessWidget {
  const EmergencyUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: EmergencyViewItemBuilder()),
    );
  }
}
