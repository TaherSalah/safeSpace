import 'package:flutter/material.dart';

import 'default_text_widget.dart';

class GradientText extends StatelessWidget {
  String title;
  FontWeight fontWeight;
  double fontSize;

   GradientText({Key? key, required this.title, required this.fontWeight, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors:
          [
            Color(0xff42DEBF),
            Color(0xff6CA5C2),
            Color(0xff4876B2),
            Color(0xff315FAA),
          ]
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: TextDefaultWidget(title: title, fontWeight: fontWeight, fontSize: fontSize,)
    );
  }
}
