import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Home Screen/design/home_screen.dart';

class ShowUpdateNoteProvider extends ChangeNotifier{
  final firebase = FirebaseFirestore.instance;
  var querySnapshots;
  var noteController = TextEditingController();
  bool isLoading = false;

  getData(String id) async{
    // print("got ${id}");
    CollectionReference  collection = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes");
    querySnapshots = await collection.doc(id).get();
    noteController.text = querySnapshots.get("note");
    // print("in getData note ${noteController.text}");
    notifyListeners();
  }

  updateData(String note, String id, BuildContext context) async {
    isLoading = true;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc(id)
        .update({
      "note": note,
    });
    isLoading = false;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    notifyListeners();
  }

  deleteNote()async {
    var collection = FirebaseFirestore.instance.collection('User').doc(
        FirebaseAuth.instance.currentUser!.email).collection("Notes");
    var snapshot = await collection.where('note', isEqualTo: "").get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
      notifyListeners();
    }
  }
}