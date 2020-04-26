import 'package:backstage/Providers/equipment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/inventoryProvider.dart';


class EditInventory extends StatefulWidget {
  static const routeName = 'Edit Inventory Screen';
  @override
  _EditInventoryState createState() => _EditInventoryState();
}

class _EditInventoryState extends State<EditInventory> {
  final _barcodeFocusNode = FocusNode();
  final _titleSuffixFocusNode = FocusNode();
  final _equipmentIdFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _equipmentIdController = TextEditingController();
  
  // final _FocusNode = FocusNode();
  // @required final String barcode;
  // @required final String titleSuffix;
  // @required final String equipmentId;
  // @required final String itemId;
  // @required bool workingCondition;
  // bool borrowed;
  // List<ItemLog> log;

  var _editedInventoryItem = InventoryItem(
    barcode: '',
    titleSuffix: '',
    equipmentId: '',
    itemId: null,
    workingCondition: true
  );
  var _initValues = {
    'barcode': '',
    'titleSuffix': '',
    'equipmentId': null,
    'workingCondition': true
  };
  var _isInit = true;

  @override
  void initState() {
    _equipmentIdFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final inventoryId = ModalRoute.of(context).settings.arguments as String;
      if (inventoryId != null) {
        _editedInventoryItem = Provider.of<InventoryFunctions>(context, listen: false).findByItemId(inventoryId);
        _initValues = {
          'barcode': _editedInventoryItem.barcode,
          'titleSuffix': _editedInventoryItem.titleSuffix,
          'equipmentId': _editedInventoryItem.equipmentId,
          'workingCondition': _editedInventoryItem.workingCondition
        };
        _equipmentIdController.text = _editedInventoryItem.equipmentId;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _equipmentIdFocusNode.removeListener(_updateImageUrl);
    _barcodeFocusNode.dispose();
    _titleSuffixFocusNode.dispose();
    _equipmentIdFocusNode.dispose();
    _equipmentIdController.dispose();
    
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_equipmentIdFocusNode.hasFocus) {
      if (!_equipmentIdController.text.startsWith('eId')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedInventoryItem.itemId != null) {
      Provider.of<InventoryFunctions>(context, listen: false)
          .updateInventoryItem(_editedInventoryItem.itemId, _editedInventoryItem);
    } else {
      Provider.of<InventoryFunctions>(context, listen: false).addInventoryItems(_editedInventoryItem);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final equipment = Provider.of<EquipmentFunctions>(context).equipmentItems;
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ?? false;
    }
    
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Inventory Item Details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['titleSuffix'],
                  decoration: InputDecoration(labelText: 'Add Suffix to the Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_barcodeFocusNode);
                  },
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    _editedInventoryItem = InventoryItem(
                      barcode: _editedInventoryItem.barcode,
                      equipmentId: _editedInventoryItem.equipmentId,
                      itemId: _editedInventoryItem.itemId,
                      borrowed: _editedInventoryItem.borrowed,
                      titleSuffix: value,
                      workingCondition: _editedInventoryItem.workingCondition
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['barcode'],
                  decoration: InputDecoration(labelText: 'BARCODE'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_equipmentIdFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedInventoryItem = InventoryItem(
                      titleSuffix: _editedInventoryItem.titleSuffix,
                      barcode: value,
                      equipmentId: _editedInventoryItem.equipmentId,

                      itemId: _editedInventoryItem.itemId,
                      borrowed: _editedInventoryItem.borrowed,
                      workingCondition: _editedInventoryItem.workingCondition
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _equipmentIdController.text.isEmpty
                          ? Text('Enter an EquipmentId',softWrap: true,)
                          : FittedBox(
                              child: Text(
                                equipment.firstWhere((element) => _equipmentIdController.text == element.equipmentId).title,
                                softWrap: true,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _equipmentIdController,
                        focusNode: _equipmentIdFocusNode,

                        onFieldSubmitted: (value) {
                          _editedInventoryItem = InventoryItem(
                            titleSuffix: _editedInventoryItem.titleSuffix,
                            barcode: value,
                            equipmentId: _editedInventoryItem.equipmentId,

                            itemId: _editedInventoryItem.itemId,
                            borrowed: _editedInventoryItem.borrowed,
                            workingCondition: _editedInventoryItem.workingCondition
                          );
                        },

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an eqipment Id value';
                          }
                          if (!value.startsWith('eId') &&
                              !value.startsWith('eId0')) {
                            return 'Please enter a valid equipmentId.';
                          }
                          
                          return null;
                        },

                        
                      ),
                    ),
                  ]
                ),
              ]
            )
          )
        )
      )
      
    );
  }
}