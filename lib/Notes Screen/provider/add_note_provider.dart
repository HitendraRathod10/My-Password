import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pswd/Notes%20Screen/design/notes_screen.dart';

import '../../Home Screen/design/home_screen.dart';

class AddNoteProvider extends ChangeNotifier{

  final firebase = FirebaseFirestore.instance;

  addNote(String note,BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc()
        .set({
      "note": note,
    });
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    notifyListeners();
  }
}