import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Api {
  String apiKey;
  String tableUrl;

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('apiKey');
    tableUrl = prefs.getString('tableUrl');
  }

  Future<bool> check() async {
    if (apiKey == null || tableUrl == null || apiKey == '' || tableUrl == '')
      return false;

    try {
      var res = await this.makeGet('');
      print(res);
    } catch(_) {
      return false;
    }

    return true;
  }

  String getApi(path){
    return tableUrl + path;
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

    defaultHeaders.addAll(<String, String> {'Authorization': 'Bearer ' + apiKey});
    
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