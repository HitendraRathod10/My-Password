import 'package:flutter/material.dart';

class ShowDataProvider extends ChangeNotifier{

  bool isObscurePassword = false;
  bool isCreditDebitCard = false;
  checkPasswordVisibility() {
    isObscurePassword=!isObscurePassword;
    notifyListeners();
  }
  checkPasswordVisibilityForCreditDebitCard() {
    isCreditDebitCard=!isCreditDebitCard;
    notifyListeners();
  }
}