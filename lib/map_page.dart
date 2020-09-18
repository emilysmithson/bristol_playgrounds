import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'playground_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'playground_information_page.dart';
import 'my_flutter_app_icons.dart';
import 'token_widget.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _showFavourites = false;
  bool _filterToilet = false;
  bool _filterCafe = false;
  bool _filterSandpit = false;
  bool _filterWaterplay = false;
  bool _filterDuckpond = false;
  bool _showingInformation = false;
  bool _filterVisited = false;
  bool _filterUnvisited = false;

  void _addMarker(int i) {
    playgrounds[i].playground
        ? markers.add(
            Marker(
              width: 40.0,
              height: 80.0,
              point: playgrounds[i].coordinates,
              builder: (ctx) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                addInformation(i);
                              });
                            },
                            child: Stack(
                              children: [
                                Icon(Icons.location_on,
                                    color: playgrounds[i].user['visited']
                                        ? Color.fromARGB(250, 0, 175, 212)
                                        : Colors.grey,
                                    size: 40),
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : null;
  }

  void _filteredMarkers() {
    markers.clear();
    for (int i = 0; i < playgrounds.length; i++) {
      if (playgrounds[i].playground) {
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
                    !_filterDuckpond) &&
                ((_filterVisited && playgrounds[i].user['visited']) ||
                    !_filterVisited) &&
                ((_filterUnvisited && !playgrounds[i].user['visited']) ||
                    !_filterUnvisited)) {
          _addMarker(i);
        }
      }
    }
  }

  void addInformation(int i) async {
    if (_showingInformation) {
      await markers.removeLast();
    }
    _showingInformation = true;
    markers.add(
      Marker(
        width: 170.0,
        height: 380.0,
        point: playgrounds[i].coordinates,
        builder: (ctx) => Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 170,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaygroundInformationPage(i)),
                      );
                    },
                    child: Column(
                      children: [
                        TokenWidget(i, 80, false),
                        SizedBox(height: 8.0),
                        Text(
                          playgrounds[i].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 80,
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.location_on,
                        color: playgrounds[i].user['visited']
                            ? Color.fromARGB(250, 0, 175, 212)
                            : Colors.grey,
                        size: 40),
                    Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPlaygrounds() {
    for (int i = 0; i < playgrounds.length; i++) {
      _addMarker(i);
    }
  }

  List markers = List<Marker>();
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    getPlaygrounds();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
          if(result == ConnectivityResult.none){
            final snackBar = SnackBar(
              content: Text('You have no internet connection so this map may not display properly'),

            );
            Scaffold.of(context).showSnackBar(snackBar);
          }

    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 0, 175, 212),
        actions: <Widget>[
          DropdownButton<String>(
            items: [
              DropdownMenuItem(
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
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(width: 10),
                    Text('Visited'),
                    SizedBox(width: 10),
                    _filterVisited ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Visted',
              ),
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    SizedBox(width: 10),
                    Text('Not visited'),
                    SizedBox(width: 10),
                    _filterUnvisited ? Icon(Icons.check) : Container()
                  ],
                ),
                value: 'Not visited',
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
                    _filterUnvisited = false;
                    _filterVisited = false;
                    _filteredMarkers();
                  });
                  break;
                case 'Toilet':
                  setState(() {
                    _filterToilet = !_filterToilet;
                    _filteredMarkers();
                  });
                  break;
                case 'Cafe':
                  setState(() {
                    _filterCafe = !_filterCafe;
                    _filteredMarkers();
                  });
                  break;
                case 'Sandpit':
                  setState(() {
                    _filterSandpit = !_filterSandpit;
                    _filteredMarkers();
                  });
                  break;
                case 'Duckpond':
                  setState(() {
                    _filterDuckpond = !_filterDuckpond;
                    _filteredMarkers();
                  });
                  break;
                case 'Waterplay':
                  setState(() {
                    _filterWaterplay = !_filterWaterplay;
                    _filteredMarkers();
                  });
                  break;
                case 'Visted':
                  setState(() {
                    _filterVisited = !_filterVisited;
                    if (_filterVisited) {
                      _filterUnvisited = false;
                    }
                    _filteredMarkers();
                  });

                  break;
                case 'Not visited':
                  setState(() {
                    _filterUnvisited = !_filterUnvisited;
                    if (_filterUnvisited) {
                      _filterVisited = false;
                    }
                    _filteredMarkers();
                  });

                  break;
              }
            },
          ),
          SizedBox(width: 100),
          IconButton(
              icon: Icon(
                _showFavourites ? Icons.favorite : Icons.favorite_border,
                color: _showFavourites ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _showFavourites = !_showFavourites;
                  _filteredMarkers();
                });
              }),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(51.4558, -2.5881),
            zoom: 11,
            maxZoom: 18,
            onTap: (p) {
              if (_showingInformation) {
                setState(() {
                  markers.removeLast();
                  _showingInformation = false;
                });
              }
            }),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(markers: markers),
        ],
      ),
    );
  }
}
