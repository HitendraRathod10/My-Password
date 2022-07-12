import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';
import 'package:my_pswd/Password%20Screen/provider/update_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import '../provider/show_data_provider.dart';

class UpdateDataScreen extends StatefulWidget {
  String? id;
  UpdateDataScreen({required this.id});

  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  FocusNode appNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode upiUserIdFocusNode = FocusNode();
  FocusNode passwordPINFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode creditDebitFocusNode = FocusNode();
  FocusNode cvvFocusNode = FocusNode();
  FocusNode ifscFocusNode = FocusNode();
  FocusNode accountNoFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ShowDataProvider>(context, listen: false).isObscurePassword = false;
    Provider.of<UpdateDataProvider>(context, listen: false).getData(widget.id!);
  }

  willPop(context) {
    var snapshot = Provider.of<UpdateDataProvider>(context, listen: false);
    snapshot.appNameController.clear();
    snapshot.userNameController.clear();
    snapshot.upiUserIdController.clear();
    snapshot.emailController.clear();
    snapshot.phoneController.clear();
    snapshot.creditDebitController.clear();
    snapshot.passwordPINController.clear();
    snapshot.accountNoController.clear();
    snapshot.ifscController.clear();
    snapshot.cvvController.clear();
    Provider.of<UpdateDataProvider>(context, listen: false).isObscurePassword = true;
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
            child: Consumer<UpdateDataProvider>(builder: (context, snapshot, _) {
              return IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.black,
                ),
                onPressed: () {
                  snapshot.appNameController.clear();
                  snapshot.userNameController.clear();
                  snapshot.upiUserIdController.clear();
                  snapshot.emailController.clear();
                  snapshot.phoneController.clear();
                  snapshot.creditDebitController.clear();
                  snapshot.passwordPINController.clear();
                  snapshot.accountNoController.clear();
                  snapshot.ifscController.clear();
                  snapshot.cvvController.clear();
                  Provider.of<UpdateDataProvider>(context, listen: false).isObscurePassword = true;
                  Navigator.pop(context);
                  // Get.back();
                },
              );
            }),
          ),
          centerTitle: false,
          title: Column(
            children: const [
              Text(
                "Update data here",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 20,
                    fontFamily: AppFont.medium),
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
          child: Consumer<UpdateDataProvider>(builder: (context, snapshot, _) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.appNameController,
                      focusNode: appNameFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'App Name / Bank Name / Account',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return '* required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.userNameController,
                      focusNode: userNameFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.upiUserIdController,
                      focusNode: upiUserIdFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'User ID / Upi ID',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.emailController,
                      focusNode: emailFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'Email ID',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.phoneController,
                      focusNode: phoneFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'Phone no.',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.accountNoController,
                      focusNode: accountNoFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'Account No.',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.ifscController,
                      focusNode: ifscFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'IFSC Code',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.creditDebitController,
                      focusNode: creditDebitFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'Credit/Debit Card No.',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.cvvController,
                      focusNode: cvvFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.darkMaroon,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        labelStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: snapshot.passwordPINController,
                      focusNode: passwordPINFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      obscureText: snapshot.isObscurePassword ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              snapshot.checkPasswordVisibility();
                              print(snapshot.isObscurePassword);
                            },
                            icon: snapshot.isObscurePassword == false
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColor.darkMaroon,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: AppColor.darkMaroon)),
                        labelText: 'Password/PIN',
                        labelStyle: const TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<UpdateDataProvider>(context, listen: false)
                          .isObscurePassword = true;
                      if (_formKey.currentState!.validate()) {
                        Provider.of<UpdateDataProvider>(context, listen: false)
                            .updateData(
                                snapshot.appNameController.text,
                                snapshot.userNameController.text,
                                snapshot.upiUserIdController.text,
                                snapshot.emailController.text,
                                snapshot.phoneController.text,
                                snapshot.accountNoController.text,
                                snapshot.ifscController.text,
                                snapshot.creditDebitController.text,
                                snapshot.cvvController.text,
                                snapshot.passwordPINController.text,
                                widget.id!,
                                context);
                      }
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateDataScreen()));
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                    },
                    child: Container(
                      height: 45,
                      width: 145,
                      decoration: BoxDecoration(
                        color: AppColor.darkMaroon,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Update Data",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFont.semiBold),
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
          }),
        ),
      ),
    );
  }
}
