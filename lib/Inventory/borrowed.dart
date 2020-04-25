import 'package:backstage/Inventory/borrowedTiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/borrow&return.dart';

class BorrowedItemsScreen extends StatelessWidget {
  static const routeName = 'Borrowed Items Screen';

  @override
  Widget build(BuildContext context) {
    final borrowReturn = Provider.of<BorrowReturn>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: Drawer(),
      body: ListView.builder(
        itemCount: borrowReturn.borrowedItems.length,
        itemBuilder: (ctx, index) => BorrowedTiles(borrowReturn.borrowedItems[index]),
      ),
    );
  }
}
