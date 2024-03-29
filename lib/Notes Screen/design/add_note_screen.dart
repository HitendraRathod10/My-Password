import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_pswd/Notes%20Screen/provider/add_note_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {

  TextEditingController noteController = TextEditingController();
  FocusNode noteFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.white,
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
                    color: AppColor.white,
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
                  color: AppColor.white,
                ),
                onPressed: () {
                  if(noteController.text.isEmpty || noteController.text == "" || noteController.text.trim() == ""){
                    debugPrint("This is wrong");
                  }else{
                    Provider.of<AddNoteProvider>(context,listen: false).addNote(noteController.text, context);
                  }
                  // Navigator.pop(context);
                  // Get.back();
                },
              ),
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
