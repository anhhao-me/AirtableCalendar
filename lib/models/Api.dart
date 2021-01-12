import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String _apiHost = 'https://beta-api.langf.vn';

  String getApi(path){
    return _apiHost + path;
  }

  Future<Map<String, dynamic>> makePost(String path, { Map<String, String> headers, Map<String, dynamic> payload }) async {
    if (headers == null){
      headers = {};
    }

    String body = jsonEncode(payload);
    Map<String, String> defaultHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') != null){
      defaultHeaders.addAll(<String, String> {'Authorization': prefs.getString('auth-token')});
    }
    
    http.Response res = await http.post(
      getApi(path), 
      headers: defaultHeaders..addAll(headers),
      body: body
    );

    if ((res.statusCode / 100).floor() == 2){
      return jsonDecode(res.body);
    }

    print(res.body);
    return null;
  }

  Future<Map<String, dynamic>> makeGet(String path, { Map<String, String> headers }) async {
    if (headers == null){
      headers = {};
    }

    Map<String, String> defaultHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') != null){
      defaultHeaders.addAll(<String, String> {'Authorization': prefs.getString('auth-token')});
    }
    
    http.Response res = await http.get(
      getApi(path), 
      headers: defaultHeaders..addAll(headers)
    );

    if ((res.statusCode / 100).floor() == 2){
      return jsonDecode(res.body);
    }

    print(res.body);
    return null;
  }
}