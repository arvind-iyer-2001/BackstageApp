import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backstage/Models/inventoryModels.dart';
import './cartScreen.dart';
import './editInventoryItem.dart';
import '../Widgets/feedback.dart';
import '../../Providers&Services/cart.dart';
import '../../Providers&Services/inventory.dart';
import '../../Providers&Services/equipment.dart';
import '../../SupplementaryWidgets/badge.dart';

class InventoryDetailsScreen extends StatelessWidget {
  
  static const routeName = 'Inventory Details Screen';

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(
      initialPage: 0,
    );
    String itemId = ModalRoute.of(context).settings.arguments as String;
    return StreamBuilder<InventoryItem>(
      stream: Inventory(itemId: itemId).inventoryItem,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot.error);
          return Scaffold(
            body: Center(
              child: Text(snapshot.error),
            ),
          );
        }
        if(snapshot.hasData){
          print("Data not found");
          
        }
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            )
          );

          case ConnectionState.active:
          case ConnectionState.done:
        }
        final inventoryItem = snapshot.data;
        
        return StreamBuilder<EquipmentItem>(
          stream: Equipments(equipmentId: inventoryItem.equipmentId).equipment,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error),
                ),
              );
            }
            if(!snapshot.hasData){
              print("Data not found");
              return Scaffold(
                body: Center(
                  child: Text("No data found"),
                ),
              );
            }
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator()
                )
              );

              case ConnectionState.active:
              case ConnectionState.done:
            }
            final equipment = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('${equipment.title} ${inventoryItem.titleSuffix}'),
                centerTitle: true,
                actions: <Widget>[
                  Consumer<Cart>(
                    builder: (ctx, cart, child)=> Badge(
                      child: FlatButton.icon(
                        label: Text(
                          'Cart',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        icon: Icon(
                          Icons.shopping_basket,
                          color: Colors.white
                        ),
                        onPressed: () {
                          cart.addInventoryItemtoCart(inventoryItem);
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      ),
                      value: cart.items.length.toString(),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: inventoryItem.borrowed
              ? FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return ItemUsageFeedback(inventoryItem);
                    }
                  );
                },
                label: Text("Return"),
              )
              : null,
              persistentFooterButtons: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.4,
                        child: FlatButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context, 
                              builder: (context){
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Column(
                                    children: <Widget>[
                                    Text('Inventory Item Log'),
                                    Divider(),
                                    // ItemLogDisplay(itemId),
                                    ],
                                  ),
                                );
                              }
                            );
                          },
                          icon: Icon(Icons.view_list),
                          label: Text("View Item Log"),
                          color: Colors.purple,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width *0.4,
                        height: 50,
                        child: FlatButton.icon(
                          color: Colors.purple,
                          onPressed: () {
                            // Navigator.of(context).pushNamed(EditInventoryScreen.routeName, arguments: inventoryItem.itemId);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),

                          label: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],

              body: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 50,
                width: double.infinity,
                child: Card(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.width-30,
                            width: MediaQuery.of(context).size.width-30,
                            child: PageView.builder(
                              controller: pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: equipment.imageUrl.length,
                              itemBuilder: (ctx, index) => Container(
                                child: Image.network(
                                  equipment.imageUrl[index],
                                  fit: BoxFit.contain,
                                ),
                                // PageView & PageController https://www.youtube.com/watch?v=J1gE9xvph-A 
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10
                        ),
                        Container(
                          child: Text(
                            inventoryItem.barcode,
                            style: TextStyle(
                              color: inventoryItem.borrowed
                              ? Colors.red
                              : Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width-20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Features",
                                    style: TextStyle(
                                      fontSize: 30
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    width: MediaQuery.of(context).size.width-20,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height: 300,
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: double.infinity-10,
                                        child: ListView.builder(
                                          itemCount: equipment.description.length,
                                          itemBuilder: (ctx, index) => Text(
                                            '-> ${equipment.description[index]}',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 20
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 80
                          )
                        
                        ],
                      ),
                    ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}