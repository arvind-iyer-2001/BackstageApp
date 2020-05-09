import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/inventoryModels.dart';

class Inventory with ChangeNotifier {
  final String itemId;
  Inventory({this.itemId});
  final CollectionReference inventoryCollection = Firestore.instance.collection("Inventory");

  // Get the List of Inventory
  List<InventoryItem> _inventoryFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return InventoryItem(
        barcode: doc.data['Barcode'] as String,
        borrowed: doc.data['Borrowed'] as bool,
        equipmentId: doc.data['Equipment Id'] as String,
        itemId: doc.documentID,
        titleSuffix: doc.data['Title Suffix'] as String,
        workingCondition: doc.data['Working Condition'] as bool
      );
    }).toList();
  }

  // Stream of List of Inventory
  Stream<List<InventoryItem>> get inventory {
    return inventoryCollection.snapshots().map(_inventoryFromSnapshot);
  }

  // Get Inventory Item by Item Id
  InventoryItem _inventoryItemFromSnapshot (DocumentSnapshot doc){
    return InventoryItem(
      barcode: doc.data['Barcode'] as String,
      borrowed: doc.data['Borrowed'] as bool,
      equipmentId: doc.data['Equipment Id'] as String,
      itemId: doc.documentID,
      titleSuffix: doc.data['Title Suffix'] as String,
      workingCondition: doc.data['Working Condition'] as bool
    );
  }

  // Stream of Inventory Item by Item Id
  Stream<InventoryItem> get inventoryItem {
    return inventoryCollection.document(itemId).snapshots().map(_inventoryItemFromSnapshot);
  }

  // Get the List of Borrowed Inventory
  List<InventoryItem> _borrowedInventoryFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      if(doc.data['Borrowed'] == true){
        final inventoryItem = InventoryItem(
          barcode: doc.data['Barcode'] as String,
          borrowed: doc.data['Borrowed'] as bool,
          equipmentId: doc.data['Equipment Id'] as String,
          itemId: doc.documentID,
          titleSuffix: doc.data['Title Suffix'] as String,
          workingCondition: doc.data['Working Condition'] as bool
        );
        

        return inventoryItem;
      }
      return null;
    }).toList();
  }

  // Stream of Borrowed Inventory Items
  Stream<List<InventoryItem>> get borrowedInventoryItems {
    return inventoryCollection.snapshots().map(_borrowedInventoryFromSnapshot);
  }
  
  // Getting Item Log for each Item by ID
  List<ItemLog> _itemLogFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((element) {
      return ItemLog(
        borrowTime: DateTime.parse(element.data['Borrow Time']),
        feedback: element.data['Feedback'] ?? '',
        returnTime: DateTime.parse(element.data['Return Time']),
        borrowUserUid: element.data['Borrowing User'] ?? '',
        returnUserUid: element.data['Returning User'] ?? '',
        usageID: element.documentID,
      );
    }).toList();
  }

  // Stream of Item Log for each Item by ID
  Stream<List<ItemLog>> get itemLog {
    return inventoryCollection.document('$itemId').collection("Item Log").orderBy("Borrow Time",descending: true).snapshots().map(_itemLogFromSnapshots);
  }

  // Add Inventory Item to Inventory Firestore
  Future addInventoryItem(
    InventoryItem inventoryItem
  ) async {
    await inventoryCollection.document(inventoryItem.barcode).setData({
      'Barcode': inventoryItem.barcode,
      'Borrowed': false,
      'Equipment Id': inventoryItem.equipmentId,
      'Title Suffix': inventoryItem.titleSuffix,
      'Working': inventoryItem.workingCondition,
    });
    inventoryCollection.document(inventoryItem.barcode).collection("Item Log").add({
      'Add Time': DateTime.now().toIso8601String()
    });
    notifyListeners();
  }
  
  // Update Inventory Item in Inventory Firestore
  Future updateInventoryItemData(
    InventoryItem inventoryItem
  ) async {
    await inventoryCollection.document(itemId).updateData({
      'Barcode': inventoryItem.barcode,
      'Equipment Id': inventoryItem.equipmentId,
      'Title Suffix': inventoryItem.titleSuffix,
      'Working': inventoryItem.workingCondition,
    });
    notifyListeners();
  }
  
  // Delete Inventory Item in Inventory Firestore
  Future deleteInventoryItem() async {
    await inventoryCollection.document(itemId).delete();
    notifyListeners();
  }

  // Updating Borrow Status in Inventory Firestore
  Future borrowingItems(
    List<InventoryItem> inventoryItemsFromCart, String feedback, String borrowingUserUid
  ) async {
    inventoryItemsFromCart.forEach((element) async {
      final CollectionReference itemLogCollection = Firestore.instance.collection('Inventory').document(element.itemId).collection("Item Log");
      await inventoryCollection.document(element.itemId).updateData({
        'Borrowed': true,
      }).then((_) async {
        final currentTime = DateTime.now();
        int currentLength = (await Firestore.instance.collection('Inventory/${element.itemId}/Item Log').reference().getDocuments()).documents.length;
        await itemLogCollection.document('Log -${currentLength + 1}').setData({
          'Borrow Time': currentTime.toIso8601String(),
          'Borrowing User': borrowingUserUid,
          'Borrow Feedback': feedback,
          'Return Time': currentTime.toIso8601String(),
          'Returning User': ' ',
          'Feedback': ' '
        });
      }).then((_) {

      });
    });
  }

  Future returningingItem(
    InventoryItem borrowedItem,
    String feedback,
    String retruningUserUid
  ) async {
    final currentTime =DateTime.now();
    final CollectionReference itemLogCollection = Firestore.instance.collection('Inventory').document(borrowedItem.itemId).collection("Item Log");

    int currentLength = (await Firestore.instance.collection('Inventory/${borrowedItem.itemId}/Item Log').reference().getDocuments()).documents.length;
    
    await inventoryCollection.document(borrowedItem.itemId).updateData({
      'Borrowed': false
    }).then((_) async {
      await itemLogCollection.document('Log -$currentLength').updateData({
        'Return Time': currentTime.toIso8601String(),
        'Returning User': retruningUserUid,
        'Feedback': feedback
      });
    });
  }
}