import 'package:flutter/material.dart';

import './inventoryProvider.dart';

class BorrowedItem with ChangeNotifier{
  final String itemId;
  final InventoryItem inventoryItem;
  final DateTime borrowTimeStamp;
  final String borrowId;
  // final String uidUserStamp;

  BorrowedItem({
    this.itemId,
    this.inventoryItem,
    this.borrowTimeStamp,
    this.borrowId
    // this.uidUserStamp
  });
}

class ReturnedItem with ChangeNotifier{
  final String itemId;
  final InventoryItem inventoryItem;
  final DateTime borrowTimeStamp;
  final String borrowId;
  // final String uidUserStamp;

  ReturnedItem({
    this.itemId,
    this.inventoryItem,
    this.borrowTimeStamp,
    this.borrowId
    // this.uidUserStamp
  });
}



class Borrow with ChangeNotifier {
  List<BorrowedItem> _borrowedItems = [];

  List<BorrowedItem> get borrowedItems {
    return [..._borrowedItems];
  }

  void borrowItem(List<InventoryItem> inventoryItems) {
    var currentTime =DateTime.now();
    inventoryItems.forEach((inventoryItem) {
      _borrowedItems.insert(
        0,
        BorrowedItem(
          itemId: inventoryItem.itemId,
          borrowId: currentTime.toIso8601String(),
          borrowTimeStamp: currentTime,
          inventoryItem: inventoryItem
        ),
      );
      inventoryItem.borrowed =true;
      notifyListeners();
    });
  }
}

class Return with ChangeNotifier {
  List<ReturnedItem> _returnedItems = [];

  List<ReturnedItem> get returnedItems {
    return [..._returnedItems];
  }

  void returnItem(List<InventoryItem> inventoryItems, double total) {
    var currentTime =DateTime.now();
    inventoryItems.forEach((inventoryItem) {
      _returnedItems.insert(
        0,
        ReturnedItem(
          itemId: inventoryItem.itemId,
          borrowId: currentTime.toIso8601String(),
          borrowTimeStamp: currentTime,
          inventoryItem: inventoryItem
        ),
      );
      notifyListeners();

    });
  }
}


