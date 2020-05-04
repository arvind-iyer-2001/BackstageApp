import 'package:backstage/Models/inventoryModels.dart';
import 'package:backstage/Providers&Services/cart.dart';
import 'package:backstage/Providers&Services/equipment.dart';
import 'package:flutter/material.dart';

class CartTiles extends StatelessWidget {
  CartTiles({
    @required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final cartList = List<InventoryItem>.from(cart.items.values);
    // final cartItem = cart.items.; // .fetchByCategory(currentCategory);
    return Container(
      child: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (ctx ,index) => Dismissible(
          key: ValueKey(cartList[index].itemId),
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
            cart.removeItem(cartList[index].itemId);
          },
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                title: StreamBuilder<EquipmentItem>(
                  stream: Equipments(equipmentId: cartList[index].equipmentId).equipment,
                  builder: (context, snapshot) {
                    return Text(snapshot.data.title);
                  }
                ),
                trailing: Text(cartList[index].barcode),
              ),
            ),
          ),
        )
      ),
    );
  }
}
