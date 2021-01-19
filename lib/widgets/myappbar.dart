import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(238, 238, 238, 1)
          ),
          height: 50
        )
      )
    );
  }
}