import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_pswd/Password%20Screen/provider/update_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import '../provider/show_data_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

//ignore: must_be_immutable
class UpdateDataScreen extends StatefulWidget {
  String? id;
  UpdateDataScreen({Key? key, required this.id}) : super(key: key);

  @override
  UpdateDataScreenState createState() => UpdateDataScreenState();
}

class UpdateDataScreenState extends State<UpdateDataScreen> {
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
    Provider.of<UpdateDataProvider>(context, listen: false).isObscurePassword = false;
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
              child: Consumer<UpdateDataProvider>(builder: (context, snapshot, _) {
                return IconButton(
                  iconSize: 30,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.white,
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
                    Provider.of<UpdateDataProvider>(context, listen: false).isObscurePassword = false;
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
                      color: AppColor.white,
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
            systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                        controller: snapshot.creditDebitMask,
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
                        controller: snapshot.expiredDateMask,
                        // focusNode: creditDebitFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        cursorColor: AppColor.darkMaroon,
                        decoration: const InputDecoration(
                          labelText: 'Expired Date',
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
                        obscureText: snapshot.isObscurePassword ? false : true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                snapshot.checkPasswordVisibility();
                              },
                              icon: snapshot.isObscurePassword == false
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: AppColor.darkMaroon,
                                    )
                                  : const Icon(Icons.visibility,
                                      color: AppColor.darkMaroon)),
                          labelText: 'Password/PIN',
                          labelStyle: const TextStyle(
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
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
                        Provider.of<UpdateDataProvider>(context, listen: false)
                            .isObscurePassword = false;
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
                                  snapshot.creditDebitMask.text,
                                  snapshot.expiredDateMask.text,
                                  snapshot.cvvController.text,
                                  // snapshot.passwordPINController.text,
                              encrypter.encrypt(snapshot.passwordPINController.text,iv: encrypt.IV.fromLength(16)).base64.toString(),
                                  widget.id!,
                                  context);
                        }
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateDataScreen()));
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                      },
                      child: Container(
                        height: 45,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: AppColor.darkMaroon,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15,06,15,00),
                          child: Text(
                            "Update",
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
      ),
    );
  }
}
