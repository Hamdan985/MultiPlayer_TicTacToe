import 'package:flutter/material.dart';
import '../screens/authenticate/authenticate.dart';
import '../screens/home/home.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This will return either the Home or Authenticate widget
    //based on the Authentication status of the user

    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
