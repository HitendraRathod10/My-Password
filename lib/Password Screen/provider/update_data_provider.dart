import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../Home Screen/design/home_screen.dart';

class UpdateDataProvider extends ChangeNotifier{
  final firebase = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isObscurePassword = false;
  updateData(String appName, String userName,
      String userId, String emailId,
      String phone, String accountNo,
      String ifscCode, String creditDebitCard,
      String expiredDate,
      String cvv, String passwordPin,
      String id, BuildContext? context) async{
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
      "expiredDate": expiredDate,
      "cvv": cvv,
      "passwordPin": passwordPin
    });
    isLoading = false;
    Navigator.pushAndRemoveUntil(context!, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
    notifyListeners();
  }

  DocumentSnapshot? querySnapshots;
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
  MaskedTextController creditDebitMask = MaskedTextController(mask: '0000 0000 0000 0000');
  MaskedTextController expiredDateMask = MaskedTextController(mask: '00/00');
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
  final iv = encrypt.IV.fromLength(16);
  getData(String id)async{
    CollectionReference  collection = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data");
    querySnapshots = await collection.doc(id).get();
    appNameController.text = querySnapshots!.get("appName");
    userNameController.text = querySnapshots!.get("userName");
    upiUserIdController.text = querySnapshots!.get("userId");
    // passwordPINController.text = querySnapshots.get("passwordPin");
    passwordPINController.text = encrypter.decrypt64(querySnapshots!.get("passwordPin"),iv: iv);
    phoneController.text = querySnapshots!.get("phone");
    emailController.text = querySnapshots!.get("emailId");
    creditDebitMask.text = querySnapshots!.get("creditDebitCard");
    expiredDateMask.text = querySnapshots!.get("expiredDate");
    cvvController.text = querySnapshots!.get("cvv");
    ifscController.text = querySnapshots!.get("ifscCode");
    accountNoController.text = querySnapshots!.get("accountNo");
    notifyListeners();
  }

  checkPasswordVisibility() {
    isObscurePassword=!isObscurePassword;
    notifyListeners();
  }

}