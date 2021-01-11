import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SpinnerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 60,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
        );
      },
    );
  }
}