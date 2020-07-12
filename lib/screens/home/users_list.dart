import 'package:flutter/material.dart';
import '../../services/database.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: DatabaseService().users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('start');
                for (var user in snapshot.data.documents.reversed) {
                  print(" ${user["id"]} --- ${user["username"]}");
                }
                print('end');
              }
              return Container(
                height: 200.0,
                width: 200.0,
                color: Colors.pink,
              );
            }));
  }
}
