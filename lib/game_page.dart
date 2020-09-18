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
  List<double> _scale = List();
  List<double> _baseScaleFactor = List();

  @override
  void initState() {
    for (int i = 0; i < playgrounds.length; i++) {
      _left.add(playgrounds[i].flare['left']);
      _top.add(playgrounds[i].flare['top']);
      _scale.add(playgrounds[i].flare['scale']==null? 1:playgrounds[i].flare['scale'] );

      _baseScaleFactor.add(1.0);
      keys.add(GlobalKey());
      onScreen.add(playgrounds[i].flare['on_screen'] == null
          ? false
          : playgrounds[i].flare['on_screen']);
      offset.add(0);
      flareControls.add(FlareControls());
    }

    super.initState();
  }

  _updateGameLocation(
      int i, double left, double top, double scale, bool onscreen) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.updateGameLocation(i, left, top, scale, onscreen);
  }

  @override
  Widget build(BuildContext context) {
int _numberOfPrizes = countNumberOfPrizes();
    Widget draggableFlare(int i) {
      return Positioned.fromRect(
        rect: Rect.fromLTWH(
            _left[i],
            _top[i],
            playgrounds[i].flare['size'] * _scale[i],
            playgrounds[i].flare['size'] * _scale[i]),
        child: Container(
            height: playgrounds[i].flare['size'] * _scale[i],
            width: playgrounds[i].flare['size'] * _scale[i],
            child: GestureDetector(
              onTap: () {
                flareControls[i].play(playgrounds[i].flare['animation_ontap']);
              },
              onScaleStart: (details) {
                _baseScaleFactor[i] = _scale[i];
              },
              onScaleUpdate: (details) {
                RenderBox box = key.currentContext.findRenderObject();
                Offset position = box.localToGlobal(Offset.zero);
                double y = position.dy;
                setState(() {
                  _left[i] = details.focalPoint.dx +
                      controller.offset -
                      playgrounds[i].flare['size'] * _scale[i] / 2;
                  _top[i] = details.focalPoint.dy -
                      y -
                      playgrounds[i].flare['size'] * _scale[i] / 2;
                  _updateGameLocation(i, _left[i], _top[i], _scale[i], true);
                });

                double _scaleFactor_temp = _baseScaleFactor[i] * details.scale;
                if (_scaleFactor_temp > 2.5) {
                  setState(() {
                    _scale[i] = 2.5;
                  });
                } else if (_scaleFactor_temp < 0.75) {
                  setState(() {
                    _scale[i] = 0.75;
                  });
                } else {
                  setState(() {
                    _scale[i] = _baseScaleFactor[i] * details.scale;
                  });
                }
                _updateGameLocation(i, _left[i], _top[i], _scale[i], true);
              },
              child:

              FlareActor(
                playgrounds[i].flare['asset'],
                controller: flareControls[i],
                animation: playgrounds[i].flare['running_animation'],
              ),
            )),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(250, 0, 155, 205),
          child: Icon(Icons.autorenew),
          onPressed: () {
            for (int i = 0; i < playgrounds.length; i++) {
              _updateGameLocation(i, _left[i], _top[i], _scale[i], false);
              onScreen[i] = false;
            }
            setState(() {});
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          Align(alignment: Alignment.topLeft, child: Container(key: key)),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Container(
                  width: 2000,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
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
                  width: 2000,
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
                return _numberOfPrizes ==0? Container(height: 100, child: Center(child: Text('Tap the button at the top to earn prizes'))): Container(
                    key: listViewBoxKey,
                    color: Colors.white,
                    height: 100,
                    child: ListView.builder(
                      itemCount: playgrounds.length,
                      itemBuilder: (context, i) {
                        return
                       !playgrounds[i].user['visited']? Container():
                            onScreen[i]
                                ? Opacity(
                                    opacity: 0.5,
                                    child: GestureDetector(
                                      onTap: () {
                                        _updateGameLocation(i, _left[i],
                                            _top[i], _scale[i], false);
                                        setState(() {
                                          onScreen[i] = false;
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: TokenWidget(
                                            i,
                                            100,
                                            false,
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
                                          RenderBox box2 = key.currentContext
                                              .findRenderObject();
                                          Offset position2 =
                                              box2.localToGlobal(Offset.zero);

                                          _left[i] =
                                              position.dx + controller.offset;
                                          offset[i] = controller.offset;
                                          _top[i] = position.dy -
                                              position2.dy -
                                              playgrounds[i].flare['size'];
                                          _updateGameLocation(
                                              i, _left[i], _top[i], 1, true);
                                          setState(() {
                                            onScreen[i] = true;
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TokenWidget(
                                              i,
                                              100,
                                              true,
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
