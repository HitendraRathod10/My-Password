import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class ShowDataScreen extends StatefulWidget {
  DocumentSnapshot? doc;
  ShowDataScreen(this.doc, {Key? key}) : super(key: key);

  @override
  _ShowDataScreenState createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {

  final firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.doc!.get("appName"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColor.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70.0),
            bottomRight: Radius.circular(70.0),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: IconButton(
            iconSize: 30,
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Get.back();
            },
          ),
        ),
        centerTitle: false,
        title: Column(
          children: const [
            Text(
              "Your data here",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 20,
                  fontFamily: AppFont.medium
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser?.email).collection("Data").snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 00),
                  child: Row(
                    children: [
                      const Text("App Name : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("appName")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                  child: Row(
                    children: [
                      const Text("User Name : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("userName")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                  child: Row(
                    children: [
                      const Text("User Id / Upi Id : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("userId")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                  child: Row(
                    children: [
                      const Text("Email Id : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("emailId")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                  child: Row(
                    children: [
                      const Text("Phone no. : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("phone")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                  child: Row(
                    children: [
                      const Text("Credit/Debit Card No. : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Flexible(child: Text("${widget.doc!.get("creditDebitCard")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),))
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 00, 15, 00),
                  child: Row(
                    children: [
                      const Text("Password/PIN : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                      Container(
                        width: 170,
                        child: Text("${widget.doc!.get("passwordPin")}",
                        style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(
                              ClipboardData(
                                  text: "${widget.doc!.get("passwordPin")}"
                              )
                          );
                        },
                        child: const Icon(Icons.copy),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
