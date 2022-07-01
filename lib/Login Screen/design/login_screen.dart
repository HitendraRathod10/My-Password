import 'package:flutter/material.dart';

import '../../utils/app_font.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login Screen"),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            child: Text("Login",
              style: TextStyle(
                  // color: AppColor.black,
                  fontSize: 24,
                  fontFamily: AppFont.bold
              ),
            ),
          ),
          Container(

          )
        ],
      ),
    );
  }
}
