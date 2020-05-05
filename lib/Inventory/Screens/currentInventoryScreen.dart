import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/cartScreen.dart';
import '../Widgets/currentInventoryTile.dart';
import '../Widgets/inventoryAppDrawer.dart';
import '../Widgets/barcodeScan.dart';
import '../../SupplementaryWidgets/badge.dart';
import '../../Providers&Services/cart.dart';
import '../inventoryHomeScreen.dart';

class CurrentInventoryScreen extends StatelessWidget {
  static const routeName = 'Current Inventory Screen';

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
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.of(context).pushNamed(EditInventory.routeName);
          },
          icon: Icon(Icons.add),
          label: Text(
            'Add\nItem',
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),

        appBar: AppBar(
          title: const Text('Current Inventory'),
          actions: <Widget>[
            BarcodeScanner(),
            Consumer<Cart>(
              builder: (ctx, cart, child)=> Badge(
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
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  onLongPress: () {
                    cart.clear();
                  },
                ),
                value: cart.items.length.toString(),
                color: Colors.green,
              ),
            ),
          ],
        ),

        body: CurrentInventoryList()      
      ),
    );
  }
}