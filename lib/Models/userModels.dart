import 'package:flutter/cupertino.dart';

class User {
  final String uid;

  User({ this.uid });
}
class Member with ChangeNotifier {

  final String yearOfJoining;
  final String name;
  final DateTime dateOfBirth;
  final String memberType;
  final String uid;
  // final List<Events> allotted;
  // final List<InventoryItem> itemLogs;

  Member({this.uid,this.memberType,this.yearOfJoining,this.dateOfBirth,this.name});
}