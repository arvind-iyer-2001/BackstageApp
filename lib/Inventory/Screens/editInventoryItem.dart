import 'package:backstage/Providers&Services/equipment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Models/inventoryModels.dart';
import '../../Providers&Services/inventory.dart';
import '../../SupplementaryWidgets/constants.dart';

class EditInventoryScreen extends StatefulWidget {
  static const routeName = 'Edit Inventory Screen';

  @override
  _EditInventoryScreenState createState() => _EditInventoryScreenState();
}

class _EditInventoryScreenState extends State<EditInventoryScreen> {

  String currentEquipmentId = '';
  String currentBarcode = '';
  String currentTitleSuffix = '';
  bool currentWorkingCondition = true;
  bool isInit = true;
  bool validEquipmentId;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: itemId == null
        ? Text("Add Inventory Item")
        : Text("Edit Inventory Item")
      ),
      body: itemId != null
      ? StreamBuilder<InventoryItem>(
        stream: Inventory(itemId: itemId).inventoryItem,
        builder: (context, snapshot) {
          if(snapshot.hasError){
          print(snapshot.error);
          return Center(
            child: Text(snapshot.error),
          );
        }
        if(!snapshot.hasData){
          print("Data not found ${snapshot.error}");
          return Center(
            child: Text("No data found"),
          );
        }
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator()
          );
          case ConnectionState.active:
          case ConnectionState.done:
        }
        final inventoryItem = snapshot.data;

        if(isInit){
          currentEquipmentId = inventoryItem.equipmentId;
          currentBarcode = inventoryItem.barcode;
          currentTitleSuffix = inventoryItem.titleSuffix;
          validEquipmentId = true;
          isInit =false;
        }
          return Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height - AppBar().preferredSize.height -10 ,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Center(
                      child: validEquipmentId
                      ? StreamBuilder<EquipmentItem>(
                        stream: Equipments(equipmentId: currentEquipmentId).equipment,
                        builder: (context, snapshot) {
                          if(!snapshot.hasError && snapshot.hasData){
                            return Text(
                              snapshot.data.title
                            );
                          }
                          return Text("Enter Valid Equipment Id");
                        }
                      )
                      : Text("Enter Valid Equipment Id"),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentEquipmentId,
                      decoration: textInputDecoration.copyWith(hintText: 'Enter Equipment Id', labelText: 'Equipment Id'),
                      validator: (value) {
                        if(!validEquipmentId || value.length ==0 ){
                          return "Enter a valid Equipment Id";
                        }
                        return null;

                      },
                      onChanged: (value) {
                        Firestore.instance.collection("equipment").document(value).get().then((docSnapshot) => {
                          setState(() {
                            currentEquipmentId = value;
                          }),
                          if(!docSnapshot.exists) {
                            setState(() {
                              validEquipmentId = false;
                            })
                          } else {
                            setState(() {
                              validEquipmentId = true;
                            })
                          }
                        });
                      },
                      readOnly: false,
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentBarcode,
                      decoration: textInputDecoration.copyWith(labelText: 'Barcode',hintText: 'Enter Barcode'),
                      onSaved: (value) {
                        setState(() {
                          currentBarcode = value;
                        });
                      },
                      readOnly: true,
                    ),
                  ),
                    
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentTitleSuffix,
                      decoration: textInputDecoration.copyWith(labelText: 'Title Suffix',hintText: 'Enter Title Suffix'),
                      onChanged: (value) {

                      },
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Working Condition: "),
                      trailing: Checkbox(
                        value: currentWorkingCondition,
                        onChanged: (value) {
                          setState(() {
                            currentWorkingCondition = value;
                          });
                        }
                      )
                    ),
                  ),

                  RaisedButton.icon(
                    onPressed: () async {
                      await Inventory(itemId: itemId).updateInventoryItemData(
                        InventoryItem(
                          barcode: currentBarcode,
                          equipmentId: currentEquipmentId,
                          borrowed: inventoryItem.borrowed,
                          itemId: itemId,
                          titleSuffix: currentTitleSuffix,
                          workingCondition: currentWorkingCondition
                        )
                      );
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save Details")
                  )
                     
                ],
              ),
            ),
          ); 
        }
      )
      : Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height -10 ,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Center(
                      child: validEquipmentId
                      ? StreamBuilder<EquipmentItem>(
                        stream: Equipments(equipmentId: currentEquipmentId).equipment,
                        builder: (context, snapshot) {
                          if(!snapshot.hasError && snapshot.hasData){
                            return Text(
                              snapshot.data.title
                            );
                          }
                          return Text("Enter Valid Equipment Id");
                        }
                      )
                      : Text("Enter Valid Equipment Id"),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentEquipmentId,
                      decoration: textInputDecoration.copyWith(hintText: 'Enter Equipment Id', labelText: 'Equipment Id'),
                      validator: (value) {
                        if(!validEquipmentId || value.length ==0 ){
                          return "Enter a valid Equipment Id";
                        }
                        return null;

                      },
                      onChanged: (value) {
                        Firestore.instance.collection("equipment").document(value).get().then((docSnapshot) => {
                          setState(() {
                            currentEquipmentId = value;
                          }),
                          if(!docSnapshot.exists) {
                            setState(() {
                              validEquipmentId = false;
                            })
                          } else {
                            setState(() {
                              validEquipmentId = true;
                            })
                          }
                        });
                      },
                      readOnly: false,
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentBarcode,
                      decoration: textInputDecoration.copyWith(labelText: 'Barcode',hintText: 'Enter Barcode'),
                      onSaved: (value) {
                        setState(() {
                          currentBarcode = value;
                        });
                      },
                      readOnly: true,
                    ),
                  ),
                    
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: TextFormField(
                      initialValue: currentTitleSuffix,
                      decoration: textInputDecoration.copyWith(labelText: 'Title Suffix',hintText: 'Enter Title Suffix'),
                      onChanged: (value) {

                      },
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Working Condition: "),
                      trailing: Checkbox(
                        value: currentWorkingCondition,
                        onChanged: (value) {
                          setState(() {
                            currentWorkingCondition = value;
                          });
                        }
                      )
                    ),
                  ),

                  RaisedButton.icon(
                    onPressed: () async {
                      await Inventory(itemId: itemId).addInventoryItem(
                        InventoryItem(
                          barcode: currentBarcode,
                          equipmentId: currentEquipmentId,
                          borrowed: false,
                          itemId: itemId,
                          titleSuffix: currentTitleSuffix,
                          workingCondition: currentWorkingCondition
                        )
                      );
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save Details")
                  )
                     
                ],
              ),
            ),
          )
    );
  }
}

