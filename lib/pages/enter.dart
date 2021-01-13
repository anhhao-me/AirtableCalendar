import 'package:AirtableCalendar/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterPage extends StatefulWidget {
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  bool _isLoad = false;

  Widget build(BuildContext rootContext){
    TextEditingController tableUrlController = TextEditingController();
    TextEditingController apiKeyController = TextEditingController();

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => Stack(
          children: <Widget> [
            SafeArea(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            controller: tableUrlController,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.blue)),
                              labelText: 'Table URL'
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            obscureText: true,
                            controller: apiKeyController,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.blue)),
                              labelText: 'API KEY'
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text('ENTER'),
                                onPressed: () => setState(() {
                                  _isLoad = true;
                                  _verify(context, tableUrlController.text, apiKeyController.text);
                                }),
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]
              )
            ),
            if (_isLoad) Container(
              color: Color.fromRGBO(255, 255, 255, .5),
              child: SpinnerWidget()
            )
          ]
        )
      )
    );
  }

  Future<void> _verify(BuildContext context, String tableUrl, String apiKey) async {
    FocusScope.of(context).unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', apiKey);
    prefs.setString('tableUrl', tableUrl);

    setState(() {
      _isLoad = false;
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
}