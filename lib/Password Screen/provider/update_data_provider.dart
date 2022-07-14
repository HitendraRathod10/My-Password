import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Home Screen/design/home_screen.dart';

class UpdateDataProvider extends ChangeNotifier{
  final firebase = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isObscurePassword = false;
  updateData(String appName, String userName,
      String userId, String emailId,
      String phone, String accountNo,
      String ifscCode, String creditDebitCard,
      String cvv, String passwordPin,
      String id, BuildContext context) async{
    isLoading = true;
    // print("email ${FirebaseAuth.instance.currentUser?.email}");
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Data')
        .doc(id)
        .update({
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

  var querySnapshots;
  var appNameController = TextEditingController();
  var userNameController = TextEditingController();
  var upiUserIdController = TextEditingController();
  var passwordPINController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var creditDebitController = TextEditingController();
  var cvvController = TextEditingController();
  var ifscController = TextEditingController();
  var accountNoController = TextEditingController();

  getData(String id)async{
    CollectionReference  collection = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data");
    querySnapshots = await collection.doc(id).get();
    appNameController.text = querySnapshots.get("appName");
    userNameController.text = querySnapshots.get("userName");
    upiUserIdController.text = querySnapshots.get("userId");
    passwordPINController.text = querySnapshots.get("passwordPin");
    phoneController.text = querySnapshots.get("phone");
    emailController.text = querySnapshots.get("emailId");
    creditDebitController.text = querySnapshots.get("creditDebitCard");
    cvvController.text = querySnapshots.get("cvv");
    ifscController.text = querySnapshots.get("ifscCode");
    accountNoController.text = querySnapshots.get("accountNo");
    notifyListeners();
  }

  checkPasswordVisibility() {
    isObscurePassword=!isObscurePassword;
    notifyListeners();
  }

}