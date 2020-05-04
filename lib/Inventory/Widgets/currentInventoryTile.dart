import 'package:backstage/Providers&Services/equipment.dart';
import 'package:flutter/material.dart';

import '../../Models/inventoryModels.dart';
import 'package:backstage/Providers&Services/inventory.dart';

import 'listTiles.dart';


class CurrentInventoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InventoryItem>>(
      stream: Inventory().inventory,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        if(!snapshot.hasData){
          return Center(
            child: Text("No Data Found"),
          );
        }
        switch (snapshot.connectionState){
          case ConnectionState.none:
            return Center(
              child: Text("Connection Error"),
            );
          case ConnectionState.waiting:
            return Center(
              child: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("   Loading...")
                  ],
                ),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
        }
        final inventory = snapshot.data;
        return ListView.builder(
          itemCount: inventory.length ?? 0,
          itemBuilder: (ctx, index) => StreamBuilder<EquipmentItem>(
            stream: Equipments(equipmentId: inventory[index].equipmentId).equipment,
            builder: (context, snapshot) {
              if (snapshot.hasError){
                print(snapshot.error);
                return Container(
                  height: 10,
                  child: Text("error"),
                );
              }
              if(!snapshot.hasData){
                return Container(
                  height: 10,
                  child: Text("No data"),
                );
              }
              switch (snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                return CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
              }
              final equipment = snapshot.data;
              return ListTiles(equipment: equipment, inventory: inventory,index: index,);
            }
          ),
        );
      }
    );
  }
}

