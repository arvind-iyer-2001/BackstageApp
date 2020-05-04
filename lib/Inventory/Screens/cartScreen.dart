import 'package:backstage/Models/userModels.dart';

import '../Widgets/barcodeScan.dart';
import '../Widgets/cartTiles.dart';
import '../../Models/inventoryModels.dart';
import '../../Providers&Services/cart.dart';
import '../../Providers&Services/inventory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'borrowedScreen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'Cart Screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final device = MediaQuery.of(context);
    // var isLandscape = device.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out Contents"),
        actions: <Widget>[
          BarcodeScanner()
        ],
      ),
      body: Container(
        height: device.size.height - AppBar().preferredSize.height -device.padding.top - 20,
        width: device.size.width ,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Borrow Items"),
              onPressed: () async {
                await Inventory().borrowingItems(
                  List<InventoryItem>.from(cart.items.values.where((element) => element.borrowed == false)), "Event Details to be Accepted", "${Provider.of<User>(context,listen: false).uid}"
                );
                cart.clear();
                Navigator.of(context).popAndPushNamed(BorrowedScreen.routeName);
              },
            ),

            Expanded(child: CartTiles(cart: cart))
          ],
        ),
      )
    );
  }
}