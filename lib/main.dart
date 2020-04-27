import 'package:backstage/Inventory/scannedPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Inventory/Current Inventory/currentInventoryScreen.dart'; // 1
import './Inventory/Current Inventory/inventoryDetails.dart'; // 2
import './Inventory/checkOutCartScreen.dart'; // 3
import './Inventory/borrowed.dart'; // 4
import './Inventory/inventoryHomePage.dart'; // 5
import './Inventory/Current Inventory/editInventory.dart'; // 6
import './Inventory/Current Inventory/editEquipmentInfo.dart'; // 7
import './Inventory/barcodeScan.dart';

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
        home: InventoryHomeScreen(),
        routes: {
          
          InventoryHomeScreen.routeName: (ctx)  =>InventoryHomeScreen(),

          // Current Inventory
          CurrentInventoryScreen.routeName: (ctx) => CurrentInventoryScreen(), 
          InventoryDetail.routeName: (ctx) => InventoryDetail(),
          CheckOutScreen.routeName: (ctx) => CheckOutScreen(),
          BorrowedItemsScreen.routeName: (ctx) => BorrowedItemsScreen(),
          EditInventory.routeName: (ctx) => EditInventory(),
          EditEquipmentScreen.routeName: (ctx) => EditEquipmentScreen(),

          // Barcode Scanner
          ScannedPage.routeName: (ctx) => ScannedPage(),
          BarcodeScanner.routeName: (ctx) => BarcodeScanner()
        },
      ),
    );
  }
}