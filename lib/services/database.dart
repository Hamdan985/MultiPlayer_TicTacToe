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
  Stream<QuerySnapshot> get users {
    return rootCollection.snapshots();
  }

  // gets us a list of users form the stream of snapshot
  List<User> _usersFromSnapshot() {}
}
