import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';

class AddDataProvider extends ChangeNotifier {
  final firebase = FirebaseFirestore.instance;
  bool? isLoading;
  bool isObscurePassword = true;

  addData(String appName, String userName, String userId, String emailId, String phone,
  String accountNo, String ifscCode, String creditDebitCard, String cvv,String passwordPin,BuildContext context) async {
    isLoading = true;
    // print("email ${FirebaseAuth.instance.currentUser?.email}");
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Data')
        .doc()
        .set({
      "appName": appName,
      "userName": userName,
      "userId": userId,
      "emailId": emailId,
      "phone": phone,
      "accountNo": accountNo,
      "ifscCode": ifscCode,
      "creditDebitCard": creditDebitCard,
      "cvv": cvv,
      "passwordPin": passwordPin
    });
    isLoading = false;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    notifyListeners();
  }

  checkPasswordVisibility() {
    isObscurePassword=!isObscurePassword;
    notifyListeners();
  }
}
