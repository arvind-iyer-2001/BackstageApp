import 'package:flutter/material.dart';

import './mainDrawer.dart';

class MainHomeScreen extends StatelessWidget {
  static const routeName = "Main Home Screen";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Backstage Utitlity App"),
      ),
      drawer: MainDrawer(),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text('Welcome to the Backstage Utility App'),
      ),
    );
  }
}