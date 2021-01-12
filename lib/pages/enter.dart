import 'package:AirtableCalendar/widgets/spinner.dart';
import 'package:flutter/material.dart';

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

    // AuthModel authModel = AuthModel();
    // String token = await authModel.login(email, password);

    setState(() {
      _isLoad = false;

      // if (token == null){
      //   Scaffold.of(context).showSnackBar(
      //     SnackBar(
      //       duration: Duration(seconds: 3 ),
      //       content: Text('Email hoặc mật khẩu không đúng!'),
      //       action: SnackBarAction(
      //         textColor: Colors.white,
      //         label: 'Đóng',
      //         onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
      //       )
      //     )
      //   );
      // } else {
      //   Scaffold.of(context).showSnackBar(
      //     SnackBar(
      //       duration: Duration(seconds: 3 ),
      //       content: Text('Đăng nhập thành công!'),
      //       action: SnackBarAction(
      //         textColor: Colors.white,
      //         label: 'Đóng',
      //         onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
      //       )
      //     )
      //   );

      //   Navigator.of(context).pushReplacementNamed('/');
      // }
    });
  }
}