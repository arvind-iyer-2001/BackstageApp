import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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

  BuildContext context;

  List<InventoryItem> get inventoryItem{
    // Provider.of<InventoryFunctions>(context).items;
    return inventoryItemsList.where((item) => items.containsKey(item.itemId)).toList();
  }
  
  int get itemCount {
    return _items.length;
  }

  List<CartItem> fetchByCategory(Category category){
    var _categoryItems = _items.values.where((cartItem) => cartItem.category == category).toList();
    if(_categoryItems.isEmpty){
      return [];
    }
    if(category == Categories.firstWhere((e) => e.id == 'mc00')){
      return _items.values.toList();
    }
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