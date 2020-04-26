import 'package:flutter/material.dart';

import './borrowed.dart';
import '../Inventory/Current Inventory/currentInventoryScreen.dart';

class RightAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Inventory Main Page'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Borrowed Items'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(BorrowedItemsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Inventory Items'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CurrentInventoryScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}