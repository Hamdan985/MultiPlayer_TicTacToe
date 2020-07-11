import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[300],
      child: Center(
        child: SpinKitWave(
          size: 30.0,
          color: Colors.white,
          type: SpinKitWaveType.start,
        ),
      ),
    );
  }
}
