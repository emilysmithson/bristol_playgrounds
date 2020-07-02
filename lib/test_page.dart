import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flare_flutter/flare_actor.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: Stack(
      children: [
        GestureDetector(onTap: (){print('tapped');},
          onScaleEnd: (scale){setState(() {
            print(scale);

          });},
          child: Draggable(
              feedback:  Transform.scale(scale: scale, child: Container(height: 100, width: 100, child: FlareActor('assets/blaise_castle.flr'))),
              child: Transform.scale(scale: scale, child: Container(height: 100, width: 100, child: FlareActor('assets/blaise_castle.flr'))),
            ),
        ),
      ],
    ),
    );
  }
}
