import 'package:flutter/material.dart';

class InventoryItem with ChangeNotifier{
  @required final String barcode;
  @required final String titleSuffix;
  @required final String equipmentId;
  @required final String itemId;
  @required final bool workingCondition;

  InventoryItem({
    this.barcode,
    this.equipmentId,
    this.itemId,
    this.titleSuffix,
    this.workingCondition
  });

}

class InventoryFunctions with ChangeNotifier{
  final List<InventoryItem> _inventoryItems = [
    InventoryItem(
      barcode: "M-111-111",
      equipmentId: "eId01",
      itemId: "M-111-111",
      titleSuffix: "",
      workingCondition: true
    ),
    InventoryItem(
      barcode: "M-111-112",
      equipmentId: "eId02",
      itemId: "M-111-112",
      titleSuffix: "",
      workingCondition: false
    ),
    InventoryItem(
      barcode: "M-111-113",
      equipmentId: "eId03",
      itemId: "M-111-113",
      titleSuffix: "",
      workingCondition: true
    ),
    InventoryItem(
      barcode: "M-111-114",
      equipmentId: "eId02",
      itemId: "M-111-114",
      titleSuffix: "",
      workingCondition: false
    ),
    InventoryItem(
      barcode: "M-111-115",
      equipmentId: "eId01",
      itemId: "M-111-115",
      titleSuffix: "",
      workingCondition: true
    ),
  ];

  List<InventoryItem> get items {
    return [..._inventoryItems];
  }

  InventoryItem findByItemId(String itemId) {
    return _inventoryItems.firstWhere((item) => item.itemId == itemId);
  }
  
  void addInventoryItems() {
    
  }
}