import 'package:flutter/material.dart';
import 'package:my_pswd/Docs%20Screen/design/docs_screen.dart';
import 'package:my_pswd/Notes%20Screen/design/notes_screen.dart';
import 'package:my_pswd/Password%20Screen/design/password_screen.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 0;

  List<Widget> pages = [
    const PasswordScreen(),
    const NotesScreen(),
    const DocsScreen()
  ];

  onItemTapped(int index) {
      selectedIndex = index;
      notifyListeners();
  }

}