import 'package:backstage/Inventory/Screens/borrowedScreen.dart';
import 'package:backstage/Inventory/Screens/currentInventoryScreen.dart';
import 'package:backstage/Inventory/Widgets/barcodeScan.dart';
import 'package:backstage/Providers&Services/auth.dart';
import 'package:flutter/material.dart';

import '../inventoryHomeScreen.dart';

class RightAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBar(
            title: Text('Inventory Drawer'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Inventory Main Page'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Borrowed Items'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(BorrowedScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Inventory Items'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CurrentInventoryScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.transit_enterexit),
            title: Text('Sign Out'),
            onTap: () async {
              await AuthService().signOut();
            },
          ),
          Divider(),
          Container(
            color: Colors.purple,
            child: BarcodeScanner()
          ),
        ],
      ),
    );
  }
}