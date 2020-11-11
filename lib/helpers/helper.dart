import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ShowMatch/screens/auth_welcome/login.dart';

Future < void > errorMessage(context, [String msg]) async {

  if (msg == null) {
    msg = "Server com failed. Check your internet or contact the sysadmin";
  }

  Widget okButton = FlatButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text("OK")
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(msg),
          actions: [okButton],
        );
      }
    );
  });
}

postRequest(context, String apiEndpoint, Map < String, String > json) async {

  String fullEndpoint = "http://aikenahac.ddns.net:3000/$apiEndpoint";

  String sendBody = jsonEncode(json);

  Map < String, String > headers = {
    "Content-type": "application/json"
  };

  // Making the POST request to the apiEndpoint with the body of json
  Response response = await post(fullEndpoint, headers: headers, body: sendBody);

  // checking the status code 
  int statusCode = response.statusCode;

  // Getting the response body
  String body = response.body;
  
  print(statusCode);
  print(body);

  return response;
}