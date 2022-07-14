import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pswd/Notes%20Screen/provider/show_update_note_provider.dart';
import 'package:provider/provider.dart';

import '../../Home Screen/design/home_screen.dart';
import '../../Password Screen/provider/show_data_provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class ShowNoteScreen extends StatefulWidget {
  var id;
  ShowNoteScreen({required this.id});

  @override
  _ShowNoteScreenState createState() => _ShowNoteScreenState();
}

class _ShowNoteScreenState extends State<ShowNoteScreen> {
  String lastId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastId = widget.id.toString().replaceAll("DocumentReference<Map<String, dynamic>>(User/dheba@gmail.com/Notes/", "").replaceAll(")", "");
    print("lastID ${lastId}");
    Provider.of<ShowUpdateNoteProvider>(context,listen: false).getData(lastId);
  }
  final firebase = FirebaseFirestore.instance;
  FocusNode appNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: false,
        title: Column(
          children: const [
            Text(
              "Your note",
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
                Icons.delete_forever_rounded,
                color: AppColor.black,
              ),
              onPressed: () {
                firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes").doc(lastId).delete();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.done,
                color: AppColor.black,
              ),
              onPressed: () {
                var snapshotData = Provider.of<ShowUpdateNoteProvider>(context,listen: false);
                // Provider.of<AddNoteProvider>(context,listen: false).addNote(noteController.text, context);
                Provider.of<ShowUpdateNoteProvider>(context,listen: false).updateData(snapshotData.noteController.text, lastId, context);
                // Navigator.pop(context);
                // Get.back();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<ShowUpdateNoteProvider>(
          builder: (context, snapshot,_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                  child: Container(
                    color: AppColor.white,
                    height: MediaQuery.of(context).size.height/1.24,
                    child: Scrollbar(
                      child: TextFormField(
                        controller: snapshot.noteController,
                        focusNode: appNameFocusNode,
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
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
