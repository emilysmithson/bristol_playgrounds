import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'playground_model.dart';
import 'my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'token_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PlaygroundInformationPage extends StatefulWidget {
  final int playgroundNumber;
  PlaygroundInformationPage(this.playgroundNumber);

  @override
  _PlaygroundInformationPageState createState() =>
      _PlaygroundInformationPageState();
}

class _PlaygroundInformationPageState extends State<PlaygroundInformationPage> {
  int i;
  List markers = List<Marker>();
  FlareControls controls = FlareControls();
  @override
  void initState() {
    i = widget.playgroundNumber;
    super.initState();
  }

  void _addMarker(int i) {
    markers.add(
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
                    Icon(Icons.location_on,
                        color: Color.fromARGB(250, 0, 175, 212), size: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _addMarker(i);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.directions),
        onPressed: () {
          _launchMapsUrl(playgrounds[i].coordinates.latitude,
              playgrounds[i].coordinates.longitude, playgrounds[i].name);
        },
      ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(250, 0, 155, 205),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(playgrounds[i].name)),
      body: Container(
        //color: Color.fromARGB(255, 0, 172, 16),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(width: MediaQuery.of(context).size.width, child: Image.asset('assets/sky.png', fit: BoxFit.fill)),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            controls.play(
                                playgrounds[i].flare['animation_ontap']);
                          },
                          child: FlareActor(
                            playgrounds[i].flare['asset'],
                            animation:
                                playgrounds[i].flare['running_animation'],
                            controller: controls,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              playgrounds[i].name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              playgrounds[i].location,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(playgrounds[i].address),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  playgrounds[i].features['cafe']
                      ? Row(
                          children: <Widget>[
                            Icon(Icons.local_cafe),
                            Text(' cafe')
                          ],
                        )
                      : Container(),
                  playgrounds[i].features['toilet']
                      ? Row(
                          children: <Widget>[Icon(Icons.wc), Text(' Toilet')],
                        )
                      : Container(),
                  playgrounds[i].features['duckpond']
                      ? Row(
                          children: <Widget>[
                            Icon(MyFlutterApp.duck),
                            Text(' Duckpond')
                          ],
                        )
                      : Container(),
                  playgrounds[i].features['sandpit']
                      ? Row(
                          children: <Widget>[
                            Icon(MyFlutterApp.sandpit),
                            Text(' Sandpit')
                          ],
                        )
                      : Container(),
                  playgrounds[i].features['waterplay']
                      ? Row(
                          children: <Widget>[
                            Icon(MyFlutterApp.waterplay),
                            Text(' Waterplay')
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      playgrounds[i].user['favourite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: playgrounds[i].user['favourite']
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () async {
                      DatabaseHelper helper = DatabaseHelper.instance;
                      helper.updateFavouritesOrVisited(i, true);
                      setState(() {});
                    }),
                SizedBox(width: 10),
                Text(playgrounds[i].user['favourite']
                    ? 'Added to my favourites'
                    : 'Add to my favourites')
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Icon(Icons.star,
                      color: playgrounds[i].user['visited']
                          ? Colors.yellow
                          : Colors.grey),
                  SizedBox(width: 10),
                  Text(playgrounds[i].user['visited']
                      ? ' Visited'
                      : ' Not yet visited')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(playgrounds[i].description),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 5)),
                height: 500,
                child: FlutterMap(
                  options: MapOptions(
                    center: playgrounds[i].coordinates,
                    zoom: 13,
                    maxZoom: 19,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: NonCachingNetworkTileProvider(),
                    ),
                    MarkerLayerOptions(markers: markers),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Color.fromARGB(250, 0, 155, 205),
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

void _launchMapsUrl(double lat, double lon, String name) async {

  MapsLauncher.launchCoordinates(lat, lon, name);
//  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
//  if (await canLaunch(url)) {
//    await launch(url);
//  } else {
//    throw 'Could not launch $url';
//  }
}
