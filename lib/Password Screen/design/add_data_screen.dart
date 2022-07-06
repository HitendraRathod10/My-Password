import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
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
      body: Column(
        children: [
          Row(
            children: [
              Text("App Name"),
              Text(":"),
              Container(
                width: 150,
                height: 40,
                child: TextFormField(

                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
