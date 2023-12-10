import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final String animationName;
  final double width;
  final double height;

  const LottieAnimation({super.key, required this.animationName, required this.width, required this.height});

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/${widget.animationName}.json',
      width: widget.width,
      height: widget.height,
      fit: BoxFit.fill,
    );
  }
}
