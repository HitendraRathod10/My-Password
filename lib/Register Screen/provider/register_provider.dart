import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Login%20Screen/design/login_screen.dart';

class RegisterProvider extends ChangeNotifier{
  bool registerPswd =  true;
  bool registerConfirmPswd =  true;
  final _auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  bool loader = false;

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
      String fname, String lname, String phone,BuildContext? context)async{
    EasyLoading.show(status: 'loading...');
    email = email.trim();
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // if(newUser != null){
      // startLoading();
      insertData(fname, lname, email, phone);
      // EasyLoading.showToast("Register Successfully",
      //     toastPosition: EasyLoadingToastPosition.bottom,
      // );
      Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      EasyLoading.dismiss();
      // stopLoading();
    // }else{
    //   print("newUser null (createNewUser)");
    // }
    notifyListeners();
  }

//For loader
/*  stopLoading(){
    loader = false;
    notifyListeners();
  }

  startLoading(){
    loader = true;
    notifyListeners();
  }*/

}