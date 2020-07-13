import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    // print("$uid -- $username");
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.purple[400],
          ),
          title: Text(user.username),
          subtitle: Text(user.uid),
        ),
      ),
    );
  }
}
