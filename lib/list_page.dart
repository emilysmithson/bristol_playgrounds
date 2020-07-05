import 'package:flutter/material.dart';
import 'playground_model.dart';
import 'my_flutter_app_icons.dart';
import 'playground_information_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'token_widget.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _showFavourites = false;
  bool _filterToilet = false;
  bool _filterCafe = false;
  bool _filterSandpit = false;
  bool _filterWaterplay = false;
  bool _filterDuckpond = false;
  List<Widget> playgroundList = List<Widget>();
  bool _sortAtoZ = false;
  bool _sortNearest = false;

  void _addPlaygroundCard(int i) {
    playgrounds[i].playground? playgroundList.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaygroundInformationPage(i)),
          );
        },
        child: Container(
          height: 150,
          child: Card(elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TokenWidget(i,80, false),
                  Container(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          playgrounds[i].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(playgrounds[i].location),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            playgrounds[i].features['cafe']
                                ? Icon(Icons.local_cafe)
                                : Container(),
                            playgrounds[i].features['toilet']
                                ? Icon(Icons.wc)
                                : Container(),
                            playgrounds[i].features['duckpond']
                                ? Icon(MyFlutterApp.duck)
                                : Container(),
                            playgrounds[i].features['sandpit']
                                ? Icon(MyFlutterApp.sandpit)
                                : Container(),
                            playgrounds[i].features['waterplay']
                                ? Icon(MyFlutterApp.waterplay)
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            playgrounds[i].user['favourite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: playgrounds[i].user['favourite'] ? Colors.red : Colors.black,
                          ),
                          onPressed: () async{
                            DatabaseHelper helper = DatabaseHelper.instance;
                            helper.updateFavouritesOrVisited(i, true);
                            setState(()  {

                              _createPlaygroundCards();
                            });
                          }),
                      Text(playgrounds[i].distance.toStringAsFixed(1) + 'km'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ):null;
  }

  void _sortPlaygroundCards(bool distance) {
    distance
        ? playgrounds.sort((a, b) => a.distance.compareTo(b.distance))
        : playgrounds.sort((a, b) => a.name.compareTo(b.name));
  }

  void _createPlaygroundCards() {
    playgroundList.clear();
    for (int i = 0; i < playgrounds.length; i++) {
      if(playgrounds[i].playground){
        if ((_showFavourites && playgrounds[i].user['favourite']) ||
            !_showFavourites &&
                ((_filterCafe && playgrounds[i].features['cafe']) ||
                    !_filterCafe) &&
                ((_filterSandpit && playgrounds[i].features['sandpit']) ||
                    !_filterSandpit) &&
                ((_filterToilet && playgrounds[i].features['toilet']) ||
                    !_filterToilet) &&
                ((_filterWaterplay && playgrounds[i].features['waterplay']) ||
                    !_filterWaterplay) &&
                ((_filterDuckpond && playgrounds[i].features['duckpond']) ||
                    !_filterDuckpond)) {
          _addPlaygroundCard(i);
        }}

    }
    setState(() {

    });
  }

  @override
  void initState() {
    getDistance();
    _createPlaygroundCards();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: <Widget>[DropdownButton<String>(
          hint: Text(
            'Sort by',
            style: TextStyle(color: Colors.white),
          ),
          items: [
            DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Text('Distance'),
                  SizedBox(width: 10),
                  _sortNearest ? Icon(Icons.check) : Container()
                ],
              ),
              value: 'Distance',
            ),
            DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Text('A to Z'),
                  SizedBox(width: 10),
                  _sortAtoZ ? Icon(Icons.check) : Container()
                ],
              ),
              value: 'A to Z',
            ),
          ],
          onChanged: (value) {
            if (value == 'Distance') {
              _sortPlaygroundCards(true);
            } else {
              _sortPlaygroundCards(false);
            }
            setState(() {
              _createPlaygroundCards();
            });
          },
        ),
          SizedBox(width: 20),
          DropdownButton<String>(
            items: [ DropdownMenuItem(
              child: Row(
                children: <Widget>[


                  Text('Clear all filters'),
                ],
              ),
              value: 'Clear all filters',
            ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.wc),
                    SizedBox(width: 10),
                    Text('Toilet'),
                    SizedBox(width: 10),
                    _filterToilet ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Toilet',
              ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_cafe),
                    SizedBox(width: 10),
                    Text('Cafe'),
                    SizedBox(width: 10),
                    _filterCafe ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Cafe',
              ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(MyFlutterApp.duck),
                    SizedBox(width: 10),
                    Text('Duckpond'),
                    SizedBox(width: 10),
                    _filterDuckpond ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Duckpond',
              ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(MyFlutterApp.sandpit),
                    SizedBox(width: 10),
                    Text('Sandpit'),
                    SizedBox(width: 10),
                    _filterSandpit ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Sandpit',
              ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(MyFlutterApp.waterplay),
                    SizedBox(width: 10),
                    Text('Waterplay'),
                    SizedBox(width: 10),
                    _filterWaterplay ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Waterplay',
              ),
            ],
            hint: Text(
              'Filter by: ',
              style: TextStyle(color: Colors.white),
            ),
            onChanged: (String value) {
              switch (value) {
                case 'Clear all filters':
                  setState(() {
                    _filterWaterplay = false;
                    _filterSandpit = false;
                    _filterDuckpond = false;
                    _filterCafe = false;
                    _filterToilet = false;
                    _createPlaygroundCards();
                  });
                  break;
                case 'Toilet':
                  setState(() {
                    _filterToilet = !_filterToilet;
                    _createPlaygroundCards();
                  });
                  break;
                case 'Cafe':
                  setState(() {
                    _filterCafe = !_filterCafe;
                    _createPlaygroundCards();
                  });
                  break;
                case 'Sandpit':
                  setState(() {
                    _filterSandpit = !_filterSandpit;
                    _createPlaygroundCards();
                  });
                  break;
                case 'Duckpond':
                  setState(() {
                    _filterDuckpond = !_filterDuckpond;
                    _createPlaygroundCards();
                  });
                  break;
                case 'Waterplay':
                  setState(() {
                    _filterWaterplay = !_filterWaterplay;
                    _createPlaygroundCards();
                  });
                  break;
              }
            },
          ),

          IconButton(
              icon: Icon(
                _showFavourites ? Icons.favorite : Icons.favorite_border,
                color: _showFavourites ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _showFavourites = !_showFavourites;
                  _createPlaygroundCards();
                });
              }),
        ],
      ),
      body: playgroundList.length==0? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('You haven\'t chosen any favourites yet'),
            Text('\nTap the heart icon next to any playground to favourite it. '
                '\n\nTap the heart in the top right to show your favourites.\n'),
            Icon(Icons.favorite, color: Colors.red),
          ],
        ),
      ):
      Container(color: Colors.blue,
        child: ListView.builder(
          itemCount: playgroundList.length,
          itemBuilder: (context, index) {
            return playgroundList[index];
          },
        ),
      ),
    );
  }

}








