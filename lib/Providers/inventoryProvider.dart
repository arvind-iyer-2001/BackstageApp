import 'package:flutter/material.dart';

class ItemLog {
  final DateTime borrowTime;
  final DateTime returnTime;
  final String usageID;
  final String feedback;
  // final User borrowUser;
  // final User returnUser;
  // final Event event;

  ItemLog({
    this.borrowTime,
    this.returnTime,
    this.usageID,
    this.feedback
    // this.borrowUser,
    // this.returnUser,
    // this.event,
  });
}

class InventoryItem with ChangeNotifier{
  @required final String barcode;
  @required final String titleSuffix;
  @required final String equipmentId;
  @required final String itemId;
  @required bool workingCondition;
  bool borrowed;
  List<ItemLog> log;


  InventoryItem({
    this.barcode,
    this.equipmentId,
    this.itemId,
    this.titleSuffix,
    this.workingCondition,
    this.borrowed,
    this.log
  });

}

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

List<InventoryItem> inventoryItemsList = [
    InventoryItem(
      barcode: "M-111-111",
      equipmentId: "eId01",
      itemId: "M-111-111",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false,
      log: [],
    ),
    InventoryItem(
      barcode: "M-111-112",
      equipmentId: "eId02",
      itemId: "M-111-112",
      titleSuffix: "",
      workingCondition: false,
      borrowed: false,
      log: [],
    ),
    InventoryItem(
      barcode: "M-111-113",
      equipmentId: "eId03",
      itemId: "M-111-113",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false,
      log: [],
    ),
    InventoryItem(
      barcode: "M-111-114",
      equipmentId: "eId02",
      itemId: "M-111-114",
      titleSuffix: "",
      workingCondition: false,
      borrowed: false,
      log: [],
    ),
    InventoryItem(
      barcode: "M-111-115",
      equipmentId: "eId01",
      itemId: "M-111-115",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false,
      log: [],
    ),
    InventoryItem(
      barcode: "8902519010438",
      equipmentId: "eId04",
      itemId: "M-111-117",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false,
      log: [],
    ),
  ];

class InventoryFunctions with ChangeNotifier{
  // Inventory Functions
  List<InventoryItem> get items {
    return [...inventoryItemsList];
  }

  // Find by ID
  InventoryItem findByItemId(String itemId) {
    return items.firstWhere((item) => item.itemId == itemId);
  }

  // Find by Barcode
  InventoryItem findByBarcode(String barcode) {
    return items.firstWhere((item) => item.barcode == barcode) ?? null;
  }

  // Add Item to Inventory
  void addInventoryItems(InventoryItem inventoryItem) {
    final newInventoryItem = InventoryItem(
      barcode: inventoryItem.barcode,
      equipmentId: inventoryItem.equipmentId,
      itemId: DateTime.now().toString(),
      titleSuffix: inventoryItem.titleSuffix,
      workingCondition: true,
      borrowed: false,
      log: [], 
    );
    inventoryItemsList.add(newInventoryItem);
    notifyListeners();
  }

  // Update an Item in the Inventory
  void updateInventoryItem(String itemId, InventoryItem editedInventoryItem) {
    var index = inventoryItemsList.indexWhere((element) => element.itemId == itemId);
    inventoryItemsList[index] = InventoryItem(
      barcode: editedInventoryItem.barcode,
      equipmentId: editedInventoryItem.equipmentId,
      itemId: itemId,
      titleSuffix: editedInventoryItem.titleSuffix,
      workingCondition: editedInventoryItem.workingCondition,
      borrowed: inventoryItemsList[index].borrowed,
      log: inventoryItemsList[index].log, 
    );
    notifyListeners();
  }

  // Delete an Item in the Inventory
  void deleteProduct(String id) {
    inventoryItemsList.removeWhere((element) => element.equipmentId == id);
    notifyListeners();
  }  

  
  List<BorrowedItem> _borrowedItems = [];

  List<BorrowedItem> get borrowedItems {
    return [..._borrowedItems];
  }
  
  // Add Item to Borrow List and Borrow Item
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
            returnTime: DateTime.utc(2010),
            usageID: currentTime.toIso8601String(),
            feedback: null
          )
        );
        inventoryItem.borrowed =true;
        notifyListeners();
      }
    });
  }

  // Remove Item from Borrow List and to Return Item
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