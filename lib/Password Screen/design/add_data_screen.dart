import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:my_pswd/Password%20Screen/provider/add_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  AddDataScreenState createState() => AddDataScreenState();
}

class AddDataScreenState extends State<AddDataScreen> {
  var appNameController = TextEditingController();
  var userNameController = TextEditingController();
  var upiUserIdController = TextEditingController();
  var passwordPINController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var creditDebitController = TextEditingController();
  var cvvController = TextEditingController();
  var ifscController = TextEditingController();
  var accountNoController = TextEditingController();
  var expiredDateController = TextEditingController();
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
  FocusNode expiredDateFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  MaskedTextController creditDebitMask = MaskedTextController(mask: '0000 0000 0000 0000');
  MaskedTextController expiredDateMask = MaskedTextController(mask: '00/00');
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
  final iv = encrypt.IV.fromLength(16);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
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
                Provider.of<AddDataProvider>(context,listen: false).isObscurePassword = true;
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
          child: Consumer<AddDataProvider>(builder: (context, snapshot, _) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                    child: TextFormField(
                      controller: appNameController,
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
                      controller: userNameController,
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
                      controller: upiUserIdController,
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
                      controller: emailController,
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
                      controller: phoneController,
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
                      controller: accountNoController,
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
                      controller: ifscController,
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
                      controller: creditDebitMask,
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
                      controller: expiredDateMask,
                      focusNode: expiredDateFocusNode,
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
                      controller: cvvController,
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
                      controller: passwordPINController,
                      focusNode: passwordPINFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.darkMaroon,
                      obscureText: snapshot.isObscurePassword ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              snapshot.checkPasswordVisibility();
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
                      Provider.of<AddDataProvider>(context,listen: false).isObscurePassword = true;
                      // print("main text ${passwordPINController.text}");
                      // print("encrypt ${encrypter.encrypt(passwordPINController.text,iv: encrypt.IV.fromLength(16)).base64.toString()}");
                      // print("decrypt ${encrypter.decrypt(encrypter.encrypt(passwordPINController.text, iv: iv), iv: iv)}");
                      if (_formKey.currentState!.validate()) {
                        Provider.of<AddDataProvider>(context, listen: false)
                            .addData(
                                appNameController.text,
                                userNameController.text,
                                upiUserIdController.text,
                                emailController.text,
                                phoneController.text,
                                accountNoController.text,
                                ifscController.text,
                                creditDebitMask.text,
                                expiredDateMask.text,
                                cvvController.text,
                                // passwordPINController.text,
                                encrypter.encrypt(passwordPINController.text,iv: iv).base64.toString(),
                            context);
                      }
                    },
                    child: Provider.of<AddDataProvider>(context, listen: false)
                                .isLoading ==
                            true
                        ? Container(
                            height: 45,
                            width: 95,
                            decoration: BoxDecoration(
                              color: AppColor.darkMaroon,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: AppColor.white,
                            )),
                          )
                        : Container(
                            // height: 45,
                            // width: 95,
                            decoration: BoxDecoration(
                              color: AppColor.darkMaroon,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Submit",
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
