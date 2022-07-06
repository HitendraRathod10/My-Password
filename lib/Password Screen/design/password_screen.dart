import 'package:flutter/material.dart';
import 'package:my_pswd/Password%20Screen/design/add_data_screen.dart';
import 'package:my_pswd/utils/app_color.dart';

import '../../utils/app_font.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkMaroon,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDataScreen()));
          // alertDialogForInsertData();
        },
      ),
      body: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
        return Column(
          children:  [
            Card(
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: AppColor.darkMaroon,
                    child: Text("${index+1}",style: TextStyle(color: AppColor.white),),
                  ),
                  title:Text("List Item 1"),
                  trailing: const Icon(Icons.chevron_right),
                )
            ),
          ],
        );
      }),
    );
  }
}
