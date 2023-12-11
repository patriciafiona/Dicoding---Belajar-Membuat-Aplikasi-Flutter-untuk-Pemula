import 'package:financial_app/ui/screen/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const MainScreen()));
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScalableAppIcon()
      ),
    );
  }
}

class ScalableAppIcon extends StatefulWidget {
  const ScalableAppIcon({super.key});

  @override
  State<ScalableAppIcon> createState() => _ScalableAppIconState();
}

class _ScalableAppIconState extends State<ScalableAppIcon> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: SizedBox(
        width: 400.0,
        height: 400.0,
        child: Image.asset("assets/image/finance_logo.png")
      ),
    );
  }
}

