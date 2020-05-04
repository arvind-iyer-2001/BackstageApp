import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Backstage Utility App"),
            actionsIconTheme: null,
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Container()
            ],
          )
        ],
      ),
    );
  }
}