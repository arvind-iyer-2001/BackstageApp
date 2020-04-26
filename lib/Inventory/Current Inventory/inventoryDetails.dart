import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/inventoryProvider.dart';
import '../../Providers/equipment.dart';
import './editInventory.dart';
// import './editEquipmentInfo.dart';

class InventoryDetail extends StatelessWidget {
  static const routeName = 'Inventory Details';
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation==Orientation.landscape;
    final itemId= ModalRoute.of(context).settings.arguments as String;
    final inventoryItem = Provider.of<InventoryFunctions>(context,listen: false).findByItemId(itemId);
    final equipment = Provider.of<EquipmentFunctions>(context).findByItemId(inventoryItem.equipmentId);
    var pageController = PageController(
      initialPage: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.title),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(EditInventory.routeName, arguments: itemId);
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
          )
        ],
      ),
      body: Container(
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
              Text(
                '${inventoryItem.barcode}',
                style: TextStyle(
                  // color: Colors.grey,
                  fontSize: 20,
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
    );
  }
}
