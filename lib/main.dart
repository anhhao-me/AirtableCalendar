import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AirtableCalendar/pages/loader.dart';
import 'package:AirtableCalendar/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => MaterialApp(
        title: 'Chủ cửa hàng - 72loca.vn',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xffc33332),
          accentColor: Colors.redAccent,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme
          )
        ),
        home: LoaderPage(),
        routes: {
          '/home': (BuildContext context) => HomePage()
        },
      )
    );
  }
}