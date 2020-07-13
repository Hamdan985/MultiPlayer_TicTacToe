import 'package:flutter/material.dart';
import '../../screens/home/user_tile.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);
    // print(users);
    if (users != null) {
      users.forEach((user) {
        print("${user.username} -  ${user.uid}");
      });
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return UserTile(user: users[index]);
      },
    );
  }
}
