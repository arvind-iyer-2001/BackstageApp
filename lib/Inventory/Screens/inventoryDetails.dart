import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backstage/Models/inventoryModels.dart';
import './cartScreen.dart';
// import './editInventoryItem.dart';
import '../Widgets/feedback.dart';
import '../../Providers&Services/cart.dart';
import '../../Providers&Services/inventory.dart';
import '../../Providers&Services/equipment.dart';

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
              : Consumer<Cart>(
                builder: (ctx, cart, child)=> FloatingActionButton.extended(
                  highlightElevation: 10,
                  hoverColor: Theme.of(context).primaryColor,
                  label: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor
                  ),
                  onPressed: () {
                    cart.addInventoryItemtoCart(inventoryItem);
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
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
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width *0.4,
                        height: 50,
                        child: FlatButton.icon(
                          color: Theme.of(context).primaryColor,
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

              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height - 40,
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: MediaQuery.of(context).size.width-30,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: EdgeInsets.all(10),
                            title: Text(
                              '${equipment.title} ${inventoryItem.titleSuffix}',
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white
                              ),
                            ),
                            centerTitle: true,
                            background: Card(
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
                                    child: Hero(
                                      tag: '${inventoryItem.itemId} - 0',
                                      child: FadeInImage(
                                        placeholder: AssetImage('assets/images/micPlaceholder.jpg'),
                                        image: NetworkImage(equipment.imageUrl[index]) ?? null,
                                        fit: BoxFit.contain,
                                        fadeInCurve: Curves.bounceIn,
                                        fadeInDuration: Duration(milliseconds: 200),
                                        fadeOutDuration: Duration(milliseconds: 100),
                                      ),
                                    ),
                                    // PageView & PageController https://www.youtube.com/watch?v=J1gE9xvph-A 
                                  ),
                                ),
                              ),
                            ),
                            
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                              color: Theme.of(context).primaryColor,
                              child: Card(
                                child: Center(
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
                              ),
                            ),
                            Container(
                              color: Theme.of(context).primaryColor,
                              child: Card(
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
                                            height: 450,
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
                            ),
                            Container(
                              height: 500,
                              color: Theme.of(context).primaryColor,
                              child: Card(),
                            )
                          ])
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