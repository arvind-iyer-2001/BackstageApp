import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Current Inventory/inventoryDetails.dart';

import '../../Providers/inventoryProvider.dart';
import '../../Providers/equipment.dart';
import '../../Providers/cartProvider.dart';


class CurrentInventoryTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<InventoryFunctions>(context).items;
    final equipment = Provider.of<EquipmentFunctions>(context);
    return ListView.builder(
      itemCount: inventory.length,
      itemBuilder:(ctx, index) => ChangeNotifierProvider.value(
        value: inventory[index],
        child: Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 10,
            margin: EdgeInsets.all(5),
            child: Consumer<Cart>(
              builder: (ctx, cart, child) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    InventoryDetail.routeName,
                    arguments: inventory[index].itemId,
                  );
                },
                onDoubleTap: () {
                  // Add to Check-Out Cart
                  cart.addInventoryItemtoCart(
                    equipment.findByItemId(inventory[index].equipmentId).title,
                    inventory[index].barcode,
                    inventory[index].itemId,
                    Categories.firstWhere((category) => category.id == equipment.findByItemId(inventory[index].equipmentId).categoryId[0]),
                  );
                  // Removes the current Snackbar
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${equipment.findByItemId(inventory[index].equipmentId).title} has been added to the Check Out'),
                      )
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                  ),
                  title: Text(equipment.findByItemId(inventory[index].equipmentId).title),
                  subtitle: Text(inventory[index].barcode),
                  trailing: inventory[index].workingCondition
                    ? CircleAvatar(
                      backgroundColor: Colors.green[900],
                      radius: 15,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    )
                    : CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 15,
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    )              
                  
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}