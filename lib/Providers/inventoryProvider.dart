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
  ];

class InventoryFunctions with ChangeNotifier{

  List<InventoryItem> get items {
    return [...inventoryItemsList];
  }

  InventoryItem findByItemId(String itemId) {
    return inventoryItemsList.firstWhere((item) => item.itemId == itemId);
  }
  
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

  void deleteProduct(String id) {
    inventoryItemsList.removeWhere((element) => element.equipmentId == id);
    notifyListeners();
  }
}