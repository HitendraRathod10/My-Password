import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_pswd/Notes%20Screen/design/add_note_screen.dart';
import 'package:my_pswd/Notes%20Screen/design/show_update_note_screen.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import '../provider/show_update_note_provider.dart';

final _lightColors = [
  // Colors.amber.shade300,
  Colors.lightGreen.shade100,
  Colors.lightBlue.shade100,
  Colors.orange.shade100,
  Colors.red.shade100,
  Colors.tealAccent.shade100,
  // Colors.redAccent.shade200,
  // Colors.white
];

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
  final firebase = FirebaseFirestore.instance;

  loader(){
    EasyLoading.show(status: 'loading...');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("notes screen to showNote id ${widget.doc!.id}");
    // Provider.of<ShowUpdateNoteProvider>(context,listen: false).getData(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    // final color = _lightColors[index! % _lightColors.length];
    // final minHeight = getMinHeight(index!);
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkMaroon,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
      ),
      body: StreamBuilder(
        stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColor.darkMaroon,));
          if(snapshot.data!.size ==0) {
            EasyLoading.dismiss();
            return const Center(
              child: Text("No Data found",
                style: TextStyle(
                    fontFamily: AppFont.bold,
                    fontSize: 25
                ),
              ),
            );
          }
          if(snapshot.hasData){
            EasyLoading.dismiss();
            return
              Container(
                // padding: const EdgeInsets.only(bottom: 135),
                height: MediaQuery.of(context).size.height,
                // height: 200,
                child: GridView.custom(
                  // shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 02,
                    crossAxisSpacing: 02,
                    pattern: [
                      const WovenGridTile(1.9),
                      const WovenGridTile(
                        10 / 8,
                        crossAxisRatio: 0.9,
                        // alignment: AlignmentDirectional,
                      ),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              // color: AppColor.darkMaroon,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(3,3),
                                    blurStyle: BlurStyle.normal// changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: _lightColors[index % _lightColors.length],
                              child: Container(
                                // constraints: BoxConstraints(minHeight: minHeight),
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data!.docChanges[index].doc.get("note")}",
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            var x = snapshot.data!.docChanges[index];
                            var idForSend = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes").doc(x.doc.id);
                            print("idForSend ${idForSend}");
                            // var id = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data").doc(x.doc.id);
                            // print("only id ${id}");
                            // print("Go to ${firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Data").doc(x.doc.id)}");
                            // go to particular note for edit or view
                            // print("notes screen to showNote id ${widget.doc!.id}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowNoteScreen(
                              id: firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Notes").doc(x.doc.id.toString()),
                            )));
                          },
                        );
                      },
                      childCount: snapshot.data!.docChanges.length
                  ),
                  // semanticChildCount:10
                ),
              );
          }else{
            return loader();
          }
        },
      ),
    );
  }
}
