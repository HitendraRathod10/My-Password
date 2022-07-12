import 'package:flutter/material.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:my_pswd/utils/app_font.dart';
import 'package:my_pswd/utils/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home Screen/design/home_screen.dart';
import '../../Login Screen/design/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLogin() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3), ()
    {
      if (prefg.containsKey("key")) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColor.darkMaroon,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Container(
              //   child: Image.asset(
              //     AppImage.splashLogo,
              //     height: 200,
              //     width: 200,
              //   ),
              // ),
              Text("My Password...",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: AppFont.extraBold,
                    color: AppColor.darkMaroon
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
