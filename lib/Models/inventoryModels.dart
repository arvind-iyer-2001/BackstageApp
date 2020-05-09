import 'package:flutter/material.dart';

class EquipmentItem with ChangeNotifier {
  @required final String title;
  @required List<String> categoryId;
  @required List<String> imageUrl;
  @required List<String> description;
  @required final String equipmentId;

  EquipmentItem({
    this.title,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.equipmentId
  });
}

class ItemLog with ChangeNotifier{
  final DateTime borrowTime;
  final DateTime returnTime;
  final String usageID;
  final String feedback;
  final String borrowUserUid;
  final String returnUserUid;
  // final Event event;

  ItemLog({
    this.borrowTime,
    this.returnTime,
    this.usageID,
    this.feedback,
    this.borrowUserUid,
    this.returnUserUid,
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