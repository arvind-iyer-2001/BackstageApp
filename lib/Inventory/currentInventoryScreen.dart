import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './currentInventoryTile.dart';
import '../Providers/cartProvider.dart';
import '../Supplementary%20Widgets/badge.dart';
import './checkOutCartScreen.dart';

enum SortByCategory {
  All,
  XLR,
  MIC,
  DI,
  TS55,
  TS3535,
  MICSTAND,
  SPEAKON
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
                  child: Text('Sort by XLRs'),
                  value: SortByCategory.XLR
                ),
                PopupMenuItem(
                  child: Text('Sort by MICs'),
                  value: SortByCategory.XLR
                ),
                PopupMenuItem(
                  child: Text('Sort by DI Boxes'),
                  value: SortByCategory.DI
                ),
                PopupMenuItem(
                  child: Text('Sort by TS 5-5 Cables'),
                  value: SortByCategory.TS55
                ),
                PopupMenuItem(
                  child: Text('Sort by TS 3.5-3.5mm Cables'),
                  value: SortByCategory.TS3535
                ),
                PopupMenuItem(
                  child: Text('Sort by Mic Stands'),
                  value: SortByCategory.MICSTAND
                ),
                PopupMenuItem(
                  child: Text('Sort by Speak-On Cables'),
                  value: SortByCategory.SPEAKON
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
      
