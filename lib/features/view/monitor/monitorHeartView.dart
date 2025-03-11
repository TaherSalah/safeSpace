import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';

// class HeartRateViewBuilder extends StatefulWidget {
//   const HeartRateViewBuilder({super.key, required this.heartRate});
//
//   final int heartRate;
//
//   @override
//   _HeartRateViewBuilderState createState() => _HeartRateViewBuilderState();
// }
//
// class _HeartRateViewBuilderState extends State<HeartRateViewBuilder>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Animation setup for heart pulse
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     )..repeat(reverse: true);
//
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
//
//     // Simulate heart rate change
//     Timer.periodic(Duration(seconds: 3), (timer) {
//       setState(() {
//         //  heartRate = 70 + (heartRate % 5) + 1; // Simulated heart rate change
//         widget.heartRate;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextDefaultWidget(title: "Heart Rate"),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Heart background glow effect
//                         for (double i = 0.6; i <= 1.2; i += 0.2)
//                           Opacity(
//                             opacity: 1 - (i - 0.6),
//                             child: Container(
//                               width: 120 * i,
//                               height: 120 * i,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.red.withOpacity(0.2),
//                               ),
//                             ),
//                           ),
//                         Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                           size: 80,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               TextDefaultWidget(
//                   title: "${widget.heartRate}",
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold),
//               TextDefaultWidget(
//                   title: "beats per minute",
//                   fontSize: 18.sp,
//                   color: Colors.grey),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';

class HeartRateViewBuilder extends StatefulWidget {
  const HeartRateViewBuilder({super.key, required this.heartRate});

  final int heartRate;

  @override
  _HeartRateViewBuilderState createState() => _HeartRateViewBuilderState();
}

class _HeartRateViewBuilderState extends State<HeartRateViewBuilder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late ValueNotifier<int> heartRateNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize heart rate notifier with initial value
    heartRateNotifier = ValueNotifier<int>(widget.heartRate);

    // Animation setup for heart pulse
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);

    // Simulate real-time heart rate updates
    Timer.periodic(const Duration(seconds: 3), (timer) {
      heartRateNotifier.value = 60 + (DateTime.now().second % 40); // Random simulation
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    heartRateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Heart Rate")),
      body: SafeArea(
        child: Center(
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
                        const Icon(Icons.favorite, color: Colors.red, size: 80),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Listen to heart rate changes and update UI in real-time
              ValueListenableBuilder<int>(
                valueListenable: heartRateNotifier,
                builder: (context, heartRate, child) {
                  return TextDefaultWidget(
                    title: "$heartRate",
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  );
                },
              ),

              TextDefaultWidget(
                title: "beats per minute",
                fontSize: 18.sp,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
