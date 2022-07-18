import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DocsProvider extends ChangeNotifier{

  List<File>? files;
  final firebase = FirebaseFirestore.instance;

  pickFiles() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','pdf','doc','png','jpeg','txt','xls','docx','svg'],
        allowMultiple: true
    );
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      uploadFiles();
      notifyListeners();
    } else {
      print("else in pickFiles");
    }
  }

  uploadFiles() async{
    var fileName = files!.map((e) => basename(e.path.toString())).toList();
    final destination = 'images/$fileName';
    print("file Name :- $fileName");
    final ref = FirebaseStorage.instance.ref().child(destination).putFile(files!.single);
    final snapshot = await ref.whenComplete(() {});
    final urlDownloads = await snapshot.ref.getDownloadURL().whenComplete(() {});
    addData(urlDownloads,fileName.single);
    print("down $urlDownloads");
    notifyListeners();
    return urlDownloads;
  }

  addData(String note,String name) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Docs')
        .doc()
        .set({
      "doc": note,
      "name": name
    });
    notifyListeners();
  }
}