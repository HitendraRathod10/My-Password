import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool loginPswd =  true;
  final _auth = FirebaseAuth.instance;

  checkPasswordVisibility() {
    loginPswd=!loginPswd;
    notifyListeners();
  }

  loginWithEmail(String email,String password)async{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}