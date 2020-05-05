import 'package:flutter/material.dart';

import 'mainDrawer.dart';
import 'mainHomePage.dart';

class Credits extends StatelessWidget{
  static const routeName = 'Credits Screen';

  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder:(context) => AlertDialog(
          title: Text('Exit this Screen'),
          actions: <Widget>[
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(MainHomeScreen.routeName);
                    },
                    child: Text('Yes')
                  ),
                  Divider(),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No')
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: MainDrawer(),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            children: <Widget>[
              TextFormat('Credits'),
              TextFormat('Ashwani(AshK)'),
              TextFormat('Arvind'),
              TextFormat('Vishal'),
              TextFormat('Siddhi'),
              TextFormat('Ayushi'),
              TextFormat('Raghav'),
            ],
          ),
        ),
      )
    );
  }
}

class TextFormat extends StatelessWidget {
  const TextFormat(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(text,textAlign: TextAlign.center,textWidthBasis: TextWidthBasis.parent,textScaleFactor: 3.0,style: TextStyle(color: Colors.white) ,));
  }
}