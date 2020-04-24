import 'package:flutter/material.dart';

import './equipment.dart';
import './inventoryProvider.dart';

class CartItem with ChangeNotifier {
  @required final String title;
  @required final String barcode;
  @required final String id;
  @required final Category category;
  
  CartItem({
    this.title,
    this.barcode,
    this.id,
    this.category
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  List<InventoryItem> get inventoryItem{
    return inventoryItemsList.where((item) => items.containsKey(item.itemId));
  }
  
  int get itemCount {
    return _items.length;
  }

  List<CartItem> fetchByCategory(Category category){
    var _categoryItems = _items.values.where((cartItem) => cartItem.category == category).toList();
    if(_categoryItems.isEmpty){
      notifyListeners();
      return [];
    }
    if(category == Categories[0]){
      notifyListeners();
      return _items.values.toList();
    }
    notifyListeners();
    return _categoryItems;
  }

  bool checkIfPresent(String id){
    return _items.containsKey(id);
  }

  void addInventoryItemtoCart(
    String title,
    String barcode,
    String itemId,
    Category category
  ) {
    if (!_items.containsKey(itemId)) {
      _items.putIfAbsent(
        itemId,
        () => CartItem(
          id: itemId,
          title: title,
          barcode: barcode,
          category: category
        ),
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
}