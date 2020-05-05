import 'package:backstage/Inventory/Screens/inventoryDetails.dart';
import 'package:backstage/Models/inventoryModels.dart';
import 'package:flutter/material.dart';

class ListTiles extends StatelessWidget {
  ListTiles({
    @required this.equipment,
    @required this.inventory,
    @required this.index
  });

  final EquipmentItem equipment;
  final List<InventoryItem> inventory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Container(
        child: ListTile(
          title: Text(equipment.title),
          leading: CircleAvatar(
            child: Hero(
              tag: '${inventory[index].itemId} - 0',
              child: FadeInImage(
                placeholder: AssetImage('assets/images/micPlaceholder.jpg'),
                image: NetworkImage(equipment.imageUrl[0]) ?? null,
                fit: BoxFit.cover,
                fadeInCurve: Curves.bounceIn,
                fadeInDuration: Duration(milliseconds: 200),
                fadeOutDuration: Duration(milliseconds: 100),
              ),
            ),
            backgroundColor: Colors.blue[300],
          ),
          subtitle: Text(inventory[index].barcode),
          trailing: CircleAvatar(
            backgroundColor: inventory[index].borrowed
            ? Colors.red
            : Colors.green,
            child: Icon(
              inventory[index].borrowed
              ? Icons.cancel
              : Icons.check,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(InventoryDetailsScreen.routeName, arguments: inventory[index].itemId);
          },
        ),
      ),
    );
  }
}