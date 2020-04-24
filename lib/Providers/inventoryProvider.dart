import 'package:flutter/material.dart';

class InventoryItem with ChangeNotifier{
  @required final String barcode;
  @required final String titleSuffix;
  @required final String equipmentId;
  @required final String itemId;
  @required bool workingCondition;
  bool borrowed;

  InventoryItem({
    this.barcode,
    this.equipmentId,
    this.itemId,
    this.titleSuffix,
    this.workingCondition,
    this.borrowed
  });

}

List<InventoryItem> inventoryItemsList = [
    InventoryItem(
      barcode: "M-111-111",
      equipmentId: "eId01",
      itemId: "M-111-111",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false
    ),
    InventoryItem(
      barcode: "M-111-112",
      equipmentId: "eId02",
      itemId: "M-111-112",
      titleSuffix: "",
      workingCondition: false,
      borrowed: false
    ),
    InventoryItem(
      barcode: "M-111-113",
      equipmentId: "eId03",
      itemId: "M-111-113",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false
    ),
    InventoryItem(
      barcode: "M-111-114",
      equipmentId: "eId02",
      itemId: "M-111-114",
      titleSuffix: "",
      workingCondition: false,
      borrowed: false
    ),
    InventoryItem(
      barcode: "M-111-115",
      equipmentId: "eId01",
      itemId: "M-111-115",
      titleSuffix: "",
      workingCondition: true,
      borrowed: false
    ),
  ];

class InventoryFunctions with ChangeNotifier{
  

  List<InventoryItem> get items {
    return [...inventoryItemsList];
  }

  InventoryItem findByItemId(String itemId) {
    return inventoryItemsList.firstWhere((item) => item.itemId == itemId);
  }
  
  void addInventoryItems() {
    
  }
}