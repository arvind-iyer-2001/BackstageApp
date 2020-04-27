import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './inventoryHomePage.dart';

import 'package:backstage/Providers/cartProvider.dart';
import 'package:backstage/Providers/inventoryProvider.dart';


class ScannedPage extends StatelessWidget {
  static const routeName = 'Scanned Page';

  @override
  Widget build(BuildContext context) {
    final barcode = ModalRoute.of(context).settings.arguments;
    final inventoryItem = Provider.of<InventoryFunctions>(context).
    final cart = Provider.of<Cart>(context).addInventoryItemtoCart(title, barcode, itemId, category)
    return WillPopScope(
      onWillPop: () => Navigator.of(context).popAndPushNamed(InventoryHomeScreen.routeName),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inventory"),
        ),
        body: Center(
          child: Text(barcode ?? 'Barcode not valid'),
        ),
      ),
    );
  }
}