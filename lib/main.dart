import 'package:BristolPlaygrounds/token_widget.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'map_page.dart';
import 'list_page.dart';
import 'game_page.dart';
import 'playground_model.dart';
import 'playground_information_page.dart';
import 'package:BristolPlaygrounds/AwardsPage.dart';
import 'test_page.dart';
import 'playground_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bristol Playgrounds',
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
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    getDistance();
    _updateDb();

    super.initState();
  }

  _updateDb() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.getUserDb();
  }

  bool button_up = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('VISITED'),
                      Text(
                        '6',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  child: GestureDetector(
                      onTap: () async {
                        _playgroundButtonPressed(context);

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
                      child: TokenWidget(100, 60, button_up)),
                ),
                Container(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('TOTAL'),
                      Text(
                        '40',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            _bottomNavigationItem('Home', Icons.home),
            _bottomNavigationItem('Map', Icons.map),
            _bottomNavigationItem('List', Icons.list),
            _bottomNavigationItem('Game', Icons.portrait),
            _bottomNavigationItem('Awards', Icons.star)
          ],
        ),
        body: _currentIndex == 0
            ? HomePage()
            : _currentIndex == 1
                ? MapPage()
                : _currentIndex == 3
                    ? GamePage()
                    : _currentIndex == 2 ? ListPage() : AwardsPage());
  }

  _bottomNavigationItem(String text, IconData icon) {
    return BottomNavigationBarItem(
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(icon, color: Colors.white),
    );
  }

  Future<void> _playgroundButtonPressed(BuildContext context) async {
    int i = await checkDistance();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'You have won the Redland Green Token for visiting Redland Green!',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    PlaygroundCheck(i),
                    Text(
                      'You can now play with your new peice of equipment in your virtual playground',
                      style:
                          TextStyle(fontSize: 16, ),
                      textAlign: TextAlign.center,

                    ),
                    RaisedButton(elevation: 10, color: Colors.blue,child: Text('Dismiss'), onPressed: (){Navigator.pop(context);},)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
