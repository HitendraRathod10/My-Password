import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Home Screen/design/home_screen.dart';

class AddNoteProvider extends ChangeNotifier{

  final firebase = FirebaseFirestore.instance;

  addNote(String note,BuildContext? context) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc()
        .set({
      "note": note,
    });
    // Navigator.popAndPushNamed(context, '/home');
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    // Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context!, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NotesScreen()), (route) => false);
    notifyListeners();
  }
}