import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:my_pswd/Password%20Screen/design/add_data_screen.dart';
import 'package:my_pswd/Password%20Screen/design/update_data_screen.dart';
import 'package:my_pswd/Password%20Screen/provider/show_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ShowDataScreen extends StatefulWidget {
  DocumentSnapshot? doc;
  ShowDataScreen(this.doc, {Key? key}) : super(key: key);

  @override
  _ShowDataScreenState createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {

  final firebase = FirebaseFirestore.instance;
  String? store;
  String storeTwo = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store = widget.doc!.get("passwordPin");
    for(int i = 0; i < store!.length; i++){
    storeTwo = storeTwo + "*";
    }
    check();
  }

  check(){
    String text = '${widget.doc!.get("passwordPin")}';
    print("main ${text}");
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
    final iv = encrypt.IV.fromLength(16);
    // print("aa encrypt krse ${encrypter.encrypt(text,iv: encrypt.IV.fromLength(16)).base64.toString()}");
    print("aa decrypt krse ${encrypter.decrypt(encrypter.encrypt(text, iv: iv), iv: iv)}");
  }

  willPop(context) {
    Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(context),
      child: Scaffold(
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
                Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
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
                        const Text("Account No. : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                        Flexible(child: Text("${widget.doc!.get("accountNo")}",
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
                        const Text("IFSC Code : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                        Flexible(child: Text("${widget.doc!.get("ifscCode")}",
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
                        const Text("Credit/Debit Card : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
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
                    padding: const EdgeInsets.fromLTRB(15, 05, 15, 00),
                    child: Row(
                      children: [
                        const Text("Expired Date : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                        Flexible(child: Text("${widget.doc!.get("expiredDate")}",
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
                        const Text("CVV : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                        Flexible(child: Text("${widget.doc!.get("cvv")}",
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
                    child: Consumer<ShowDataProvider>(
                      builder: (context, snapshot,_) {
                        return Row(
                          children: [
                            const Text("Password/PIN : ",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),),
                            Flexible(
                              child: Container(
                                // width: 135,
                                alignment: Alignment.centerLeft,
                                child: snapshot.isObscurePassword ?
                                Text("${widget.doc!.get("passwordPin")}",
                                style: const TextStyle(fontSize: 20,fontFamily: AppFont.regular),
                                ) :
                                   Text(storeTwo,style: const TextStyle(fontSize: 20),)
                              ),
                            ),
                            // const Spacer(),
                            const SizedBox(
                              width: 05,
                            ),
                            InkWell(
                              onTap: (){
                                snapshot.checkPasswordVisibility();
                              },
                              child: snapshot.isObscurePassword ?
                              const Icon(
                                Icons.visibility,
                                color: AppColor.darkMaroon,
                                  // snapshot.isObscurePassword ?
                                  // Icons.visibility :
                                  // Icons.visibility_off
                              ) :
                                  const Icon(
                                    Icons.visibility_off,
                                    color: AppColor.darkMaroon,
                                  )
                            ),
                            const SizedBox(
                              width: 05,
                            ),
                            InkWell(
                              onTap: (){
                                Clipboard.setData(
                                    ClipboardData(
                                        text: "${widget.doc!.get("passwordPin")}"
                                    )
                                );
                              },
                              child: const Icon(
                                  Icons.copy,
                                color: AppColor.darkMaroon,
                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateDataScreen(id: widget.doc!.id,)));
                    },
                    child: Container(
                      height: 45,
                      // width: 95,
                      decoration: BoxDecoration(
                        color: AppColor.darkMaroon,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  const Padding(
                        padding: EdgeInsets.fromLTRB(15,06,15,00),
                        child: Text("Update",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFont.semiBold
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
