import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AirtableCalendar/widgets/spinner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoad = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airtable Calendar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: "Logout",
            onPressed: () => setState(() {
              _isLoad = true;
              _logout(context);
            }),
          )
        ]
      ),
      body: Stack(
        children: <Widget> [
          Positioned(
            top: 0,
            left: 0,
            // right: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 2,
            child: Container(
              alignment: Alignment.topLeft,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: List<int>.generate(3, (i) => i).map((i) {
                        return Container(
                          width: MediaQuery.of(context).size.width/3,
                          decoration: BoxDecoration(
                            color: Colors.yellow
                          ),
                          child: Column(
                            children: List<int>.generate(Random().nextInt(20) + 1, (i) => i).map((j) {
                                return Padding(
                                  padding: EdgeInsets.only(top: (Random().nextInt(5) * 1.0) * 50),
                                  child: Container(
                                      color: Colors.grey,
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "$j item of $i row"
                                      )
                                  ),
                                );
                            }).toList()
                          ),
                        );
                      }).toList(),
                    )
                  )
                ]
              )
            )
          ),
          if (_isLoad) Container(
            color: Color.fromRGBO(255, 255, 255, .5),
            child: SpinnerWidget()
          )
        ]
      )
    );
  }

  Future<void> _logout(BuildContext context) async {
    FocusScope.of(context).unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('apiKey');
    prefs.remove('tableUrl');

    setState(() {
      _isLoad = false;
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
}