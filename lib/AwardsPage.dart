import 'package:flutter/material.dart';
import 'token_widget.dart';
import 'playground_model.dart';

class AwardsPage extends StatefulWidget {
  @override
  _AwardsPageState createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text('\nYour Awards So Far', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            Text('\nVisit more playgrounds to earn more tokens\n\n', textAlign: TextAlign.center,),
        Expanded(
          child: GridView.builder(
              itemCount: playgrounds.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width<400? 3: width<600? 4: 5 ),
              itemBuilder: (BuildContext context, int i) {
                return(Container(height: 80, child:Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(opacity: playgrounds[i].user['visited']? 1:0.5, child: TokenWidget(i, 80, false)),]
                    ),
                    Text(playgrounds[i].name, textAlign: TextAlign.center,)
                  ],
                ) ));
              }),
        ),
      ],
    );
  }
}
