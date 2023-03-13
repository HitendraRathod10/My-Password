import 'package:flutter/material.dart';
import 'package:my_pswd/Login%20Screen/design/login_screen.dart';
import 'package:my_pswd/Register%20Screen/provider/register_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();
  FocusNode myFocusNodeFirstName = FocusNode();
  FocusNode myFocusNodeLastName = FocusNode();
  FocusNode myFocusNodePhoneNo = FocusNode();
  FocusNode myFocusNodeConfirmPassword = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegExp passwordValidation = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              const Text(
                "Register",
                style: TextStyle(
                    color: AppColor.darkMaroon,
                    fontSize: 24,
                    fontFamily: AppFont.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextFormField(
                  // enabled: snapshot.isRegister ? false : true,
                  // readOnly: snapshot.isRegister ? true : false,
                  cursorColor: AppColor.darkGrey,
                  controller: firstNameController,
                  focusNode: myFocusNodeFirstName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.person, color: AppColor.darkMaroon),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.black)),
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider, fontFamily: AppFont.regular),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.trim().isEmpty) {
                      return 'Please enter first name';
                    }
                    // if (value.trim().length < 4) {
                    //   return 'Username must be at least 4 characters in length';
                    // }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextFormField(
                  cursorColor: AppColor.darkMaroon,
                  // enabled: snapshot.isRegister ? false : true,
                  controller: lastNameController,
                  focusNode: myFocusNodeLastName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.person, color: AppColor.darkMaroon),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.black)),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider, fontFamily: AppFont.regular),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.trim().isEmpty) {
                      return 'Please enter last name';
                    }
                    // if (value.trim().length < 4) {
                    //   return 'Username must be at least 4 characters in length';
                    // }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextFormField(
                  cursorColor: AppColor.darkMaroon,
                  // enabled: snapshot.isRegister ? false : true,
                  controller: phoneController,
                  focusNode: myFocusNodePhoneNo,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.phone, color: AppColor.darkMaroon),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.darkGrey)),
                    labelText: 'Phone no.',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider, fontFamily: AppFont.regular),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone no.';
                    } else if (value.length != 10) {
                      return 'Please put 10 digit mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 00),
                child: TextFormField(
                  cursorColor: AppColor.darkMaroon,
                  controller: emailController,
                  focusNode: myFocusNodeEmail,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                          Icons.email,
                          color: AppColor.darkMaroon
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.darkGrey
                          )
                      ),
                      labelText: 'Email ID',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                      // errorStyle: TextStyle(color: AppColor.darkMaroon)
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@"
                            r"[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter valid email';
                    } else if (value.trim().isEmpty || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child:
                    Consumer<RegisterProvider>(builder: (context, snapshot, _) {
                  return TextFormField(
                      // enabled: snapshot.isRegister ? false : true,
                      cursorColor: AppColor.darkGrey,
                      controller: passwordController,
                      focusNode: myFocusNodePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: snapshot.registerPswd ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              snapshot.checkPasswordVisibility();
                            },
                            icon: snapshot.registerPswd == false
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColor.darkMaroon,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: AppColor.darkMaroon)),
                        contentPadding: const EdgeInsets.all(0),
                        errorMaxLines: 2,
                        prefixIcon: const Icon(Icons.lock, color: AppColor.darkMaroon),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.darkGrey)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                        // errorStyle: TextStyle(height: 3),
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val.trim().isEmpty) {
                          return 'Please enter a password';
                        } else if (!passwordValidation
                            .hasMatch(passwordController.text)) {
                          return 'Password must contain at least 8 character upper case,lower cases,number and special character';
                        } else if (val.length < 8) {
                          return 'Password must be atLeast 8 characters';
                        }
                        return null;
                      });
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 30),
                child:
                    Consumer<RegisterProvider>(builder: (context, snapshot, _) {
                  return TextFormField(
                      // enabled: snapshot.isRegister ? false : true,
                      cursorColor: AppColor.darkGrey,
                      controller: confirmPasswordController,
                      focusNode: myFocusNodeConfirmPassword,
                      textInputAction: TextInputAction.done,
                      obscureText: snapshot.registerConfirmPswd ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              snapshot.checkConfirmPasswordVisibility();
                            },
                            icon: snapshot.registerConfirmPswd == false
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColor.darkMaroon,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: AppColor.darkMaroon
                            )
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColor.darkMaroon
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.darkGrey
                            )
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) return 'Please enter confirm password';
                        if (val != passwordController.text) {
                          return "Password didn't match";
                        }
                        return null;
                      });
                }),
              ),
              InkWell(
                onTap: () {
                  // final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
                  if(_formKey.currentState!.validate()){
                    Provider.of<RegisterProvider>(context, listen: false)
                        .createNewUser(
                        emailController.text,
                        passwordController.text,
                        // encrypter.encrypt(passwordController.text,iv: encrypt.IV.fromLength(16)).base64.toString(),
                        firstNameController.text,
                        lastNameController.text,
                        phoneController.text,
                        context
                    );
                  }else{
                    debugPrint("else formkey register screen");
                  }
                },
                child: Container(
                  height: 45,
                  width: 115,
                  decoration: BoxDecoration(
                    color: AppColor.darkMaroon,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFont.semiBold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(00, 00, 00, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already Have An Account? ",
              style: TextStyle(fontFamily: AppFont.regular),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text(
                "Login",
                style: TextStyle(
                fontFamily: AppFont.regular,
                color: AppColor.darkMaroon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
