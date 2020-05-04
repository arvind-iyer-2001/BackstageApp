import 'package:backstage/Models/inventoryModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {

  final String uid;
  Cart({this.uid});

  Map<String, InventoryItem> _items = {};

  Map<String, InventoryItem> get items {
    return {..._items};
  }

  void addInventoryItemtoCart(
    InventoryItem inventoryItem
  ) {
    if (!_items.containsKey(inventoryItem.itemId)) {
      _items.putIfAbsent(
        inventoryItem.itemId,
        () => inventoryItem,
      );
    }
    notifyListeners();
  }
  
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }


  final CollectionReference cartCollection = Firestore.instance.collection('Cart');

  List<String> _cartIdListFromSnapshot(DocumentSnapshot doc){
    final List<String> inventoryItemIds = List<String>.from(doc.data["Personal Cart"]);
    return inventoryItemIds;
  }

  Stream<List<String>> get cartIdList{
    return cartCollection.document(uid).snapshots().map(_cartIdListFromSnapshot);
  }

  final CollectionReference inventoryCollection = Firestore.instance.collection("Inventory");

  List<InventoryItem> _cartListFromSnapshot(DocumentSnapshot document){
    List<InventoryItem> inventoryItems = [];
    _cartIdListFromSnapshot(document).forEach((itemId) async {
      await inventoryCollection.document(itemId).get().then((doc){
        var inventoryItem = InventoryItem(
          barcode: doc.data['Barcode'] as String,
          borrowed: doc.data['Borrowed'] as bool,
          equipmentId: doc.data['Equipment Id'] as String,
          itemId: doc.documentID,
          titleSuffix: doc.data['Title Suffix'] as String,
          workingCondition: doc.data['Working Condition'] as bool
        );
        inventoryItems.add(inventoryItem);
      });
    });
    return inventoryItems;
  }

  Stream<List<InventoryItem>> get cartList{
    return cartCollection.document(uid).snapshots().map(_cartListFromSnapshot);
  }

  Future addToCart(
    InventoryItem inventoryItem, DocumentSnapshot doc
  ) async {
    List<String> currentList = _cartIdListFromSnapshot(doc);
    currentList.add(inventoryItem.itemId);
    await cartCollection.document(uid).setData({
      'Personal Cart': currentList
    });
    
    notifyListeners();
  }

  Future removeFromCart(
    InventoryItem inventoryItem, DocumentSnapshot doc
  ) async {
    List<String> currentList = _cartIdListFromSnapshot(doc);
    currentList.remove(inventoryItem.itemId);
    await cartCollection.document(uid).setData({
      'Personal Cart': currentList
    });
    notifyListeners();
  }

  Future clearCart(
  ) async {
    await cartCollection.document(uid).setData({
      'Personal Cart': []
    });
  }
}