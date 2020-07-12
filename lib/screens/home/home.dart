import 'package:flutter/material.dart';
import '../../services/auth.dart';
import './users_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('TicTacToe Home Page'),
        backgroundColor: Colors.pink[200],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.SignOut();
            },
          )
        ],
      ),
      body: UsersList(),
    );
  }
}
