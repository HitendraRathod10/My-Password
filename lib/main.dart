import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_pswd/Home%20Screen/design/home_screen.dart';
import 'package:my_pswd/Login%20Screen/design/login_screen.dart';
import 'package:my_pswd/Login%20Screen/provider/login_provider.dart';
import 'package:my_pswd/Password%20Screen/provider/add_data_provider.dart';
import 'package:my_pswd/Register%20Screen/design/register_screen.dart';
import 'package:my_pswd/Register%20Screen/provider/register_provider.dart';
import 'package:my_pswd/Splash%20Screen/design/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => AddDataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: RegisterScreen(),
        // home: SplashScreen(),
        home: SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}


