import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../game/game_screen.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({this.user});

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            //TODO : push to game screen followed by init state to create a board between these two users
          },
          subtitle: Text(user.uid),
        ),
      ),
    );
  }
}
