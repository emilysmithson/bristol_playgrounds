import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'token_widget.dart';
import 'playground_model.dart';
import 'playground_information_page.dart';

class AwardsPage extends StatefulWidget {
  @override
  _AwardsPageState createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {

  @override
  Widget build(BuildContext context) {
    int _totalNumberOfPrizes = playgrounds.length;
    int _numberOfPrizesWon = countNumberOfPrizes();
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        color: Color.fromARGB(250, 0, 175, 212),
        child: ListView(
          shrinkWrap: true,
          children: [

            _numberOfPrizesWon == 0
                ? Container(height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: Icon(Icons.arrow_upward, size: 60, color: Colors.white)),
                        Center(child: Text('Tap the button at the top to win your first award.', style: TextStyle(fontSize: 16, color: Colors.white))),
                      ],
                    ),
                  ),
                )
                : Text(
                    '\nYour Awards won so far: ${_numberOfPrizesWon}\n ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
            _numberOfPrizesWon==0? Container(): Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playgrounds.length,
                  itemBuilder: (BuildContext context, int i) {
                    return !playgrounds[i].user['visited']
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              playgrounds[i].playground
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlaygroundInformationPage(i)),
                                    )
                                  : null;
                            },
                            child: Card(
                              child: (Container(
                                  height: 200,
                                  width: 120,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                              height: 80,
                                              width: 80,
                                              child: FlareActor(playgrounds[i]
                                                  .flare['asset'])),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                playgrounds[i].playground
                                                    ? 'Visit ' +
                                                        playgrounds[i].name
                                                    : playgrounds[i].name + '!',
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.vpn_key, size: 12),
                                              SizedBox(width: 8),
                                              Text(playgrounds[i].secretCode, style: TextStyle(fontSize: 10))
                                            ],
                                          )
                                        ],
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: playgrounds[i].user['visited']
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                              : Container())
                                    ],
                                  ))),
                            ),
                          );
                  }),
            ),
            Text(
              '\nAwards still to get: ${_totalNumberOfPrizes - _numberOfPrizesWon}\n',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playgrounds.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                        onTap: () {
                          playgrounds[i].playground
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlaygroundInformationPage(i)),
                                )
                              : null;
                        },
                        child: playgrounds[i].user['visited']
                            ? Container()
                            : Card(
                                child: (Container(
                                    height: 200,
                                    width: 120,
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Container(
                                                height: 80,
                                                width: 80,
                                                child: FlareActor(playgrounds[i]
                                                    .flare['asset'])),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                  playgrounds[i].playground
                                                      ? 'Visit ' +
                                                          playgrounds[i].name
                                                      : playgrounds[i].name +
                                                          '!',
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child:
                                                playgrounds[i].user['visited']
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      )
                                                    : Container())
                                      ],
                                    ))),
                              ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
