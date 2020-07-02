import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'playground_model.dart';
import 'token_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

double top = 100;
double top2 = 200;
double left2 = 200;
double left = 100;

class _HomePageState extends State<HomePage> {

  bool button_up = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        _checkplaygrounds();
        },),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text('Welcome to Bristol Playgrounds!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                SizedBox(height: 20),
                Container(
                  width: 180,
                  child: GestureDetector(
                      onTap: () async {
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
                      child: TokenWidget(0, 180, button_up)),
                ),
                Text('This app will help you discover 40 of the very best playgrounds in and around Bristol.'
                    '\n\nWhenever you visit a new playground, press the button at the top and you will be rewarded a new peice of playground equipment for your very own virtual playground.'),

//              ButtonBar(children: [
//                RaisedButton(child: Text('insert'),onPressed: (){_insert();},),
//                RaisedButton(child: Text('checkDB'),onPressed: (){_checkplaygrounds();},),
//                RaisedButton(child: Text('set'), onPressed: (){_setDB();},),
//                RaisedButton(child: Text('updateDB'), onPressed:(){_updateDB();}),
//                RaisedButton(child: Text('delete all'), onPressed:(){_deleteAll();})
//              ],)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
_deleteAll ()async{
  DatabaseHelper helper = DatabaseHelper.instance;
  helper.deleteLast();
}
_insert() async{


    DatabaseHelper helper = DatabaseHelper.instance;
    for(int i =0; i<playgrounds.length; i++)
    if(playgrounds[i].playground){int id = await helper.insert(i);
    print('inserted row: $id');}

}
_checkplaygrounds() async{
  DatabaseHelper helper = DatabaseHelper.instance;
  var playground = await helper.queryAllPlaygrounds();
  print(playground);
  print(playgrounds[0].user);

}
_deletePlaygrounds() async{
  DatabaseHelper helper = DatabaseHelper.instance;
  var playground = await helper.deleteLast();
  print(playground);

}
_updateDB(){
  DatabaseHelper helper = DatabaseHelper.instance;
  helper.updateFavouritesOrVisited(0, true);
}

_setDB(){
  DatabaseHelper helper = DatabaseHelper.instance;
  helper.getUserDb();

}