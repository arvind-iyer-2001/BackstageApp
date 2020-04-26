import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/equipment.dart';

class EditEquipmentScreen extends StatefulWidget {
  static const routeName = 'Edit Equipment Screen';
  @override
  _EditEquipmentScreenState createState() => _EditEquipmentScreenState();
}

class _EditEquipmentScreenState extends State<EditEquipmentScreen> {
  
  final _descriptionFocusNode = List<FocusNode>();
  int descriptionCounts;
  int imageUrlCounts;
  int categoryCounts;
  final _categoryFocusNode = List<FocusNode>();
  final List<TextEditingController> _imageUrlController =List(6);
  
  List<FocusNode> _imageUrlFocusNode = List<FocusNode>();
  final _form = GlobalKey<FormState>();
  var _editedProduct = EquipmentItem(
    title: '',
    description: [],
    imageUrl: [],
    categoryId: [],
    equipmentId: null
  );
  var _initValues = EquipmentItem(
    title: '',
    description: [],
    imageUrl: [],
    categoryId: [],
    equipmentId: null
  );
  
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.forEach((element) => element.addListener(_updateImageUrl));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final equipmentId = ModalRoute.of(context).settings.arguments as String;
      if (equipmentId != null) {
        _editedProduct =
            Provider.of<EquipmentFunctions>(context, listen: false).findByItemId(equipmentId);
        _initValues = _editedProduct;
        // if(_editedProduct.imageUrl != null){
        //   for(int i=0; i< _editedProduct.imageUrl.length ; i++){
        //     _imageUrlController[i].text = _editedProduct.imageUrl[i];
        //   }
        // }
        
        
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.forEach((element) => element.removeListener(_updateImageUrl));
    _categoryFocusNode.forEach((element) => element.dispose());
    _descriptionFocusNode.forEach((element) => element.dispose());
    _imageUrlController.forEach((element) => element.dispose());
    super.dispose();
  }

  void _updateImageUrl() {
    for(int i=0; i < _imageUrlFocusNode.length; i++){
      if (!_imageUrlFocusNode[i].hasFocus) {
        if ((!_imageUrlController[i].text.startsWith('http') &&
                !_imageUrlController[i].text.startsWith('https')) ||
            (!_imageUrlController[i].text.endsWith('.png') &&
                !_imageUrlController[i].text.endsWith('.jpg') &&
                !_imageUrlController[i].text.endsWith('.jpeg'))) {
          return;
        }
        setState(() {});
      }
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.equipmentId != null) {
      Provider.of<EquipmentFunctions>(context, listen: false).updateEquipmentItem(_editedProduct.equipmentId, _editedProduct);
    } else {
      Provider.of<EquipmentFunctions>(context, listen: false).addEquipmentItems(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
                initialValue: _initValues.title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode[0]);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct =EquipmentItem(
                    title: value,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    categoryId: _editedProduct.categoryId,
                    equipmentId: _editedProduct.equipmentId,
                  );
                },
              ),

              TextFormField(

              ),
              for(int i =0; i<_editedProduct.description.length; i++)
                TextFormField(
                  initialValue: _initValues.description[i],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode[0],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description field.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 5 characters long.';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    _editedProduct.description[i]= value;
                    _editedProduct = EquipmentItem(
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      categoryId: _editedProduct.categoryId,
                      equipmentId: _editedProduct.equipmentId,
                    );
                    if(i !=_editedProduct.description.length){
                      FocusScope.of(context).requestFocus(_descriptionFocusNode[i+1]);
                    }
                  },
                ),

              TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode[0],
                validator: (value) {
                  return null;
                },
                onFieldSubmitted: (value) {
                  _editedProduct.description.add(value);
                  _editedProduct = EquipmentItem(
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    categoryId: _editedProduct.categoryId,
                    equipmentId: _editedProduct.equipmentId,
                  );
                },
              ),

              for(int i =0; i<_editedProduct.imageUrl.length; i++)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
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
                      child: _imageUrlController[i].text.isEmpty
                          ? Text('Enter an URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController[i].text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController[i],
                        focusNode: _imageUrlFocusNode[i],

                        onFieldSubmitted: (value) {
                          _editedProduct.imageUrl[i]= value;
                          _editedProduct = EquipmentItem(
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            categoryId: _editedProduct.categoryId,
                            equipmentId: _editedProduct.equipmentId,
                          );
                        },

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an image URL.';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL.';
                          }
                          return null;
                        },

                        
                      ),
                    ),
                  ]
                )


            ],
          )
        ),
      ),
    );
  }
}
