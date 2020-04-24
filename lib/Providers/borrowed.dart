import 'package:flutter/material.dart';

import './cartProvider.dart';

class BorrowedItem with ChangeNotifier{
  final String barcode;
  final double amount;
  final CartItem products;
  final DateTime borrowTimeStamp;

  BorrowedItem({
    this.barcode,
    this.amount,
    this.products,
    this.borrowTimeStamp,
  });
}

