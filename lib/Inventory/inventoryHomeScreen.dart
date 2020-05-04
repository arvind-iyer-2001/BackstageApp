import 'package:flutter/material.dart';

import './Widgets/inventoryAppDrawer.dart';
import './Widgets/barcodeScan.dart';
import '../AppWideDisplay/mainDrawer.dart';

class InventoryHomeScreen extends StatelessWidget {
  static const routeName = "Inventory Home Screen";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Home Screen"),
        actions: <Widget>[
          BarcodeScanner()
        ],
      ),
      endDrawer: RightAppDrawer(),
      drawer: MainDrawer(),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text('This part of the App handes all Inventory functionality'),
      ),
    );
  }
}


