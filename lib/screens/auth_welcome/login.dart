// Premade libraries import
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ShowMatch/components/buttons.dart';
import 'package:ShowMatch/helpers/preferences.dart';

// Importing required custom screens and scripts
import 'package:ShowMatch/screens/interface/home.dart';
import 'package:ShowMatch/helpers/helper.dart';

// Importing custom widgets

final emailController = TextEditingController();
final passwordController = TextEditingController();

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.grey[600],
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey[400],
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State < Login > {
  bool isKeyboardOpen = false;

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: < Widget > [
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0, ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            cursorWidth: 2.5,
            cursorColor: Colors.white,
            controller: emailController,
            autofillHints: < String > [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(

              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Enter your email address",
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _passwordField() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60,
      child: TextField(
        cursorColor: Colors.white,
        cursorWidth: 2.5,
        controller: passwordController,
        autofillHints: < String > [AutofillHints.password],
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: "Enter your password",
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Future _login() async {
    print("Hello");
    // Check if the fields are empty, if so displaying an error
    if ((passwordController.text.isEmpty) || (emailController.text.isEmpty)) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Dude put in some info pls"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK")
              )
            ],
          );
        }
      );
    } else {
      print("Hello to you");
      // Mapping the data
      Map < String, String > loginData = {
        "email": emailController.text,
        "password": passwordController.text
      };
      print("Data has been spotted");

      var rsp = await postRequest(context, 'user/login/', loginData);
      
      Map < String, dynamic > rData = jsonDecode(rsp.body);
      print(rData);
      print(rData['token']);
      print(rsp.statusCode);

      if (rsp.statusCode == 200) {
        print("is 200 really ${rsp.statusCode}");

        defaultValues(rData["body"], context)
          .then((login) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          });        
      } else if (rsp.statusCode == 400) {
        errorMessage(
          context,
          "Incorrect email or password"
        );
      } else {
        errorMessage(context);
      }
        
        /*.then((response) {
          print("Pushing");

          Map < String, dynamic > recievedData = jsonDecode(response.body);
          print("Ooga booga ${response.statusCode}");

          if (response.statusCode == 200) { // Accepted
            print("XD 200");
            // Saving the token into SharedPreferences
            defaultValues(recievedData['token'], context)
              .then((login) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });

          } else if (response.statusCode == 403) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Wrong login information"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK")
                    )
                  ],
                );
              }
            );
          } else { // Other errors
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("An unknown error has occurred. Please contact the sysadmin"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK")
                    )
                  ],
                );
              }
            );
          }
        })
        .catchError((err) {});*/
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light
      )
    );

    // Keyboard visibility check (if == 0.0) keyboard is hidden
    if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
      setState(() {
        isKeyboardOpen = false;
      });
    } else {
      setState(() {
        isKeyboardOpen = true;
      });
    }

    return Scaffold(
      body: Stack(
        children: < Widget > [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0, vertical: 80.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: < Widget > [
                  new Image.asset('assets/images/placeholder.png', height: 150.0),
                  new Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 3,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _emailField(),
                  SizedBox(height: 30.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: < Widget > [
                      Text(
                        'Password',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      _passwordField(),
                      //_forgotPassBtn(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: isKeyboardOpen ? null :
      fabExtended(150.0, "Login", null, Color.fromRGBO(33, 222, 170, 1), _login, Colors.white, "login"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}