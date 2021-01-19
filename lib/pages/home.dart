import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AirtableCalendar/widgets/spinner.dart';
import 'package:AirtableCalendar/widgets/myappbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoad = false;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Airtable Calendar'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.exit_to_app),
      //       tooltip: "Logout",
      //       onPressed: () => setState(() {
      //         _isLoad = true;
      //         _logout(context);
      //       }),
      //     )
      //   ]
      // ),
      key: _drawerKey, 
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 10.0
                ),
                child: Image(image: AssetImage('assets/images/logo.png'))
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  title: Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                  onTap: () => setState(() {
                    _isLoad = true;
                    _logout(context);
                  }),
                ),     
              ),
            ),
          ],
        )
      ),
      body: Stack(
        children: <Widget> [
          Positioned(
            top: 50,
            left: 80,
            // right: 0,
            // bottom: 0,
            width: MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).size.height - 50,
            child: SafeArea(
              child: Container(
                alignment: Alignment.topLeft,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: List<int>.generate(3, (i) => i).map((i) {
                          return Container(
                            width: (MediaQuery.of(context).size.width-80)/3,
                            decoration: BoxDecoration(
                              color: Colors.white
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
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            width: 80,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(229, 229, 229, 1)
                ),
              )
            )
          ),
          MyAppBar(),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.menu),
                color: Colors.black,
                iconSize: 32,
                onPressed: () {
                  _drawerKey.currentState.openDrawer();
                },
              ),
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