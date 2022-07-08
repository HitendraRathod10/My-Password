import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_pswd/Password%20Screen/design/add_data_screen.dart';
import 'package:my_pswd/Password%20Screen/design/show_data_screen.dart';
import 'package:my_pswd/Password%20Screen/provider/password_provider.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:provider/provider.dart';
import '../../utils/app_font.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          if (!snapshot.hasData) return loader();
          // if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColor.darkMaroon,));
          if(snapshot.data!.size ==0) {
            EasyLoading.dismiss();
            return const Center(
              child: Text("No Data found",
            style: TextStyle(
                fontFamily: AppFont.bold,
                fontSize: 25
               ),
              ),
            );
          }
          if(snapshot.hasData) {
            EasyLoading.dismiss();
            return
              ListView.builder(
                itemCount: snapshot.data!.docChanges.length,
                itemBuilder: (context, index) {
                  // DocumentSnapshot<Object?> x = snapshot.data!.docChanges[index].doc;
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          ShowDataScreen(snapshot.data!.docChanges[index].doc)));
                    },
                    child: Slidable(
                      closeOnScroll: true,
                      endActionPane: const ActionPane(
                        extentRatio: 0.20,
                        children: [
                          SlidableAction(
                            autoClose: true,
                            onPressed: null,
                            // onPressed: deleteData(snapshot.data!.docChanges[index].doc.id),
                            // Provider.of<PasswordProvider>(context,listen: false).deleteData(),
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                        motion: ScrollMotion(),
                      ),
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
                    ),
                  );
                });
          }
          else{
            return loader();
          }
        }
      ),
    );
  }

  deleteData(index) {
    print(index);
    firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data").doc(index.toString()).delete();
  }
}
