import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_pswd/Password%20Screen/design/update_data_screen.dart';
import 'package:my_pswd/Password%20Screen/provider/show_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

//ignore: must_be_immutable
class ShowDataScreen extends StatefulWidget {
  DocumentSnapshot? doc;
  ShowDataScreen({Key? key, required this.doc}) : super(key: key);
  // ShowDataScreen(this.doc, {Key? key}) : super(key: key);

  @override
  ShowDataScreenState createState() => ShowDataScreenState();
}

class ShowDataScreenState extends State<ShowDataScreen> {

  final firebase = FirebaseFirestore.instance;
  String? store;
  String storeTwo = '';
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
  final iv = encrypt.IV.fromLength(16);
  String decryptData = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decryptData = encrypter.decrypt64(widget.doc!.get("passwordPin"),iv: iv);
    // print("from init decrypted $decryptData");
    // store = widget.doc!.get("passwordPin");
    for(int i = 0; i < decryptData.length; i++){
    storeTwo = "$storeTwo*";
    }

  }

  Widget showData(String title,String dataName){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(bottom: 05),
          child: Text(title,style: const TextStyle(fontFamily: AppFont.bold),),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              padding: const EdgeInsets.only(left: 05),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.darkMaroon,width: 1),
                // color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(dataName,style: const TextStyle(fontSize: 17),)
            // TextFormField(
            //   readOnly: true,
            //   decoration: const InputDecoration(
            //     border: InputBorder.none,
            //
            //   ),
            // ),
          ),
        ),
      ],
    );
  }

  willPop(context) {
    Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
    Provider.of<ShowDataProvider>(context,listen: false).isCreditDebitCard = false;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.darkMaroon,
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
                  color: AppColor.white,
                ),
                onPressed: () {
                  Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
                  Provider.of<ShowDataProvider>(context,listen: false).isCreditDebitCard = false;
                  Navigator.pop(context);
                  // Get.back();
                },
              ),
            ),
            centerTitle: false,
            title: Column(
              children: const [
                Text(
                  "Data",
                  style: TextStyle(
                      color: AppColor.white,
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
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser?.email).collection("Data").snapshots(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showData("App Name / Bank Name / Account", "${widget.doc!.get("appName")}"),
                      showData("User Name", widget.doc!.get("userName") == "" ? "—" : "${widget.doc!.get("userName")}"),
                      showData("User ID / Upi ID", widget.doc!.get("userId") == "" ? "—" : "${widget.doc!.get("userId")}"),
                      showData("Email ID", widget.doc!.get("emailId") == "" ? "—" : "${widget.doc!.get("emailId")}"),
                      showData("Phone no.", widget.doc!.get("phone") == "" ? "—" : "${widget.doc!.get("phone")}"),
                      showData("Account No.", widget.doc!.get("accountNo") == "" ? "—" : "${widget.doc!.get("accountNo")}"),
                      showData("IFSC Code", widget.doc!.get("ifscCode") == "" ? "—" : "${widget.doc!.get("ifscCode")}"),
                      // showData("Credit/Debit Card No.", "${widget.doc!.get("creditDebitCard")}"),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 05),
                        child: Text("Credit/Debit Card No.",style: TextStyle(fontFamily: AppFont.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Consumer<ShowDataProvider>(
                            builder: (context, snapshot,_) {
                              return Container(
                                  padding: const EdgeInsets.only(left: 05),
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.darkMaroon,width: 1),
                                    // color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: widget.doc!.get("creditDebitCard") != "" ?
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: snapshot.isCreditDebitCard ?
                                            Text("${widget.doc!.get("creditDebitCard")}",
                                                style: const TextStyle(
                                                    fontSize: 17
                                                )
                                            ) :
                                            const Text("**** **** **** ****",style: TextStyle(fontSize: 20),)
                                        ) :
                                            const Text("—",style: TextStyle(fontSize: 17),)
                                      ),
                                      widget.doc!.get("creditDebitCard") != "" ? InkWell(
                                          onTap: (){
                                            snapshot.checkPasswordVisibilityForCreditDebitCard();
                                          },
                                          child: snapshot.isCreditDebitCard ?
                                          const Icon(
                                            Icons.visibility,
                                            color: AppColor.darkMaroon,
                                          ) :
                                          const Icon(
                                            Icons.visibility_off,
                                            color: AppColor.darkMaroon,
                                          )
                                      ) :
                                          const SizedBox(),
                                      const SizedBox(
                                        width: 05,
                                      ),
                                      /*InkWell(
                                        onTap: (){
                                          Clipboard.setData(
                                              ClipboardData(
                                                  text: "${widget.doc!.get("creditDebitCard")}"
                                              )
                                          );
                                        },
                                        child: const Icon(
                                          Icons.copy,
                                          color: AppColor.darkMaroon,
                                        ),
                                      ),*/
                                      const SizedBox(
                                        width: 05,
                                      )
                                    ],
                                  )
                              );
                            }
                        ),
                      ),
                      showData("Valid Upto", widget.doc!.get("expiredDate") == "" ? "—" : "${widget.doc!.get("expiredDate")}"),
                      showData("CVV", widget.doc!.get("cvv") == "" ? "—" : "${widget.doc!.get("cvv")}"),
                      // showData("Password/PIN", "${widget.doc!.get("appName")}"),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 05),
                        child: Text("Password/PIN",style: TextStyle(fontFamily: AppFont.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Consumer<ShowDataProvider>(
                          builder: (context, snapshot,_) {
                            return Container(
                                padding: const EdgeInsets.only(left: 05),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.darkMaroon,width: 1),
                                  // color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                        child: snapshot.isObscurePassword ?
                                        Text(decryptData,
                                            style: const TextStyle(
                                                fontSize: 17
                                            )
                                        ) :
                                        Text(storeTwo,style: const TextStyle(fontSize: 20),)
                                      ),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          snapshot.checkPasswordVisibility();
                                        },
                                        child: snapshot.isObscurePassword ?
                                        const Icon(
                                          Icons.visibility,
                                          color: AppColor.darkMaroon,
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
                                                text: decryptData
                                            )
                                        );
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        color: AppColor.darkMaroon,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    )
                                  ],
                                )
                            );
                          }
                        ),
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                      /*Padding(
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
                                    Text(decryptData,
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
                                            text: "$decryptData"
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
                      ),*/
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateDataScreen(id: widget.doc!.id,)));
                        },
                        child: Center(
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
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
