
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Current%20Inventory/editInventory.dart';
import './Current%20Inventory/inventoryDetails.dart';
import './checkOutCartScreen.dart';
import './inventoryHomePage.dart';
import '../Providers/cartProvider.dart';
import '../Providers/equipment.dart';
import '../Providers/inventoryProvider.dart';

class ScannedPage extends StatelessWidget {
  static const routeName = 'Scanned Page';

  @override
  Widget build(BuildContext context) {
    final barcode = ModalRoute.of(context).settings.arguments;
    final inventoryFunctions = Provider.of<InventoryFunctions>(context);
    final equipmentFunctions = Provider.of<EquipmentFunctions>(context);
    final index = inventoryFunctions.items.indexWhere((element) => element.barcode == barcode);

    if(index >=0){
      // Implies that Barcode is in the Database
      final inventoryItem = inventoryFunctions.items[index];
      final equipmentItem = equipmentFunctions.equipmentItems.firstWhere((element) => element.equipmentId == inventoryItem.equipmentId);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            barcode,
            softWrap: true,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Item has been found",
                style: TextStyle(
                  color: Colors.amber,
                  backgroundColor: Colors.purple,
                  fontSize: 20
                ),
              ),
              Text(
                equipmentItem.title +"\n"+inventoryItem.titleSuffix,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  backgroundColor: Colors.purple,
                  fontSize: 40
                ),
              ),
              FlatButton.icon(
                color: Colors.purple,
                label: Text(
                  "Go to Item",
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(InventoryDetail.routeName, arguments: inventoryItem.itemId );
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !inventoryItem.borrowed
      ? Consumer<Cart>(
        builder: (ctx, cart, child) =>FloatingActionButton.extended(
          label: Text(
            "Add to Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w200
            ),
          ),
          onPressed: () {
            cart.addInventoryItemtoCart(
              equipmentItem.equipmentId,
              inventoryItem.barcode,
              inventoryItem.itemId,
              Categories.firstWhere((category) => category.id == equipmentItem.categoryId[0]),
            );

            // Removes the current Snackbar
            Navigator.of(context).pushReplacementNamed(CheckOutScreen.routeName);
            
          },
        )
      ) : null,
      );
    }
    // Barcode not in Database

    return Scaffold(
      appBar: AppBar(
        title: Text(
          barcode,
          softWrap: true,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 40,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This Barcode does not exist in our Database",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),

                SizedBox(height: 20,),

                Text(
                  "Would You Like To Add It To The Database with an Inventory Item",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),

                SizedBox(height: 50,),

                Container(
                  height:300,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        EditInventory.routeName,
                        arguments: InventoryItem(
                          barcode: barcode,
                          equipmentId: '',
                          itemId: null,
                          titleSuffix: "",
                          workingCondition: true,
                          borrowed: false,
                          log: [],
                        ),
                      );
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                
                Container(
                  height: 100,
                  width: double.infinity,
                  
                  color: Colors.purple,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.routeName);
                    },
                    child: Text('No'),
                  ),
                )


              ],
            ),
          ),
        ),
      ),

    );

    
  }
}
