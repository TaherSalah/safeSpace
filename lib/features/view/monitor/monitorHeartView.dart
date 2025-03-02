import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';
import 'package:safe_space_app/features/view/home/widget/homeViewItemBuilder.dart';

class MonitorHeartView extends StatelessWidget {
  const MonitorHeartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextDefaultWidget(title: "Monitor Heartbeat Rate"),),
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: HeartRateBuilder(),
      ),
    ));
  }
}



class HeartRateBuilder extends StatefulWidget {
  const HeartRateBuilder({super.key});

  @override
  _HeartRateBuilderState createState() => _HeartRateBuilderState();
}

class _HeartRateBuilderState extends State<HeartRateBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int heartRate = 72;

  @override
  void initState() {
    super.initState();

    // Animation setup for heart pulse
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);

    // Simulate heart rate change
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        heartRate = 70 + (heartRate % 5) + 1; // Simulated heart rate change
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Stack(
                  
                  alignment: Alignment.center,
                  children: [
                    // Heart background glow effect
                    for (double i = 0.6; i <= 1.2; i += 0.2)
                      Opacity(
                        opacity: 1 - (i - 0.6),
                        child: Container(
                          width: 120 * i,
                          height: 120 * i,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(0.2),
                          ),
                        ),
                      ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 80,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            "$heartRate",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            "beats per minute",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

