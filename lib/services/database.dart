import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference rootCollection =
      Firestore.instance.collection('root');

  // create a new user record when they register
  Future createUserDocument(String username) async {
    return await rootCollection.document(uid).setData({
      "id": uid,
      "username": username,
    });
  }

  // gets us the stream of users in our rootCollection
  Stream<List<User>> get users {
    return rootCollection.snapshots().map(_usersFromSnapshot);
  }

  // gets us a list of users form the stream of snapshot
  List<User> _usersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
      return User(
        uid: document.data["id"] ?? 'ID not found',
        username: document.data["username"] ?? 'Username not found',
      );
    }).toList();
  }
}
