import 'package:flutter/material.dart';
import 'package:my_pswd/Notes%20Screen/provider/add_note_provider.dart';
import 'package:provider/provider.dart';

import '../../Password Screen/provider/show_data_provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  var noteController = TextEditingController();
  FocusNode noteFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey.shade300,
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
                "Add note",
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.done,
                  color: AppColor.black,
                ),
                onPressed: () {
                  if(noteController.text.isEmpty || noteController.text == "" || noteController.text.trim() == ""){
                    print("This is wrong");
                  }else{
                    Provider.of<AddNoteProvider>(context,listen: false).addNote(noteController.text, context);
                  }
                  // Navigator.pop(context);
                  // Get.back();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                child: Container(
                  color: AppColor.white,
                  height: MediaQuery.of(context).size.height/1.24,
                  child: Scrollbar(
                    child: TextFormField(
                      controller: noteController,
                      maxLines: null,
                      // expands: true,
                      minLines: null,
                      decoration: const InputDecoration(
                        hintText: "Type note here",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(00, 00, 00, 02)
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
