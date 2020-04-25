import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Inventory/currentInventoryScreen.dart'; // 1
import './Inventory/inventoryDetails.dart'; // 2
import './Inventory/checkOutCartScreen.dart'; // 3
import './Inventory/borrowed.dart'; // 4

import './Providers/equipment.dart';
import './Providers/inventoryProvider.dart';
import './Providers/cartProvider.dart';
import './Providers/borrow&return.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EquipmentFunctions(),
        ),
        ChangeNotifierProvider.value(
          value: InventoryFunctions(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: BorrowReturn(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
        ),
        home: CurrentInventoryScreen(),
        routes: {
          CurrentInventoryScreen.routeName: (ctx) => CurrentInventoryScreen(), 
          InventoryDetail.routeName: (ctx) => InventoryDetail(),
          CheckOutScreen.routeName: (ctx) => CheckOutScreen(),
          BorrowedItemsScreen.routeName: (ctx) => BorrowedItemsScreen(),
          
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}