import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AirtableCalendar/widgets/spinner.dart';
import 'package:AirtableCalendar/models/Api.dart';

class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  void initState() {
    super.initState();
    preLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: SpinnerWidget()
          )
        )
      )
    );
  }

  Future<void> preLoad() async {
    var _duration = new Duration(seconds: 0);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Api api = new Api();
    await api.init();

    /* DEVELOPMENT */
    Navigator.of(context).pushReplacementNamed('/home');
    return;
    /* END DEVELOPMENT */
    
    if (!await api.check()){
      Navigator.of(context).pushReplacementNamed('/enter');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}