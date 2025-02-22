import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientAssetWidget extends StatelessWidget {

  final String image;
 final double? width, height;

  const GradientAssetWidget({Key? key,  this.width,  this.height,  required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
              colors:
              [
                Color(0xff26cbff),
                Color(0xff6980fd),
              ]
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: SvgPicture.asset(image, width: width, height: height,)
    );
  }
}
