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
  // String emaiId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emaiId = widget.id.toString().substring(widget.id.toString().length - 21);
    // emaiId = emaiId.replaceAll(")", "");
    Provider.of<ShowUpdateNoteProvider>(context,listen: false).getData(widget.id);
  }
  final firebase = FirebaseFirestore.instance;
  FocusNode appNameFocusNode = FocusNode();

  willPop(context) {
    var snapshotData = Provider.of<ShowUpdateNoteProvider>(context,listen: false);
    snapshotData.noteController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: AppColor.darkMaroon,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            leading: Consumer<ShowUpdateNoteProvider>(
              builder: (context, snapshot, _) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColor.white,
                    ),
                    onPressed: () {
                      snapshot.noteController.clear();
                      Provider.of<ShowDataProvider>(context,listen: false).isObscurePassword = false;
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            ),
            centerTitle: false,
            title: Column(
              children: const [
                Text(
                  "Note",
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
                    Icons.delete_forever_rounded,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes").doc(widget.id).delete();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                    var snapshotData = Provider.of<ShowUpdateNoteProvider>(context,listen: false);
                    snapshotData.noteController.clear();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(
                    Icons.done,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    var snapshotData = Provider.of<ShowUpdateNoteProvider>(context,listen: false);
                    // Provider.of<AddNoteProvider>(context,listen: false).addNote(noteController.text, context);
                    if(snapshotData.noteController.text.isEmpty || snapshotData.noteController.text == "" || snapshotData.noteController.text.trim() == ""){
                      print("This is wrong");
                    }else{
                      Provider.of<ShowUpdateNoteProvider>(context,listen: false).updateData(snapshotData.noteController.text, widget.id, context);
                    }
                    snapshotData.noteController.clear();
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
        ),
      ),
    );
  }
}
