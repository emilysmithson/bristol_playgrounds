import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'playground_model.dart';

class TokenWidget extends StatelessWidget {
   double size;
  int i;
  bool buttonUp;
  TokenWidget(this.i, this.size, this.buttonUp);

  @override
  Widget build(BuildContext context) {

    if (i == 100) {
      return Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            Center(
                child: Container(
                    width: size,
                    height: size,
                    child: Image.asset(buttonUp
                        ? 'assets/button.png'
                        : 'assets/button_pressed.png'))),
          ],
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        child: ClipOval(
          child: Stack(
            children: [
              Container(
                  width: size,
                  height: size,
                  child: Image.asset('assets/sky.png', fit: BoxFit.fill)),
              Center(
                child: Container(width: size*0.7, height: size*0.7,
                  child: FlareActor(playgrounds[i].flare['asset']),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: size,
//      height: size,
//      child: Stack(
//        children: [
//          Center(
//              child: Container(
//                  width: size,
//                  height: size,
//                  child: Image.asset(buttonUp
//                      ? 'assets/button.png'
//                      : 'assets/button_pressed.png'))),
//          Center(
//              child: Padding(
//            padding: EdgeInsets.only(
//                top: buttonUp ? 0 : size/10, left: buttonUp ? 0 : size/10),
//            child: Container(
//                width: size / 2,
//                height: size / 2,
//                child: i==100?Image.asset('assets/questionmark.png'):FlareActor(playgrounds[i].flare['asset'])),
//          )),
//        ],
//      ),
//    );
//  }
//}
