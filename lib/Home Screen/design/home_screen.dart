import 'package:flutter/material.dart';
import 'package:my_pswd/Docs%20Screen/design/docs_screen.dart';
import 'package:my_pswd/Notes%20Screen/design/notes_screen.dart';
import 'package:my_pswd/Password%20Screen/design/password_screen.dart';
import 'package:my_pswd/utils/app_color.dart';
import 'package:my_pswd/utils/app_font.dart';
import 'package:my_pswd/utils/app_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Login Screen/design/login_screen.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  check() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    prefg.setBool("key", true);
    // print("helo");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: AppColor.white,
          backgroundColor: AppColor.darkMaroon,
          title:
           Consumer<HomeProvider>(
             builder: (context, snapshot,_) {
               return
               Text(
                snapshot.selectedIndex == 0 ? "My Passwords" : snapshot.selectedIndex == 1 ? "My Notes" : "My Documents",
                style: const TextStyle(
                // color: AppColor.black,
                color: AppColor.white,
                fontFamily: AppFont.semiBold,
                fontSize: 25
          ),
          );
             }
           ),
          actions: [
            IconButton(onPressed: () async {
              SharedPreferences prefg = await SharedPreferences.getInstance();
              prefg.clear();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
              Provider.of<HomeProvider>(context,listen: false).onItemTapped(0);
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
        body: Consumer<HomeProvider>(
          builder: (context, snapshot,_) {
            return snapshot.pages[snapshot.selectedIndex];
          },
        ),
        // Center(
        //       child: Provider.of<HomeProvider>(context,listen: false).pages.elementAt(Provider.of<HomeProvider>(context,listen: false).selectedIndex),
        //     ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, snapshot,_) {
            return BottomNavigationBar(
              backgroundColor: AppColor.white,
              selectedItemColor: AppColor.darkMaroon,
              selectedLabelStyle: const TextStyle(
                fontFamily: AppFont.regular
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: AppFont.regular
              ),
              currentIndex: snapshot.selectedIndex,
              onTap: snapshot.onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.storage),
                  label: 'Passwords',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notes),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'Documents',
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
