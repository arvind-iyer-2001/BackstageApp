import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/borrow&return.dart';
import './borrowedTiles.dart';
import './appDrawer.dart';

class BorrowedItemsScreen extends StatelessWidget {
  static const routeName = 'Borrowed Items Screen';

  @override
  Widget build(BuildContext context) {
    final borrowReturn = Provider.of<BorrowReturn>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      endDrawer: RightAppDrawer(),
      body: ListView.builder(
        itemCount: borrowReturn.borrowedItems.length,
        itemBuilder: (ctx, index) => BorrowedTiles(borrowReturn.borrowedItems[index]),
      ),
    );
  }
}
