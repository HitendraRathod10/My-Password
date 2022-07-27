import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';

import '../design/login_screen.dart';

class LoginProvider extends ChangeNotifier{
  bool loginPswd =  false;
  final _auth = FirebaseAuth.instance;

  checkPasswordVisibility() {
    loginPswd=!loginPswd;
    notifyListeners();
  }

  loginWithEmail(String email,String password,BuildContext context)async{
    loginPswd = false;
    EasyLoading.show(status: 'loading...');
    try {
      email = email.trim();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // EasyLoading.showToast("Login Successfully",
      //     toastPosition: EasyLoadingToastPosition.bottom
      // );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    } on Exception catch (e) {
      print("e => ${e}");
      EasyLoading.showToast("Your email or password is invalid !!",
          toastPosition: EasyLoadingToastPosition.bottom,
      );
    }
    EasyLoading.dismiss();
  }
}
