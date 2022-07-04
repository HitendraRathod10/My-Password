import 'package:flutter/material.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:my_pswd/utils/app_font.dart';
import 'package:my_pswd/utils/app_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLogin(){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  AppImage.splashLogo,
                  height: 200,
                  width: 200,
                  // fit: BoxFit.fill,
                ),
              ),
              const Text("My Password",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: AppFont.extraBold,
                    color: AppColor.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
