import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _databaseReference = Firestore.instance;
  bool exTurn = true;
  List<String> exOh = ['', '', '', '', '', '', '', '', ''];
  List playedTiles = [];
  int playerExWin = 0;
  int playerOhWin = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _databaseReference.collection("Board").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    final board = asyncSnapshot.data.documents;
                    for (var item in board) {
                      exOh[int.parse(item.documentID)] = item['value'];
                    }
                    print(exOh);
                    return Expanded(
                      flex: 4,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _buttonPressed(index),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  exOh[index],
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _buttonPressed(int index) async {
    setState(() {
      if (!playedTiles.contains(index)) {
        if (exTurn) {
          exOh[index] = 'X';
          exTurn = !exTurn;
        } else {
          exOh[index] = 'O';
          exTurn = !exTurn;
        }
      } else {
        print('tile already played');
      }
      try {
        _databaseReference
            .collection('Board')
            .document(index.toString())
            .updateData(
          {'value': '${exOh[index]}'},
        );
        print('$index updated successfully with ${exOh[index]}');
      } catch (e) {
        print(e.toString() + "      Some error occured while inserting");
      }

      playedTiles.add(index);
      _winnerContitions();
    });
  }

  _showWinnerDialog(String winner) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 4.0,
            title: Text('Congrats Winner is $winner'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('How about another match!!!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Replay?'),
                  onPressed: () {
                    _resetDatabase();
                    if (winner == "X") {
                      playerExWin++;
                    } else {
                      playerOhWin++;
                    }
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  String _winnerContitions() {
    //first row
    if (exOh[0] == exOh[1] && exOh[0] == exOh[2] && exOh[0] != '') {
      return _showWinnerDialog(exOh[0]);
    }
    //second row
    if (exOh[3] == exOh[4] && exOh[3] == exOh[5] && exOh[3] != '') {
      return _showWinnerDialog(exOh[3]);
    }
    //third row
    if (exOh[6] == exOh[7] && exOh[6] == exOh[8] && exOh[6] != '') {
      return _showWinnerDialog(exOh[6]);
    }
    //first column
    if (exOh[0] == exOh[3] && exOh[0] == exOh[6] && exOh[0] != '') {
      return _showWinnerDialog(exOh[0]);
    }
    //second column
    if (exOh[1] == exOh[4] && exOh[1] == exOh[7] && exOh[1] != '') {
      return _showWinnerDialog(exOh[1]);
    }
    //third column
    if (exOh[2] == exOh[5] && exOh[2] == exOh[8] && exOh[2] != '') {
      return _showWinnerDialog(exOh[2]);
    }
    // L to R diagonal
    if (exOh[0] == exOh[4] && exOh[0] == exOh[8] && exOh[0] != '') {
      return _showWinnerDialog(exOh[0]);
    }
    // R to L diagonal
    if (exOh[2] == exOh[4] && exOh[2] == exOh[6] && exOh[2] != '') {
      return _showWinnerDialog(exOh[2]);
    }
  }

  void _resetDatabase() {
    try {
      for (int i = 0; i < 9; i++) {
        _databaseReference.collection("Board").document(i.toString()).setData(
          {'value': ''},
        );
        print('$i created successfully');
      }
    } catch (e) {
      print('*********** Here are the xeptions **********');
      print(e.toString());
    }
    setState(() {
      exOh = ['', '', '', '', '', '', '', '', ''];
      playedTiles = [];
    });
  }
}
