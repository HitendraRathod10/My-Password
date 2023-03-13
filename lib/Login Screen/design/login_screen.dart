import 'package:flutter/material.dart';
import 'package:my_pswd/Login%20Screen/provider/login_provider.dart';
import 'package:my_pswd/Register%20Screen/design/register_screen.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                height: 150,
              ),
              const Text(
                "Login",
                style: TextStyle(
                    color: AppColor.darkMaroon,
                    fontSize: 24,
                    fontFamily: AppFont.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 00),
                child: TextFormField(
                  cursorColor:  AppColor.darkMaroon,
                  controller: emailController,
                  focusNode: myFocusNodeEmail,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColor.darkMaroon
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            // color: AppColor.darkMaroon
                            )),
                    labelText: 'Email ID',
                    labelStyle: TextStyle(
                        color: AppColor.greyDivider,
                        fontFamily: AppFont.regular
                    ),
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
              Consumer<LoginProvider>(
                builder: (context, snapshot,_) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 00),
                    child: TextFormField(
                      cursorColor: AppColor.darkMaroon,
                      controller: passwordController,
                      focusNode: myFocusNodePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: snapshot.loginPswd ? false : true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              snapshot.checkPasswordVisibility();
                            },
                            icon: snapshot.loginPswd == false
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: AppColor.darkMaroon,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: AppColor.darkMaroon
                                  )),
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColor.darkMaroon
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                // color: AppColor.darkMaroon
                                )),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  );
                }
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: (){
                  // final iv = encrypt.IV.fromLength(16);
                  // final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
                  // encrypter.decrypt(encrypter.encrypt(passwordController.text, iv: iv), iv: iv)
                  if(_formKey.currentState!.validate()){
                    Provider.of<LoginProvider>(context,listen: false).
                    loginWithEmail(emailController.text, passwordController.text,context);
                    // Provider.of<LoginProvider>(context,listen: false).checkPasswordVisibility();
                  }else{
                    debugPrint('else formkey loginscreen');
                  }
                },
                child: Container(
                  height: 45,
                  width: 95,
                  decoration: BoxDecoration(
                    color: AppColor.darkMaroon,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:  const Center(
                    child: Text("Login",
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don' "'" 't Have An Account Yet? ',
              style: TextStyle(
                  fontFamily: AppFont.regular
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
              },
              child: const Text('Signup',
                style: TextStyle(
                    fontFamily: AppFont.regular,
                    color: AppColor.darkMaroon
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
