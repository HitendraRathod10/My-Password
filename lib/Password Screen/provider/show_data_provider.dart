import 'package:flutter/material.dart';

class ShowDataProvider extends ChangeNotifier{

  bool isObscurePassword = false;

  checkPasswordVisibility() {
    isObscurePassword=!isObscurePassword;
    notifyListeners();
  }
}