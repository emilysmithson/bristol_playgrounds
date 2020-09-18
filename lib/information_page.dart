import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'playground_model.dart';
import 'my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'token_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';
import 'custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:store_redirect/store_redirect.dart';
import 'dart:io' show Platform;

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  int i;
  List markers = List<Marker>();
  FlareControls controls = FlareControls();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Information'),
        // actions: [IconButton(icon: Icon(Icons.settings, color: Colors.white, ), onPressed: (){},)],
      ),
      body: Container(
        //color: Color.fromARGB(255, 0, 172, 16),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/sky_header.png',
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      height: 100,
                      width: 100,
                      child: FlareActor(
                        'assets/Sunshine.flr',
                        animation: 'sun_rays',
                      )),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 18),
                    child: Text(
                      'Thank you for downloading Bristol Playgrounds App',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Text(
                        '\nHow this app came to be',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          '\nJust before my third child was born I decided to try and visit all the playgrounds in Bristol. '
                          '\n\nHere was this amazing resource right on my doorstep and absolutely free. It was fantastic for keeping my children, and myself entertained on a tight budget.'
                          '\n\nI started to blog about my experiences so that I could share some of the absolute gems I had found.'
                          '\n\nIn search of a new career I thought, \'Why don\'t I turn this blog into an app? How hard can it be?\''
                          '\n\nWell, it turns out very hard but also awesome fun. I taught myself to use Flutter to create this app. '
                          '\n\nI am no artist so my now 11 year old daughter helped with the design - a great project during lockdown.'
                          '\n\nI hope you enjoy it.'
                          '\n\nHuge thanks to my daughter Jess for all her support, creativity and ideas and my sisters Elena and Tina for the coaching and enthusiasm.\n',
                          style: TextStyle(fontSize: 16)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'If you have any comments or queries (bonus points if you spot a mistake) please get in touch via email here.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              icon: Icon(Icons.email),
                              onPressed: () {
                                _launchEmail();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Keep up to date on Facebook.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              icon: Icon(CustomIcons.facebook),
                              onPressed: () {
                                if (Platform.isIOS) {
                                  _launchInBrowser(
                                      'https://www.facebook.com/BristolPlaygrounds/');
                                } else {
                                  _launchURL(
                                      'https://www.facebook.com/BristolPlaygrounds/',
                                      context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Find us on Twitter or use the hashtag #BristolPlaygrounds',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              icon: Icon(
                                CustomIcons.twitter_bird,
                                size: 20,
                              ),
                              onPressed: () {
                                if (Platform.isIOS) {
                                  _launchInBrowser(
                                      'https://twitter.com/BrisPlaygrounds');
                                } else {
                                  _launchURL(
                                      'https://twitter.com/BrisPlaygrounds',
                                      context);
                                }

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'If you have enjoyed this app I would really appreciate a positive review. Please click here.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () {
                                LaunchReview.launch(
                                  androidAppId:
                                      "uk.co.bristolplaygrounds",
                                  iOSAppId: "1459763927",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Text(
                        '\nLinks',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      usefulLinks(
                          'Flutter Developer',
                          'https://bristolflutterdeveloper.wordpress.com',
                          'If you are interested in producing a similar app at a very reasonable price see this website for more information.', context),
                      usefulLinks(
                          'Bristol Playgrounds Blog',
                          'https://bristolplaygrounds.wordpress.com',
                          'For more information about any of the playgrounds you can check out my original blog where this all started. ', context),
                      Text(
                        '\nOther apps you may enjoy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      linkToOtherApps(
                        'Redland Green Tree Trail',
                        'com.flutterdevelopper.redland_green_trail',
                        '1511416301',
                        'If you enjoyed this app you might enjoy The Redland Green Tree Trail which takes you on a lovely stroll around Redland Green and teaches you to identify 20 of the trees there.',
                      ),
                      linkToOtherApps(
                          'Les Petits Zouzous.',
                          'com.petitszouzous',
                          '1507644486',
                          'Or perhaps you would like to learn a little French with this app in collaboration with Les Petits Zouzous which teaches some French vocabulary through music and games.'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _launchEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'emily_foulkes@hotmail.com',
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}

Future<void> _launchURL(String url, BuildContext context) async {
  final myController = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Did you mean to leave the app?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(width: 200, child: Text('What is 12 + 17?.')),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'answer'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
            onPressed: () async {
              if (myController.text == '29') {
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

Widget usefulLinks(String title, String url, String description, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 170,
      child: GestureDetector(
        onTap: () {
          if (Platform.isIOS) {
            _launchInBrowser(
                url);
          } else {
            _launchURL(
                url,
                context);
          }
        },
        child: Card(
          color: Color.fromARGB(250, 0, 155, 205),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.launch, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(description, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget linkToOtherApps(
    String title, String androidAppID, String iosAppID, String description) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 170,
      child: GestureDetector(
        onTap: () {
          StoreRedirect.redirect(
              androidAppId: androidAppID, iOSAppId: iosAppID);
        },
        child: Card(
          color: Color.fromARGB(250, 0, 155, 205),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.launch,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
