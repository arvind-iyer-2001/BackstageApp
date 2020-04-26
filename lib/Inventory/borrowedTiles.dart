import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/equipment.dart';
import '../Providers/borrow&return.dart';

class BorrowedTiles extends StatelessWidget {
  final BorrowedItem borrowedItem;

  BorrowedTiles(this.borrowedItem);

  @override
  Widget build(BuildContext context) {
    var title = Provider.of<EquipmentFunctions>(context).equipmentItems.firstWhere((test) => test.equipmentId ==borrowedItem.inventoryItem.equipmentId).title;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Dismissible(
            background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Provider.of<Cart>(context, listen: false).removeItem(cartItem[index].id);
          },
            key: ValueKey(borrowedItem.usageId),
            child: ListTile(
              title: Text(title),
              subtitle:Text(borrowedItem.inventoryItem.barcode),
              trailing:  Text(
                'Borrow Time\n${DateFormat('dd/MM/yyyy hh:mm').format(borrowedItem.borrowTimeStamp)}',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

          