//import 'package:flutter/material.dart';
//import 'playground_model.dart';
//import 'my_flutter_app_icons.dart';
//import 'playground_information_page.dart';
//import 'package:flare_flutter/flare_actor.dart';
//import 'token_widget.dart';
//
//class ListPage extends StatefulWidget {
//  @override
//  _ListPageState createState() => _ListPageState();
//}
//
//class _ListPageState extends State<ListPage> {
//  bool _showFavourites = false;
//  bool _filterToilet = false;
//  bool _filterCafe = false;
//  bool _filterSandpit = false;
//  bool _filterWaterplay = false;
//  bool _filterDuckpond = false;
//  List<Widget> playgroundList = List<Widget>();
//  bool _sortAtoZ = false;
//  bool _sortNearest = false;
//
//  void _addPlaygroundCard(int i) {
//   playgrounds[i].playground? playgroundList.add(
//      Container(
//        child: GestureDetector(
//          onTap: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => PlaygroundInformationPage(i)),
//            );
//          },
//          child: Card(
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Stack(
//                    children: [
//                      Align(alignment: Alignment.topRight, child:IconButton(
//                          icon: Icon(
//                            playgrounds[i].user['favourite']
//                                ? Icons.favorite
//                                : Icons.favorite_border,
//                            color: playgrounds[i].user['favourite'] ? Colors.red : Colors.black,
//                          ),
//                          onPressed: () async{
//                            DatabaseHelper helper = DatabaseHelper.instance;
//                            helper.updateFavouritesOrVisited(i, true);
//                            setState(()  {
//
//                              _createPlaygroundCards();
//                            });
//                          }), ),
//                      Center(child: TokenWidget(i,100, false)),
//                    ],
//                  ),
//                  Text(
//                    playgrounds[i].name,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold, fontSize: 16),
//                  ),
//                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: [
//                      Text(playgrounds[i].location),Text(playgrounds[i].distance.toStringAsFixed(1) + 'km')
//                    ],
//                  ),
//                  SizedBox(height: 10),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      playgrounds[i].features['cafe']
//                          ? Icon(Icons.local_cafe)
//                          : Container(),
//                      playgrounds[i].features['toilet']
//                          ? Icon(Icons.wc)
//                          : Container(),
//                      playgrounds[i].features['duckpond']
//                          ? Icon(MyFlutterApp.duck)
//                          : Container(),
//                      playgrounds[i].features['sandpit']
//                          ? Icon(MyFlutterApp.sandpit)
//                          : Container(),
//                      playgrounds[i].features['waterplay']
//                          ? Icon(MyFlutterApp.waterplay)
//                          : Container(),
//
//                    ],
//                  ),
//
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    ):null;
//  }
//
//  void _sortPlaygroundCards(bool distance) {
//    distance
//        ? playgrounds.sort((a, b) => a.distance.compareTo(b.distance))
//        : playgrounds.sort((a, b) => a.name.compareTo(b.name));
//  }
//
//  void _createPlaygroundCards() {
//    playgroundList.clear();
//    for (int i = 0; i < playgrounds.length; i++) {
//      if(playgrounds[i].playground){
//      if ((_showFavourites && playgrounds[i].user['favourite']) ||
//          !_showFavourites &&
//              ((_filterCafe && playgrounds[i].features['cafe']) ||
//                  !_filterCafe) &&
//              ((_filterSandpit && playgrounds[i].features['sandpit']) ||
//                  !_filterSandpit) &&
//              ((_filterToilet && playgrounds[i].features['toilet']) ||
//                  !_filterToilet) &&
//              ((_filterWaterplay && playgrounds[i].features['waterplay']) ||
//                  !_filterWaterplay) &&
//              ((_filterDuckpond && playgrounds[i].features['duckpond']) ||
//                  !_filterDuckpond)) {
//        _addPlaygroundCard(i);
//      }}
//
//    }
//    setState(() {
//
//    });
//  }
//
//  @override
//  void initState() {
//    getDistance();
//    _createPlaygroundCards();
//
//    super.initState();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//
//        actions: <Widget>[DropdownButton<String>(
//      hint: Text(
//        'Sort by',
//        style: TextStyle(color: Colors.white),
//      ),
//      items: [
//        DropdownMenuItem(
//          child: Row(
//            children: <Widget>[
//              Text('Distance'),
//              SizedBox(width: 10),
//              _sortNearest ? Icon(Icons.check) : Container()
//            ],
//          ),
//          value: 'Distance',
//        ),
//        DropdownMenuItem(
//          child: Row(
//            children: <Widget>[
//              Text('A to Z'),
//              SizedBox(width: 10),
//              _sortAtoZ ? Icon(Icons.check) : Container()
//            ],
//          ),
//          value: 'A to Z',
//        ),
//      ],
//      onChanged: (value) {
//        if (value == 'Distance') {
//          _sortPlaygroundCards(true);
//        } else {
//          _sortPlaygroundCards(false);
//        }
//        setState(() {
//          _createPlaygroundCards();
//        });
//      },
//    ),
//          SizedBox(width: 20),
//          DropdownButton<String>(
//            items: [ DropdownMenuItem(
//              child: Row(
//                children: <Widget>[
//
//
//                  Text('Clear all filters'),
//                ],
//              ),
//              value: 'Clear all filters',
//            ),
//              DropdownMenuItem(
//                child: Row(
//                  children: <Widget>[
//                    Icon(Icons.wc),
//                    SizedBox(width: 10),
//                    Text('Toilet'),
//                    SizedBox(width: 10),
//                    _filterToilet ? Icon(Icons.check) : Container()
//                  ],
//                ),
//                value: 'Toilet',
//              ),
//              DropdownMenuItem(
//                child: Row(
//                  children: <Widget>[
//                    Icon(Icons.local_cafe),
//                    SizedBox(width: 10),
//                    Text('Cafe'),
//                    SizedBox(width: 10),
//                    _filterCafe ? Icon(Icons.check) : Container()
//                  ],
//                ),
//                value: 'Cafe',
//              ),
//              DropdownMenuItem(
//                child: Row(
//                  children: <Widget>[
//                    Icon(MyFlutterApp.duck),
//                    SizedBox(width: 10),
//                    Text('Duckpond'),
//                    SizedBox(width: 10),
//                    _filterDuckpond ? Icon(Icons.check) : Container()
//                  ],
//                ),
//                value: 'Duckpond',
//              ),
//              DropdownMenuItem(
//                child: Row(
//                  children: <Widget>[
//                    Icon(MyFlutterApp.sandpit),
//                    SizedBox(width: 10),
//                    Text('Sandpit'),
//                    SizedBox(width: 10),
//                    _filterSandpit ? Icon(Icons.check) : Container()
//                  ],
//                ),
//                value: 'Sandpit',
//              ),
//              DropdownMenuItem(
//                child: Row(
//                  children: <Widget>[
//                    Icon(MyFlutterApp.waterplay),
//                    SizedBox(width: 10),
//                    Text('Waterplay'),
//                    SizedBox(width: 10),
//                    _filterWaterplay ? Icon(Icons.check) : Container()
//                  ],
//                ),
//                value: 'Waterplay',
//              ),
//            ],
//            hint: Text(
//              'Filter by: ',
//              style: TextStyle(color: Colors.white),
//            ),
//            onChanged: (String value) {
//              switch (value) {
//                case 'Clear all filters':
//                  setState(() {
//                    _filterWaterplay = false;
//                    _filterSandpit = false;
//                    _filterDuckpond = false;
//                    _filterCafe = false;
//                    _filterToilet = false;
//                    _createPlaygroundCards();
//                  });
//                  break;
//                case 'Toilet':
//                  setState(() {
//                    _filterToilet = !_filterToilet;
//                    _createPlaygroundCards();
//                  });
//                  break;
//                case 'Cafe':
//                  setState(() {
//                    _filterCafe = !_filterCafe;
//                    _createPlaygroundCards();
//                  });
//                  break;
//                case 'Sandpit':
//                  setState(() {
//                    _filterSandpit = !_filterSandpit;
//                    _createPlaygroundCards();
//                  });
//                  break;
//                case 'Duckpond':
//                  setState(() {
//                    _filterDuckpond = !_filterDuckpond;
//                    _createPlaygroundCards();
//                  });
//                  break;
//                case 'Waterplay':
//                  setState(() {
//                    _filterWaterplay = !_filterWaterplay;
//                    _createPlaygroundCards();
//                  });
//                  break;
//              }
//            },
//          ),
//
//          IconButton(
//              icon: Icon(
//                _showFavourites ? Icons.favorite : Icons.favorite_border,
//                color: _showFavourites ? Colors.red : Colors.white,
//              ),
//              onPressed: () {
//                setState(() {
//                  _showFavourites = !_showFavourites;
//                  _createPlaygroundCards();
//                });
//              }),
//        ],
//      ),
//      body: playgroundList.length==0? Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          children: [
//            Text('You haven\'t chosen any favourites yet'),
//            Text('\nTap the heart icon next to any playground to favourite it. '
//                '\n\nTap the heart in the top right to show your favourites.\n'),
//            Icon(Icons.favorite, color: Colors.red),
//          ],
//        ),
//      ):
//      Container(color: Colors.blue,
//        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,
//          crossAxisSpacing: 5.0,
//          mainAxisSpacing: 5.0,
//        ),
//          itemCount: playgroundList.length,
//          itemBuilder: (context, index) {
//            return playgroundList[index];
//          },
//        ),
//      ),
//    );
//  }
//
//}
