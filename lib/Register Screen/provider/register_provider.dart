import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pswd/Login%20Screen/design/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier{
  bool registerPswd =  true;
  bool registerConfirmPswd =  true;
  final _auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;

  checkPasswordVisibility() {
    registerPswd=!registerPswd;
    notifyListeners();
  }

  checkConfirmPasswordVisibility() {
    registerConfirmPswd=!registerConfirmPswd;
    notifyListeners();
  }

  insertData(String fname,String lname,String email,String phone)async{

      await firebase.collection("User").doc(email).set({
        "fname" : fname,
        "lname" : lname,
        "mail" : email,
        "phone" : phone,
      });

      notifyListeners();
  }


  createNewUser(String email,String password,
      String fname, String lname, String phone,BuildContext context)async{
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if(newUser != null){
      insertData(fname, lname, email, phone);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }else{
      print("i m in else createNewUser");
    }
    notifyListeners();
  }

}