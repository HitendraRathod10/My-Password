import 'package:flutter/material.dart';
import 'package:my_pswd/Docs%20Screen/design/docs_screen.dart';
import 'package:my_pswd/Notes%20Screen/design/notes_screen.dart';
import 'package:my_pswd/Password%20Screen/design/password_screen.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:my_pswd/utils/app_font.dart';
import 'package:my_pswd/utils/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Login Screen/design/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  check() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    prefg.setBool("key", true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => <Widget>[
    PasswordScreen(),
    NotesScreen(),
    DocsScreen()
    // const Icon(
    //   Icons.notes_rounded,
    //   size: 150,
    // ),
    // const Icon(
    //   Icons.picture_as_pdf,
    //   size: 150,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: AppColor.white,
          backgroundColor: AppColor.darkMaroon,
          title: const Text(
            "My Password",
          style: TextStyle(
            // color: AppColor.black,
            color: AppColor.white,
            fontFamily: AppFont.semiBold,
            fontSize: 25
          ),
          ),
          actions: [
            IconButton(onPressed: () async {
              SharedPreferences prefg = await SharedPreferences.getInstance();
              prefg.clear();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
                icon: const Icon(
                    Icons.power_settings_new,
                  color: AppColor.white,
                  size: 27,
                )
            )
            /*Padding(
              padding: const EdgeInsets.fromLTRB(00, 00, 08, 00),
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefg = await SharedPreferences.getInstance();
                  prefg.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                child: Container(
                  height: 35,
                    width: 35,
                    child: Image.asset(
                        AppImage.logOutLogo,
                      color: AppColor.white,
                    )
                ),
              ),
            )*/
          ],
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.darkMaroon,
          selectedLabelStyle: const TextStyle(
            fontFamily: AppFont.regular
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: AppFont.regular
          ),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'Password',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Docs',
            ),
          ],
        ),
      ),
    );
  }
}
