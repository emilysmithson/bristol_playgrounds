import 'package:BristolPlaygrounds/token_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'map_page.dart';
import 'list_page.dart';
import 'game_page.dart';
import 'playground_model.dart';
import 'package:BristolPlaygrounds/AwardsPage.dart';
import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import "package:flare_flutter/flare_actor.dart";
import 'information_page.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'custom_icons_icons.dart';

bool assetsWarm = false;


bool showIntroduction = true;
String secretCode;
void main() {
  // Newer versions of Flutter require initializing widget-flutter binding
  // prior to warming up the cache.
  WidgetsFlutterBinding.ensureInitialized();

  // Don't prune the Flare cache, keep loaded Flare files warm and ready
  // to be re-displayed.
  FlareCache.doesPrune = false;
  warmUpSwing()
    ..then((_) {
      runApp(MyApp());
    });
}

Future<void> warmUpFlare() async {
  List<AssetProvider> flareAssets = List<AssetProvider>();
  flareAssets.add(AssetFlare(bundle: rootBundle, name: 'assets/Sunshine.flr'));
  flareAssets.add(AssetFlare(bundle: rootBundle, name: 'assets/prize.flr'));
  for (int i = 15; i < playgrounds.length; i++) {
    flareAssets.add(
        AssetFlare(bundle: rootBundle, name: playgrounds[i].flare['asset']));
  }
  for (final asset in flareAssets) {
    await cachedActor(asset);
  }
}

