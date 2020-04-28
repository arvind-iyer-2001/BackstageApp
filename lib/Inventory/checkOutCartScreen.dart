import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cartTiles.dart';

import './barcodeScan.dart';
import './borrowed.dart';
import '../Providers/inventoryProvider.dart';
import '../Providers/equipment.dart';
import '../Providers/cartProvider.dart';


class CheckOutScreen extends StatefulWidget {
  static const routeName = 'Check Out Screen';

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  Category _currentCategory = Categories[0];

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Check Out Contents"),
      actions: <Widget>[
        BarcodeScanner()
      ],
    );
    final cart = Provider.of<Cart>(context);
    final device = MediaQuery.of(context);
    // var isLandscape = device.orientation == Orientation.landscape;
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: device.size.height - appBar.preferredSize.height -device.padding.top - 20,
        width: device.size.width ,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Borrow Items"),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to borrow these Items?'),

                    actions: <Widget>[
                      new GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text("NO"),
                      ),
                      SizedBox(height: 16),
                      new GestureDetector(
                        onTap: () {
                          Provider.of<InventoryFunctions>(context, listen: false).borrowItem(
                            cart.inventoryItem
                          );
                          cart.clear();
                          Navigator.of(context).pushReplacementNamed(BorrowedItemsScreen.routeName);
                        } ,
                        child: Text("YES"),
                      ),
                    ],
                  ),
                );
              },
            ),

            Container(
              width: device.size.width - 30,
              child: DropdownButtonFormField( 
                value: _currentCategory,
                items: Categories.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.title)
                  );
                }).toList(),
                onChanged: (val) => setState( () => _currentCategory = val ),
              ),
            ),

            Expanded(child: CartTiles(cart: cart,currentCategory: _currentCategory,))
          ],
        ),
      )
    );
  }
}

