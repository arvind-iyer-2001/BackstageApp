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
      if(inventoryItem.borrowed == false){
        _borrowedItems.insert(
          0,
          BorrowedItem(
            itemId: inventoryItem.itemId,
            usageId: currentTime.toIso8601String(),
            borrowTimeStamp: currentTime,
            inventoryItem: inventoryItem
          ),
        );
        inventoryItem.log.insert( 
          0,
          ItemLog(
            borrowTime: currentTime,
            returnTime: null,
            usageID: currentTime.toIso8601String(),
            feedback: null
          )
        );
        inventoryItem.borrowed =true;
        notifyListeners();
      }
    });
  }

  void returnItem(BorrowedItem borrowedItem) {
    var currentTime =DateTime.now();
    int itemIndex = inventoryItemsList.indexWhere((element) => element.itemId == borrowedItem.inventoryItem.itemId); 
    
    inventoryItemsList[itemIndex].log [0] = ItemLog(
      borrowTime: borrowedItem.borrowTimeStamp,
      returnTime: currentTime,
      usageID: borrowedItem.usageId,
      feedback: borrowedItem.usageId      
    );
    
    inventoryItemsList[itemIndex] = InventoryItem(
      barcode: inventoryItemsList[itemIndex].barcode,
      equipmentId: inventoryItemsList[itemIndex].equipmentId,
      itemId:  inventoryItemsList[itemIndex].itemId,
      titleSuffix: inventoryItemsList[itemIndex].titleSuffix,
      workingCondition: inventoryItemsList[itemIndex].workingCondition,
      borrowed: false,
      log: inventoryItemsList[itemIndex].log
    );
    _borrowedItems.remove(borrowedItem);
    // Ask if there are any problems with the Item and Update the Item Log
    notifyListeners();
  }
}