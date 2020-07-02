import 'package:flutter/material.dart';
import 'token_widget.dart';
import 'playground_model.dart';

class PlaygroundCheck extends StatefulWidget {
  int i;
  PlaygroundCheck(this.i);
  @override
  _PlaygroundCheckState createState() => _PlaygroundCheckState();
}

class _PlaygroundCheckState extends State<PlaygroundCheck>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void dispose() {
controller.dispose();
super.dispose();
  }

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0.2, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: animation.value, child: TokenWidget(widget.i, 300, false));
  }
}
