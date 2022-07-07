import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Password%20Screen/design/add_data_screen.dart';
import 'package:my_pswd/Password%20Screen/design/show_data_screen.dart';
import 'package:my_pswd/utils/app_color.dart';
import '../../utils/app_font.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  final firebase = FirebaseFirestore.instance;

  loader(){
    EasyLoading.show(status: 'loading...');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkMaroon,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDataScreen()));
        },
      ),
      body: StreamBuilder(
        stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if(snapshot.hasData) {
            EasyLoading.dismiss();
            return
              ListView.builder(
                itemCount: snapshot.data!.docChanges.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          ShowDataScreen(snapshot.data!.docChanges[index].doc)));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColor.darkMaroon,
                                  child: Text("${index+1}",
                                    style: const TextStyle(
                                        color: AppColor.white
                                    ),
                                  ),
                                ),
                                title: Text("${snapshot.data!.docChanges[index].doc.get("appName")}"),
                                trailing: const Icon(Icons.chevron_right),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }else{
            return loader();
          }
        }
      ),
    );
  }
}
