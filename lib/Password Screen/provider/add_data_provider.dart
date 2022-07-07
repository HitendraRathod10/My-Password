import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';

class AddDataProvider extends ChangeNotifier {
  final firebase = FirebaseFirestore.instance;

  addData(String appName, String userName, String userId, String emailId, String phone,
      String creditDebitCard, String passwordPin,BuildContext context) async {
    print("email ${FirebaseAuth.instance.currentUser?.email}");
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
      "creditDebitCard": creditDebitCard,
      "passwordPin": passwordPin
    });
    EasyLoading.showToast("Data added successfully.");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    notifyListeners();
  }
}
