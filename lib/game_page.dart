import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'playground_model.dart';
import 'token_widget.dart';
import 'package:photo_view/photo_view.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {


  List<double> _left = List();
  List<double> _top = List();
  List<Widget> listViewWidgets = List();
  List<int> equipment = List();
  List<Widget> draggableFlareList = List();
  List<GlobalKey> keys = List();
  List<bool> onScreen = List();
  List<double> offset = List();
  GlobalKey key = GlobalKey();
  GlobalKey listViewBoxKey = GlobalKey();
  ScrollController controller = ScrollController();
  List<FlareControls> flareControls = List();

  @override
  void initState() {
    for (int i = 0; i < playgrounds.length; i++) {
      _left.add(200);
      _top.add(200);
      keys.add(GlobalKey());
      onScreen.add(false);
      offset.add(0);
      flareControls.add(FlareControls());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(playgrounds.length);
    Widget draggableFlare(int i) {
      return Positioned.fromRect(
        rect: Rect.fromLTWH(_left[i], _top[i], playgrounds[i].flare['size'], playgrounds[i].flare['size']),
        child: Draggable(
          data: i,
          child: Container(
              height: playgrounds[i].flare['size'],
              width: playgrounds[i].flare['size'],
              child: GestureDetector(
                onTap: () {
                  flareControls[i]
                      .play(playgrounds[i].flare['animation_ontap']);
                },
                child: FlareActor(
                  playgrounds[i].flare['asset'],
                  controller: flareControls[i],
                  animation: playgrounds[i].flare['running_animation'],
                ),
              )),
          feedback: Container(
              height: playgrounds[i].flare['size'],
              width: playgrounds[i].flare['size'],
              child: FlareActor(playgrounds[i].flare['asset'])),
          childWhenDragging: Container(),
          onDragEnd: (details) {
            RenderBox box = key.currentContext.findRenderObject();
            Offset position = box.localToGlobal(Offset.zero);
            double y = position.dy;

            setState(() {
              _left[i] = details.offset.dx+ controller.offset;
              _top[i] = details.offset.dy - y;
            });
          },
        ),
      );
    }

    getDraggables() {
      draggableFlareList.clear();
      for (int i = 0; i < playgrounds.length; i++) {
        if (onScreen[i]) {
          draggableFlareList.add(draggableFlare(i));
        }
        ;
      }
    }

    getDraggables();
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.topLeft, child: Container(key: key)),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Container(
                  width: 1500,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bitmap.png'),
                      fit: BoxFit.fill,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        height: 100,
                        width: 100,
                        child: FlareActor(
                          'assets/Sunshine.flr',
                          animation: 'sun_rays',
                        ))),
                Container(
                  width: 1500,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: draggableFlareList,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DragTarget(
              onAccept: (candidateData) {
                setState(
                  () {
                    onScreen[candidateData] = false;
                  },
                );
              },
              builder: (context, List<int> candidateData, rejectedData) {
                return Container(
                    key: listViewBoxKey,
                    color: Colors.white,
                    height: 100,
                    child: ListView.builder(
                      itemCount: playgrounds.length,
                      itemBuilder: (context, i) {
                        return
//                          !playgrounds[i].user['visited']? Container():
                        onScreen[i]
                            ? Opacity(
                                opacity: 0.5,
                                child: GestureDetector(onTap:(){
                                  setState(() {
                                    onScreen[i] = false;
                                  });
                                },
                                  child: Container(width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TokenWidget(
                                        i,
                                        100, false,
                                      ),
                                    ),
                                  ),
                                ))
                            : Container(
                                key: keys[i],
                                child: GestureDetector(
                                    onTap: () {
                                      RenderBox box = keys[i]
                                          .currentContext
                                          .findRenderObject();
                                      Offset position =
                                          box.localToGlobal(Offset.zero);
                                      RenderBox box2 =
                                          key.currentContext.findRenderObject();
                                      Offset position2 =
                                          box2.localToGlobal(Offset.zero);

                                      _left[i] =
                                          position.dx + controller.offset;
                                      offset[i] = controller.offset;
                                      _top[i] =
                                          position.dy - position2.dy - playgrounds[i].flare['size'];

                                      setState(() {
                                        onScreen[i] = true;
                                      });
                                    },
                                    child: Container(width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TokenWidget(
                                          i,
                                          100, true,
                                        ),
                                      ),
                                    )),
                              );
                      },
                      scrollDirection: Axis.horizontal,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }



}
