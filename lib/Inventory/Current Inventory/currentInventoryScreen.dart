//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './currentInventoryTile.dart';
import '../../Providers/cartProvider.dart';
import '../../Supplementary%20Widgets/badge.dart';
import '../checkOutCartScreen.dart';
import '../appDrawer.dart';
import './editInventory.dart';

enum SortByCategory {
  All,
  Borrowed,
  Free,
  InComission,
  OutOfComission,
  Missing
}

class CurrentInventoryScreen extends StatelessWidget {
  static const routeName = 'Current Inventory Screen';

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
      child: Scaffold(
        endDrawer: RightAppDrawer(),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditInventory.routeName);
          },
          child: Text(
            'Add\nItem',
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),

        appBar: AppBar(
          title: const Text('Current Inventory'),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (ctx, cart, child) => Badge(
                child: FlatButton.icon(
                  label: Text(
                    'Cart',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  icon: Icon(
                    Icons.shopping_basket,
                    color: Colors.white
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CheckOutScreen.routeName);
                  },
                  onLongPress: () {
                    return showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        title: new Text('Are you sure?'),
                        content: new Text('Do you want to exit an App'),
                        actions: <Widget>[
                          new GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text("NO"),
                          ),
                          SizedBox(height: 16),
                          new GestureDetector(
                            onTap: () {
                              cart.clear();
                              Navigator.of(context).pop(true);
                            } ,
                            child: Text("YES"),
                          ),
                        ],
                      ),
                    ) ?? false;
                    
                  },
                ),
                value: cart.itemCount.toString(),
                color: Colors.red,
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.category),
              initialValue: SortByCategory.All,
              onSelected: (_) {

              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Show All'),
                  value: SortByCategory.All
                ),
                PopupMenuItem(
                  child: Text('Show Borrowed'),
                  value: SortByCategory.Borrowed
                ),
                PopupMenuItem(
                  child: Text('Show Available'),
                  value: SortByCategory.Free
                ),
                PopupMenuItem(
                  child: Text('Show Working'),
                  value: SortByCategory.InComission
                ),
                PopupMenuItem(
                  child: Text('Show Out of Comission'),
                  value: SortByCategory.OutOfComission
                ),
                PopupMenuItem(
                  child: Text('Show Missing'),
                  value: SortByCategory.OutOfComission
                ),
              ]
            )
          ],

        ),
        drawer: Drawer(),
        body: _isLoading
        ? Center(
          child: CircularProgressIndicator(),
        )
        : CurrentInventoryTiles()
              
      ),
    );
  }
}
      
