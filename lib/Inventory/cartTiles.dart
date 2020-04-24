import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cartProvider.dart';
import '../Providers/equipment.dart';

class CartTiles extends StatelessWidget {
  CartTiles({
    @required this.cart,
    @required this.currentCategory
  });

  final Cart cart;
  final Category currentCategory;

  @override
  Widget build(BuildContext context) {
    final cartItem = cart.fetchByCategory(currentCategory);
    return Container(
      child: ListView.builder(
        itemCount: cartItem.length,
        itemBuilder: (ctx ,index) => Dismissible(
          key: ValueKey(cartItem[index].id),
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
            Provider.of<Cart>(context, listen: false).removeItem(cartItem[index].id);
          },
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                title: Text(cartItem[index].title),
                trailing: Text(cartItem[index].barcode),
              ),
            ),
          ),
        )
      ),
    );
  }
}
