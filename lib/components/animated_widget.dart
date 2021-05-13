import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
    new AnimationController(vsync: this, duration: Duration(seconds: 7))
      ..repeat(reverse: true);
    super.initState();
  }

  double chair1Opacity = 1;
  double chair2Opacity = 1;
  double chair3Opacity = 1;

  double getChair1Opacity() {
    if (controller.value <= 0.66)
      return 0;
    else if (controller.value >= 0.66 && controller.value <= 1) {
      double op = (controller.value - 0.66) * 3;
      if (op > 1)
        return 1;
      else
        return op;
    } else
      return 1;
  }

  double getChair2Opacity() {
    if (controller.value <= 0.33)
      return 0;
    else if (controller.value >= 0.33 && controller.value <= 0.66)
      return (controller.value - 0.33) * 3;
    else
      return 1;
  }

  double getChair3Opacity() {
    if (controller.value <= 0.33)
      return controller.value * 3;
    else
      return 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width * 0.28,
      width: _width * 0.28,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/fm1.png",
          ),
          Animated(
            assetName: "assets/images/fm4.png",
            controller: controller,
            getChairOpacity: getChair3Opacity,
          ),
          Animated(
            assetName: "assets/images/fm2.png",
            controller: controller,
            getChairOpacity: getChair2Opacity,
          ),
          Animated(
            assetName: "assets/images/fm3.png",
            controller: controller,
            getChairOpacity: getChair1Opacity,
          )
        ],
      ),
    );
  }
}

class Animated extends StatelessWidget {
  final String assetName;
  final AnimationController controller;
  final Function getChairOpacity;

  Animated({this.assetName, this.controller, this.getChairOpacity});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: getChairOpacity(),
          child: child,
        );
      },
      child: Image.asset(assetName),
    );
  }
}