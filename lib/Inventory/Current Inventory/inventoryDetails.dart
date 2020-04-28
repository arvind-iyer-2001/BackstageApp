import 'package:backstage/Inventory/barcodeScan.dart';
import 'package:backstage/Providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/inventoryProvider.dart';
import '../../Providers/equipment.dart';
import './editInventory.dart';
import './itemLogDisplay.dart';
// import './editEquipmentInfo.dart';

class InventoryDetail extends StatelessWidget {
  static const routeName = 'Inventory Details';
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation==Orientation.landscape;
    final itemId= ModalRoute.of(context).settings.arguments as String;
    final inventoryItem = Provider.of<InventoryFunctions>(context,listen: false).findByItemId(itemId);
    final equipment = Provider.of<EquipmentFunctions>(context).findByItemId(inventoryItem.equipmentId);
    final pageController = PageController(
      initialPage: 0,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.title),
        actions: <Widget>[
          BarcodeScanner()
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              if(!isLandscape)
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width-20,
                  width: MediaQuery.of(context).size.width-20,
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
                  '${inventoryItem.barcode}',
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
                            height: 280,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity-10,
                            child: ListView.builder(
                              itemCount: equipment.description.length,
                              itemBuilder: (ctx, index) => Text(
                                '-> ${equipment.description[index]}\n',
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
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<Cart>(
        builder: (ctx, cart, child) =>FloatingActionButton.extended(
          label: Text(
            "Add to Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w200
            ),
          ),
          onPressed: () {
            cart.addInventoryItemtoCart(
              equipment.equipmentId,
              inventoryItem.barcode,
              inventoryItem.itemId,
              Categories.firstWhere((category) => category.id == equipment.categoryId[0]),
            );
            // Removes the current Snackbar
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${equipment.title} has been added to the Check Out'),
              )
            );
          },
        )
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
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: ItemLogDisplay(itemId),
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
                    Navigator.of(context).pushNamed(
                      EditInventory.routeName,
                      arguments: InventoryItem(
                        barcode: inventoryItem.barcode,
                        equipmentId: inventoryItem.equipmentId,
                        itemId: inventoryItem.itemId,
                        titleSuffix: inventoryItem.titleSuffix,
                        workingCondition: inventoryItem.workingCondition,
                        borrowed: inventoryItem.borrowed,
                        log: inventoryItem.log,
                      ),
                        
                    );
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
    );
  }
}