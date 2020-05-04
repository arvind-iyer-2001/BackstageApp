import 'package:backstage/Models/inventoryModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Equipments with ChangeNotifier {
  final String equipmentId;
  Equipments({this.equipmentId});

  // Getting Collection Reference for Equipment Collection
  final CollectionReference equipmentCollection = Firestore.instance.collection('equipments');
  
  List<EquipmentItem> _equipmentsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return EquipmentItem(
        title: doc.data['title'] ?? '',
        categoryId: List<String>.from(doc.data['categories']),
        description: List<String>.from(doc.data['description']),
        equipmentId: doc.documentID,
        imageUrl: List<String>.from(doc.data['imageUrls']),
      );
    }).toList();
  }

  // Stream to obtain List of Equipment Items
  Stream<List<EquipmentItem>> get equipmentItems {
    return equipmentCollection.snapshots().map(_equipmentsFromSnapshot);
  }

  EquipmentItem _equipmentItemFromSnapshot(DocumentSnapshot doc){
    return EquipmentItem(
      title: doc.data['title'],
      categoryId: List<String>.from(doc.data['categories']),
      description: List<String>.from(doc.data['description']),
      equipmentId: equipmentId,
      imageUrl: List<String>.from(doc.data['imageUrls']),
    );
  }

  // Stream to obtain a Particular Equipment Item
  Stream<EquipmentItem> get equipment{
    return equipmentCollection.document(equipmentId).snapshots().map(_equipmentItemFromSnapshot);
  }

  // Add Equipment Item to the Collection and the On-Device Storage
  Future addEquipmentItem(
    String title,
    List<String> description,
    List<String> categories,
    List<String> imageUrls
  ) async {
    await equipmentCollection.add({
      'title': title,
      'categories': categories,
      'description': description,
      'imageUrls': imageUrls
    });
  }

  // Update Equipment Item Data in the Collection and the On-Device Storage
  Future updateEquipmentItemData(
    String title,
    List<String> description,
    List<String> categories,
    List<String> imageUrls,
  ) async {
    await equipmentCollection.document(equipmentId).setData({
      'title': title,
      'categories': categories,
      'description': description,
      'imageUrls': imageUrls
    });
    
    notifyListeners();
  }

}