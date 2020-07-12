import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String username = '';
  String email = '';
  String password = '';
  String errorMessage = '';

  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.pink[50],
            appBar: AppBar(
              backgroundColor: Colors.pink[200],
              elevation: 0.0,
              title: Text('Sign Up to play '),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Username"),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a username' : null,
                        onChanged: (value) {
                          setState(() => username = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Password"),
                        validator: (val) => val.length < 6
                            ? 'Length of Password should be > 6 chars'
                            : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.pink[300],
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerWithUserAndPassword(
                                    email, password, username);
                            if (result == null) {
                              setState(() {
                                errorMessage =
                                    'Server Error, Try again lul uwu';
                                loading = true;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
