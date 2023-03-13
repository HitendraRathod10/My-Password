import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PasswordProvider extends ChangeNotifier{

  final firebase = FirebaseFirestore.instance;

  //  deleteData(DocumentSnapshot x){
  //   try{
  //      firebase.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Data").doc(x.id).delete();
  //   }catch(e){
  //     print(e);
  //   }
  // }
}