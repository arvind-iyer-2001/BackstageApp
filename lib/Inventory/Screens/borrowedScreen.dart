import 'package:flutter/material.dart';

import '../Widgets/borrowedList.dart';
import '../Widgets/inventoryAppDrawer.dart';
import '../inventoryHomeScreen.dart';

class BorrowedScreen extends StatelessWidget {
  static const routeName = 'Borrowed Screen';

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
                      Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.routeName);
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
        endDrawer: RightAppDrawer(),
        appBar: AppBar(
          title: const Text('Borrowed Items'),
        ),

        body: BorrowedList()      
      ),
    );
  }
}