import 'package:flutter/material.dart';

import './inventoryProvider.dart';

class BorrowedItem with ChangeNotifier{
  final String itemId;
  final InventoryItem inventoryItem;
  final DateTime borrowTimeStamp;
  final String usageId;
  // final String uidUserStamp;

  BorrowedItem({
    this.itemId,
    this.inventoryItem,
    this.borrowTimeStamp,
    this.usageId
    // this.uidUserStamp
  });
}

class BorrowReturn with ChangeNotifier {
  List<BorrowedItem> _borrowedItems = [];

  List<BorrowedItem> get borrowedItems {
    return [..._borrowedItems];
  }

  void borrowItem(List<InventoryItem> inventoryItemsFromCart) {
    var currentTime =DateTime.now();
    inventoryItemsFromCart.forEach((inventoryItem) {
      _borrowedItems.insert(
        0,
        BorrowedItem(
          itemId: inventoryItem.itemId,
          usageId: currentTime.toIso8601String(),
          borrowTimeStamp: currentTime,
          inventoryItem: inventoryItem
        ),
      );
      inventoryItem.borrowed =true;
      notifyListeners();
    });
  }

  void returnItem(BorrowedItem borrowedItem) {
    var currentTime =DateTime.now();
      borrowedItem.inventoryItem.log.insert( 
        0,
        ItemLog(
          borrowTime: borrowedItem.borrowTimeStamp,
          returnTime: currentTime,
          usageID: borrowedItem.usageId
        )
      );
      borrowedItem.inventoryItem.borrowed =false;
      _borrowedItems.remove(borrowedItem);

      // Ask if there are any problems with the Item and Update the Item Log
      notifyListeners();
  }
}