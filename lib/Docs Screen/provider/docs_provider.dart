import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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

  pickFiles(BuildContext? context) async{
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
      uploadFiles(context!).then((value) {
        Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
      });
      notifyListeners();
    } else {
      debugPrint("else in pickFiles");
    }
  }

  Future uploadFiles(BuildContext? context) async{
    var fileName = files!.map((e) => basename(e.path.toString())).toList();
    final destination = 'images/$fileName';
    debugPrint("file Name :- $fileName");
    final ref = FirebaseStorage.instance.ref().child(destination).putFile(files!.single);
    final snapshot = await ref.whenComplete(() {});
    final urlDownloads = await snapshot.ref.getDownloadURL().whenComplete(() {});
    addData(urlDownloads,fileName.single);
    debugPrint("url $urlDownloads");
    EasyLoading.dismiss();
    // Provider.of<HomeProvider>(context!,listen: false).onItemTapped(2);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
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

  Future<void> savePdf(url, fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        debugPrint('DeviceSdk=>${androidInfo.version.sdkInt}');
        if (androidInfo.version.sdkInt! >= 33) {
        } else {
          await Permission.storage.status.isGranted;
        }
        if (status.isGranted || androidInfo.version.sdkInt! >= 33) {
          debugPrint('Permission Granted');
          final externalDir = Platform.isAndroid
              ? await getExternalStorageDirectory()
              : await getApplicationDocumentsDirectory();
          final id = await FlutterDownloader.enqueue(
              url: url,
              savedDir: externalDir!.path,
              showNotification: false,
              fileName: '$fileName',
              openFileFromNotification: true,
              saveInPublicStorage: true)
              .then((value) {
            print("after FlutterDownloader.enqueue ${value}");
            EasyLoading.showSuccess('Downloaded Success!');
            EasyLoading.dismiss();

          });
          debugPrint('after download code');
        } else {
          print("here else permission");
        }
      }
    } catch (e) {
      debugPrint("catch print..........  ${e.toString()}");
    }
  }

  downloadFile(param0,param1) async {
    // setState(() {
    //   loading = true;
      EasyLoading.showProgress(0.1, status: 'downloading...');
    // });
     await savePdf(param0,param1);
    notifyListeners();
    // if (downloaded) {
    //   // AppUtils.instance.showToast(toastMessage: "File Downloaded.");
    //   EasyLoading.showSuccess('Downloaded Success!');
    //   debugPrint("File Downloaded");
    // } else {
    //   EasyLoading.showError('Failed with Downloaded');
    //   debugPrint("Problem Downloading File");
    // }
    // EasyLoading.dismiss();
    // setState(() {
    //   loading = false;
    // });
    notifyListeners();
  }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     PermissionStatus result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      notifyListeners();
      return true;
    } else {
      var state = await Permission.manageExternalStorage.status;
      var state2 = await Permission.storage.status;
      if (!state2.isGranted) {
        await Permission.storage.request();
        notifyListeners();
      }
      if (!state.isGranted) {
        await Permission.manageExternalStorage.request();
        notifyListeners();
      }
      if (state2.isGranted) {
        notifyListeners();
        return true;
      }
      if (state.isGranted) {
        notifyListeners();
        return true;
      }

      // PermissionStatus result = await permission.request();
      // print("result ${result.isGranted}");
      // PermissionStatus resultAccessMediaLocation = await permission.request();
      // print("resultAccessMediaLocation ${resultAccessMediaLocation.isGranted}");
      // PermissionStatus resultManageExternalStorage = await permission.request();
      // print("resultManageExternalStorage ${resultManageExternalStorage.isGranted}");
      // if (result == PermissionStatus.granted && resultAccessMediaLocation == PermissionStatus.granted && resultManageExternalStorage == PermissionStatus.granted) {
      //   return true;
      // }
    }
    notifyListeners();
    return false;
  }
}