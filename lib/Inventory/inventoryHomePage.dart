import 'package:backstage/Inventory/barcodeScan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './appDrawer.dart';

class InventoryHomeScreen extends StatelessWidget {
  static const routeName = 'Inventory Home Screen';

  final _isLoading =false;
  @override

  
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ?? false;
    }
    
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: _isLoading
      ? SpinKitRotatingCircle()
      : Scaffold(
        appBar: AppBar(
          title: Text("Inventory Home Page"),
          actions: <Widget>[
            Container(
              child: BarcodeScanner(),
            )
          ],
        ),
        endDrawer: RightAppDrawer(),
      ),
    );
  }
}