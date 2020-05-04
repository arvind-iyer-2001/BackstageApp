import 'package:flutter/material.dart';

import '../Widgets/borrowedList.dart';
import '../Widgets/inventoryAppDrawer.dart';

class BorrowedScreen extends StatelessWidget {
  static const routeName = 'Borrowed Screen';

  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(context: null);
    }
    
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        endDrawer: RightAppDrawer(),
        appBar: AppBar(
          title: const Text('Borrowed Items'),
        ),

        body: BorrowedList()      
      ),
    );
  }
}