Future<void> warmUpSwing() async {
  List<AssetProvider> flareAssets = [
    AssetFlare(bundle: rootBundle, name: 'assets/swing_character.flr'),
    AssetFlare(bundle: rootBundle, name: 'assets/Duckpond.flr')
  ];
  for (int i = 0; i < 15; i++) {
    flareAssets.add(
        AssetFlare(bundle: rootBundle, name: playgrounds[i].flare['asset']));
  }
  for (final asset in flareAssets) {
    await cachedActor(asset);
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bristol Playgrounds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Bristol Playgrounds'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  int _totalNumberOfPrizes = playgrounds.length;
  int _numberOfPrizesWon;

  showMap() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  void initState() {

    _updateDb();
   //  Warm the cache up.
    warmUpFlare()
      ..then((_) {
        setState(() {
          assetsWarm = true;
          print('warmed up');
        });
      });

    super.initState();
  }

  _updateDb() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.getUserDb().then((value) {
      setState(() {

        _numberOfPrizesWon = countNumberOfPrizes();
        getDistance();
      });
    });
  }

  bool button_up = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double dotSize = width<350? 7: 10;
    if (showIntroduction) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(250, 0, 175, 212),
          title: Text('Introduction'),
        ),
        body: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Welcome To Bristol Playgrounds!',
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        height: 300,
                        child: FlareActor(
                          'assets/swing_character.flr',
                          animation: 'Swing',
                        )),
                    Text(
                      "This app will help you discover the very best free and fantastic playgrounds that Bristol has to offer.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              PageViewModel(
                  title: 'Find your next adventure using the Interactive Map',
                  bodyWidget: Image.asset('assets/map_information.png')),
              PageViewModel(
                  title:
                      'Or use the List Page to see all the playgrounds at a glance.',
                  bodyWidget: Image.asset('assets/list_information.png')),
              PageViewModel(
                  title:
                      'Every time you visit a playground you win some equipment for your very own Virtual Playground',
                  bodyWidget: Image.asset('assets/vp_information.png')),
              PageViewModel(
                  title: 'Disclaimer',
                  bodyWidget: Column(
                    children: [
                      Text(
                          'All of the information on this app is correct to the best of our knowledge but please do a quick check for yourself before you go, especially given the current global pandenmic! '
                          '\n\nPlaygrounds change rapidly, water is often switched off, cafes closed or equipment vandalised.'
                          '\n\nThis app does not include every playground in Bristol. It excludes ones which are very small. There will be more to come however so keep your app updated!'
                          '\n\nIf you spot a mistake, have a suggestion or would like to share your experience, please use twitter, facebook or drop us an email (see info page for contact details)'),
                      Container(
                          height: 200,
                          child: FlareActor(
                            'assets/Duckpond.flr',
                            animation: 'Untitled',
                          ))
                    ],
                  )),
            ],
            globalBackgroundColor: Color.fromARGB(255, 198, 244, 255),
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('Skip'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator:  DotsDecorator(
              size: Size(dotSize, dotSize),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            onDone: () {
              setState(() {
                showIntroduction = false;
              });
            }),
      );
    } else {
      if (assetsWarm) {
        return Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromARGB(250, 0, 155, 205),
                actions: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.help),
                          onPressed: () {
                            setState(() {
                              showIntroduction = true;
                            });
                          },
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('AWARDS'),
                            _numberOfPrizesWon == null
                                ? Container()
                                : Text(
                                    _numberOfPrizesWon.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                        GestureDetector(
                            onTap: () async {
                              _playgroundButtonPressed(context, true);

                              setState(() {
                                button_up = false;
                              });
                              await new Future.delayed(
                                      const Duration(milliseconds: 100))
                                  .then((time) {
                                setState(() {
                                  button_up = true;
                                });
                              });
                            },
                            child: Stack(
                              children: [
                                Center(
                                    child: TokenWidget(100, 60, button_up)),
                                Container(width: 60, height: 60,
                                  child: Center(
                                      child: Text('?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                )
                              ],
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('OUT OF'),
                            Text(
                              _totalNumberOfPrizes.toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InformationPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ]),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.yellow,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromARGB(250, 0, 155, 205),
              items: [
                _bottomNavigationItem('Awards', CustomIcons.trophy, 22),
                _bottomNavigationItem('Map', Icons.map, 24),
                _bottomNavigationItem('List', Icons.list, 24),
                _bottomNavigationItem('Playground', CustomIcons.sun, 24),
              ],
            ),
            body: _currentIndex == 0
                ? AwardsPage()
                : _currentIndex == 1
                    ? MapPage()
                    : _currentIndex == 2 ? ListPage() : GamePage());
      } else {
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: FlareActor(
                  'assets/swing_character.flr',
                  animation: 'Swing',
                ),
              ),
              Text(
                'loading playgrounds...',
              )
            ],
          )),
        );
      }
    }
  }

  _bottomNavigationItem(String text, IconData icon, double size) {
    return BottomNavigationBarItem(
      title: Text(
        text,
      ),
      icon: Icon(icon, size: size),
    );
  }

   _playgroundButtonPressed(
      BuildContext context, bool distance) async {

    int i;
    _checkingPlaygrounds();
    if (distance) {
      i = await checkDistance().then((value) {



        Navigator.pop(context);
_checkInt(value);
        return(value);
      });
    } else {
      for (int j = 0; j < playgrounds.length; j++) {
        if (playgrounds[j].secretCode == secretCode) {
          i = j;
        }
      }
      Navigator.pop(context);
      _checkInt(i);

    }



  }

  _checkInt(int i){

    var now = new DateTime.now();
    if (i == null) {

      if (!playgrounds[0].user['visited']) {
        _awardWon(0);
      } else {
        _tryAgain();
      }
    } else {
      if (!playgrounds[0].user['visited']) {
        _awardWon(0);
      }
      if (!playgrounds[i].user['visited']) {
        _awardWon(i);
        if (playgrounds[i].features['duckpond'] &&
            !playgrounds[1].user['visited']) {
          _awardWon(1);
        }
        if (playgrounds[i].features['sandpit'] &&
            !playgrounds[6].user['visited']) {
          _awardWon(6);
        }
        if (playgrounds[i].features['cafe'] &&
            !playgrounds[5].user['visited']) {
          _awardWon(5);
        }

        if (_numberOfPrizesWon == 20) {
          _awardWon(4);
        }
        if (now.hour > 17 && !playgrounds[3].user['visited']) {
          _awardWon(3);
        }
        if (now.hour < 9 && !playgrounds[3].user['visited']) {
          _awardWon(2);
        }
      } else {
        if (!playgrounds[0].user['visited']) {
          _awardWon(0);
        } else {
          _tryAgain();
        }
      }
    }

  }

  _checkingPlaygrounds() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 300,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Checking playgrounds...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        });
  }

  _tryAgain() {
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                height: 300,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No prize at the moment!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                            'You need to go and visit a playground to win a prize.'),
                        SizedBox(height: 8),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final _formKey = GlobalKey<FormState>();
                                    String secretKey;
                                    return Center(
                                      child: Container(
                                        height: 300,
                                        child: SingleChildScrollView(
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Enter secret code',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Form(
                                                    key: _formKey,
                                                    child: TextFormField(autofocus: true,
                                                      keyboardType: TextInputType.numberWithOptions(signed: true),
                                                      onSaved: (value) {
                                                        secretCode = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  'secret code'),
                                                    ),
                                                  ),
                                                  RaisedButton(
                                                    elevation: 10,
                                                    color: Colors.blue,
                                                    child: Text('Submit'),
                                                    onPressed: () {
                                                      setState(() {});
                                                      _formKey.currentState
                                                          .save();
                                                      Navigator.pop(context);
                                                      _playgroundButtonPressed(
                                                          context, false);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Expanded(child: Text('Do you have a secret code? Click here ')),
                                Icon(Icons.vpn_key),
                              ],
                            )),
                        SizedBox(height: 8),
                        RaisedButton(
                          elevation: 10,
                          color: Colors.blue,
                          child: Text('Ok'),
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  _awardWon(int i) {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.updateFavouritesOrVisited(i, false);
    _numberOfPrizesWon = countNumberOfPrizes();
    String playgroundName = playgrounds[i].name;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 500,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Congratulations!',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'You have won an award!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            height: 200,
                            child: Stack(
                              children: [
                                FlareActor(
                                  'assets/prize.flr',
                                  animation: 'Untitled',
                                ),
                                Center(
                                  child: Container(
                                      width: 200,
                                      height: 200,
                                      child: TokenWidget(i, 200, true)),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      playgrounds[i].playground
                                          ? 'Visit ' + playgrounds[i].name
                                          : playgrounds[i].name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'You can now play with your new peice of equipment in your virtual playground',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          RaisedButton(
                            elevation: 10,
                            color: Colors.blue,
                            child: Text('Ok'),
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
