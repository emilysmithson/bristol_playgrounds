import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'playground_model.dart';
import 'my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'token_widget.dart';
import 'package:flare_flutter/flare_actor.dart';

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
                        color: Theme.of(context).primaryColor, size: 40),
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
              playgrounds[i].coordinates.longitude);
        },
      ),
      appBar: AppBar(
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
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/sky.png',
                fit: BoxFit.fill,
              )),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  playgrounds[i].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),

              Container(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print('tapped');
                      controls.play(playgrounds[i].flare['animation_ontap']);
                    },
                    child: FlareActor(
                      playgrounds[i].flare['asset'],
                      animation: playgrounds[i].flare['running_animation'],
                      controller: controls,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
            ],
          ),
        ],
      ),
    );
  }
}

void _launchMapsUrl(double lat, double lon) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
