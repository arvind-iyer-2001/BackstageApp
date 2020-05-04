class User {

  final String uid;
  
  User({ this.uid });
}
class UserData {

  final String yearOfJoining;
  final String name;
  final String dateOfBirth;
  final String memberType;
  final String uid;

  UserData({this.uid,this.memberType,this.yearOfJoining,this.dateOfBirth,this.name});
}