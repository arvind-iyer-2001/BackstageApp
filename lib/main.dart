import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './Providers&Services/equipment.dart'; // Phase 1.a
import './Providers&Services/inventory.dart'; // Phase 1.b
import './Providers&Services/cart.dart'; // Phase 1.c

import './Inventory/inventoryHomeScreen.dart'; // Phase 1.0
import './Inventory/Screens/currentInventoryScreen.dart'; // Phase 1.1
import './Inventory/Screens/inventoryDetails.dart'; // Phase 1.2
import './Inventory/Screens/editInventoryItem.dart'; // Phase 1.3
import './Inventory/Screens/cartScreen.dart'; // Phase 1.4
import 'Inventory/Screens/borrowedScreen.dart'; // Phase 1.5

import './Providers&Services/auth.dart'; // Phase 2.a
import './Models/userModels.dart'; // Phase 2.b

import './UserAuthentication/authenticationScreen.dart';// Phase 2.0

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Equipments(),
          ),
          ChangeNotifierProvider.value(
            value: Inventory(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
        ],
        child: MaterialApp(
          title: 'Backstage App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.purple,
            accentColor: Colors.amber,
            errorColor: Colors.red,
          ),

          home: Wrapper(),

          routes: {
            InventoryHomeScreen.routeName: (ctx) => InventoryHomeScreen(),
            CurrentInventoryScreen.routeName: (ctx) => CurrentInventoryScreen(),
            InventoryDetailsScreen.routeName: (ctx) => InventoryDetailsScreen(),
            EditInventoryScreen.routeName: (ctx) => EditInventoryScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            BorrowedScreen.routeName: (ctx) => BorrowedScreen()
          },
        ),
      )
        
    );
  }
}

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final user =Provider.of<User>(context);
    
    print(user);
    if(user == null){
      return AuthScreen();
    } else { 
      print(user.uid);
      return InventoryHomeScreen();
    }  
  }
}