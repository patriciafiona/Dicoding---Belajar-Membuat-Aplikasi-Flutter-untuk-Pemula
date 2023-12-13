import 'package:flutter/material.dart';

import 'LottieAnimation.dart';

class NoDataAnimation extends StatelessWidget {
  final double width;
  final double height;
  final Color textColor;

  const NoDataAnimation({
    super.key, required this.width, required this.height, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child:
    Column(
      children: [
        const Spacer(),
        LottieAnimation(animationName: "no_data_animation", width: width, height: height),
        const Spacer(),
        Text(
          "No Income and Outcome Data",
          style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
        const Spacer(),
      ],
    ));
  }
}