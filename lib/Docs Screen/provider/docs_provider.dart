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
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class DocsProvider extends ChangeNotifier{

  List<File>? files;
  Dio dio = Dio();
  double progress = 0.0;
  final firebase = FirebaseFirestore.instance;

  pickFiles(BuildContext context) async{
    final status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.storage.request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','pdf','png','jpeg'],
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

  Future<bool> savePdf(url, fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
              print("android folder not available $newPath");
              notifyListeners();
            } else {
              break;
            }
          }
          newPath = newPath + "/MyPassword";
          print("newPath $newPath");
          directory = Directory(newPath);
          print("directory $directory");
          notifyListeners();
          if (!await directory.exists()) {
            await directory.create(recursive: true);
            print("directory created");
            notifyListeners();
          }else{
            print("else not created");
          }
          if (await directory.exists()) {
            File saveFile = File(directory.path + "/$fileName");
            print("saveFilePATH ${saveFile.path}");
            print("url $url");
            await dio.download(url.toString(), saveFile.path,
                onReceiveProgress: (value1, value2) {
                  // setState(() {
                    progress = value1 / value2;
                    EasyLoading.showProgress(
                        progress, status: 'downloading...');
                  // });
                  notifyListeners();
                });
            print("saveFilePath ${saveFile.path}");
            return true;
          }
          return false;
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          print("permission.storage");
          directory = await getApplicationDocumentsDirectory();
          if (!await directory.exists()) {
            print("haha");
            await directory.create(recursive: true);
            print("nana");
          }else{
            print("directory exist j nthi krti");
          }
          if (await directory.exists()) {
            print("directory path ${directory.path}");
            File saveFile = File(directory.path + "/$fileName");
            print("url ${url.toString()}");
            await dio.download(url.toString(), saveFile.path,
                onReceiveProgress: (value1, value2) {
                  // setState(() {
                    progress = value1 / value2;
                    EasyLoading.showProgress(
                        progress, status: 'downloading...');
                    notifyListeners();
                  // });
                });
            return true;
          }else{
            print("else false");
            return false;
          }

        } else {
          return false;
        }
      }
    } catch (e) {
      debugPrint("catch print..........  ${e.toString()}");
      return false;
    }
  }

  downloadFile(param0,param1) async {
    // setState(() {
    //   loading = true;
      EasyLoading.showProgress(0.1, status: 'downloading...');
    // });
    bool downloaded = await savePdf(param0,param1);
    notifyListeners();
    if (downloaded) {
      // AppUtils.instance.showToast(toastMessage: "File Downloaded.");
      EasyLoading.showSuccess('Downloaded Success!');
      debugPrint("File Downloaded");
    } else {
      EasyLoading.showError('Failed with Downloaded');
      debugPrint("Problem Downloading File");
    }
    EasyLoading.dismiss();
    // setState(() {
    //   loading = false;
    // });
    notifyListeners();
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      PermissionStatus result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}