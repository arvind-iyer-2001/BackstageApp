import 'package:backstage/AppWideDisplay/mainHomePage.dart';
import 'package:backstage/Inventory/inventoryHomeScreen.dart';
import 'package:backstage/Providers&Services/auth.dart';
import 'package:flutter/material.dart';

import 'credits.dart';

class MainDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: const Text(
                "Backstage Utility App",
                style: TextStyle(
                  fontStyle: FontStyle.italic),
                  textScaleFactor: 2.0,
                ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ), 
            ),

            //Home List Tile
            ListTile(
              title: Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(MainHomeScreen.routeName);
              },
            ),
            Divider(),

            //Inventory List Tile
            ListTile(
              title: Text("Inventory"),
              leading: const Icon(Icons.input),
              
              onTap: () {
                Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.routeName);
              },
            ),
            Divider(),
            
            //Credits Tile List
            ListTile(
              title: Text("Credits"),
              leading: const Icon(Icons.accessibility_new), 
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Credits.routeName);
              },
            ),
            Divider(),

            ListTile(
              title: Text("Sign Out"),
              leading: const Icon(Icons.person), 
              onTap: () async {
                await AuthService().signOut();
              }, 
            ),
            
          ],
        )
      );
  }
}