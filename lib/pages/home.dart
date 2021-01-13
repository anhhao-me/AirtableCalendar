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
          Container(
            alignment: Alignment.center,
            child: Text('Hello World')
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