import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:my_pswd/utils/app_font.dart';
import 'package:my_pswd/utils/app_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home Screen/design/home_screen.dart';
import '../../Home Screen/provider/home_provider.dart';
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
        // Provider.of<HomeProvider>(context,listen: false).onItemTapped(0);
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
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
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.splashDarkMaroon,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  AppImage.splashLogo,
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Sensitive Storage",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: AppFont.bold,
                    color: AppColor.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
