import 'package:flutter/material.dart';
import 'package:my_pswd/Password%20Screen/provider/add_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {

  var appNameController = TextEditingController();
  var userNameController = TextEditingController();
  var upiUserIdController = TextEditingController();
  var passwordPINController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var creditDebitController = TextEditingController();
  FocusNode appNameFocusNode = new FocusNode();
  FocusNode userNameFocusNode = new FocusNode();
  FocusNode upiUserIdFocusNode = new FocusNode();
  FocusNode passwordPINFocusNode = new FocusNode();
  FocusNode phoneFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode creditDebitFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
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
              "Add data here",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: appNameController,
                  focusNode: appNameFocusNode,
                  textInputAction: TextInputAction.next,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'App Name / Bank Name / Account',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: userNameController,
                  focusNode: userNameFocusNode,
                  textInputAction: TextInputAction.next,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: upiUserIdController,
                  focusNode: upiUserIdFocusNode,
                  textInputAction: TextInputAction.next,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'User ID / Upi ID',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  textInputAction: TextInputAction.next,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'Phone no.',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: creditDebitController,
                  focusNode: creditDebitFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'Credit/Debit Card No.',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Container(
                child: TextFormField(
                  controller: passwordPINController,
                  focusNode: passwordPINFocusNode,
                  textInputAction: TextInputAction.next,
                  cursorColor:  AppColor.darkMaroon,
                  decoration: const InputDecoration(
                    labelText: 'Password/PIN',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (){
                Provider.of<AddDataProvider>(context,listen: false).addData(
                    appNameController.text,
                    userNameController.text,
                    upiUserIdController.text,
                    emailController.text,
                    phoneController.text,
                    creditDebitController.text,
                    passwordPINController.text,
                  context
                );
              },
              child: Container(
                height: 45,
                width: 95,
                decoration: BoxDecoration(
                  color: AppColor.darkMaroon,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  const Center(
                  child: Text("Submit",
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
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
