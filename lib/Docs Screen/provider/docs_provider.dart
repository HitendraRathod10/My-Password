import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';
import 'package:my_pswd/Home%20Screen/provider/home_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class DocsProvider extends ChangeNotifier{

  List<File>? files;
  final firebase = FirebaseFirestore.instance;

  pickFiles(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','pdf','doc','png','jpeg','xls','docx'],
        allowMultiple: true
    );
    if (result != null) {
      EasyLoading.show(status: 'loading...');
      files = result.paths.map((path) => File(path!)).toList();
      uploadFiles(context);
      notifyListeners();
    } else {
      print("else in pickFiles");
    }
  }

  uploadFiles(BuildContext context) async{
    var fileName = files!.map((e) => basename(e.path.toString())).toList();
    final destination = 'images/$fileName';
    print("file Name :- $fileName");
    final ref = FirebaseStorage.instance.ref().child(destination).putFile(files!.single);
    final snapshot = await ref.whenComplete(() {});
    final urlDownloads = await snapshot.ref.getDownloadURL().whenComplete(() {});
    addData(urlDownloads,fileName.single);
    print("url $urlDownloads");
    EasyLoading.dismiss();
    Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    notifyListeners();
    return urlDownloads;
  }

  addData(String doc,String name) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Docs')
        .doc()
        .set({
      "doc": doc,
      "name": name
    });
    notifyListeners();
  }
}