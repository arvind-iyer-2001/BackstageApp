import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:backstage/Providers/inventoryProvider.dart';

class ItemLogDisplay extends StatelessWidget {
  final String itemId;

  ItemLogDisplay(this.itemId);
  @override
  Widget build(BuildContext context) {
    final inventoryItem = Provider.of<InventoryFunctions>(context).items.firstWhere((element) => element.itemId == itemId);
    final itemLog = inventoryItem.log;
    return Container(
      child: ListView.builder(
        itemCount: itemLog.length,
        itemBuilder: (ctx, index) => Card(
          elevation: 5,
          child: Container(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(DateFormat('dd/MM/yyyy hh:mm').format(itemLog[index].borrowTime) ?? '                     '),
                ),
                // Container(
                //   child: Text('${itemLog[index].usageID}'),
                // ),
                Container(
                  child: itemLog[index].returnTime.isAfter(itemLog[index].borrowTime)
                  ? Text(DateFormat('dd/MM/yyyy hh:mm').format(itemLog[index].returnTime))
                  : Text("Yet to be returned"),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}