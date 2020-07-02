import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'playground_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'playground_information_page.dart';
import 'my_flutter_app_icons.dart';
import 'token_widget.dart';

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

  void _addMarker(int i) {
    playgrounds[i].playground?markers.add(
      Marker(
        width: 40.0,
        height: 80.0,
        point: playgrounds[i].coordinates,
        builder: (ctx) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
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
                      child: Icon(Icons.location_on,
                          color: Theme.of(context).primaryColor, size: 40),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ):null;
  }

  void _filteredMarkers() {
    markers.clear();
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
        _addMarker(i);
      }}

    }
  }

  void addInformation(int i) async {
    if (_showingInformation)  {
     await markers.removeLast();
    }
    _showingInformation = true;
    markers.add(
      Marker(
        width: 100.0,
        height: 380.0,
        point: playgrounds[i].coordinates,
        builder: (ctx) => Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 170,
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
                       TokenWidget(i,80, false),
                        SizedBox(height: 8.0),
                        Text(
                          playgrounds[i].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          playgrounds[i].location,
                          textAlign: TextAlign.center,
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
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.location_on,
                          color: Theme.of(context).primaryColor, size: 40),
                    ),
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

  @override
  void initState() {
    getPlaygrounds();
    super.initState();
  }


  @override
  void dispose() {

super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            maxZoom: 19,
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
