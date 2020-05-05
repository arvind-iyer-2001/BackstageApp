import 'package:backstage/Models/userModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Members {
  
  final String uid;
  Members({this.uid});

  //collection reference
  final CollectionReference membersCollection = Firestore.instance.collection('Members');
  
  Future updateMemberData(String name, DateTime dateOfBirth, String yearOfInduction, String memberType) async {
    return await membersCollection.document(uid).setData({
      'Date Of Birth': dateOfBirth,
      'Name': name,
      'Member Type': memberType,
      'Year of Induction': yearOfInduction,
    });
  }

  //brew list from snapshot
  List<Member> _membersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Member(
        dateOfBirth: doc.data['Date Of Birth'] as DateTime,
        name: doc.data['Name'] as String ?? '',
        memberType: doc.data['Member Type'] as String ?? 'Crew',
        uid: doc.documentID,
        yearOfJoining: doc.data['Year of Induction'] as String ?? '2010'
      );
    }).toList();
  }

  //userData from Snapshot
  Member _memberDataFromSnapshot(DocumentSnapshot doc){
    return Member(
        dateOfBirth: doc.data['Date Of Birth'] as DateTime,
        name: doc.data['Name'] as String ?? '',
        memberType: doc.data['Member Type'] as String ?? 'Crew',
        uid: doc.documentID,
        yearOfJoining: doc.data['Year of Induction'] as String ?? '2010'
      );
  }

  //get brews stream                    
  Stream<List<Member>> get members {
    return membersCollection.snapshots()
    .map(_membersListFromSnapshot);
  }

  //get user doc stream                    
  Stream<Member> get memberData {
    return membersCollection.document(uid).snapshots()
    .map(_memberDataFromSnapshot);
  }

}