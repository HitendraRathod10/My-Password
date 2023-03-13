import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_pswd/Docs%20Screen/design/show_doc_screen.dart';
import 'package:my_pswd/Docs%20Screen/provider/docs_provider.dart';
import 'package:my_pswd/utils/app_image.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class DocsScreen extends StatefulWidget {
  const DocsScreen({Key? key}) : super(key: key);

  @override
  DocsScreenState createState() => DocsScreenState();
}

class DocsScreenState extends State<DocsScreen> {

  final firebase = FirebaseFirestore.instance;

  loader(){
    EasyLoading.show(status: 'loading...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkMaroon,
        child: const Icon(Icons.add),
        onPressed: () async {
          Provider.of<DocsProvider>(context,listen: false).pickFiles(context);
        },
      ),
      body: StreamBuilder(
          stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Docs").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            // if (!snapshot.hasData) return loader();
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
            if(snapshot.hasData) {
              EasyLoading.dismiss();
              return
                ListView.builder(
                    itemCount: snapshot.data!.docChanges.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        //       ShowDataScreen(snapshot.data!.docChanges[index].doc)));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              ShowDocScreen(
                                name: snapshot.data!.docChanges[index].doc.get("name"),
                                doc: snapshot.data!.docChanges[index].doc.get("doc"),
                              )
                          ));
                        },
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                autoClose: true,
                                onPressed: (_){
                                  var x = snapshot.data!.docChanges[index];
                                  firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Docs").doc(x.doc.id).delete();
                                  setState(() {});
                                },
                                backgroundColor: AppColor.darkMaroon,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                // label: 'Delete',
                              ),
                            ],
                          ),
                          // actionPane: const SlidableDrawerActionPane(),
                          // actionExtentRatio: 0.25,
                          // secondaryActions: [
                          //   IconSlideAction(
                          //     caption: 'Delete',
                          //     color: Colors.red,
                          //     icon: Icons.delete,
                          //     onTap: () {
                          //       var x = snapshot.data!.docChanges[index];
                          //       firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("Docs").doc(x.doc.id).delete();
                          //       setState(() {});
                          //     },
                          //   ),
                          // ],
                          child: Column(
                            children: [
                              Card(
                                  // color: (index % 2 == 0) ? Colors.grey.shade400 : AppColor.white,
                                  color: AppColor.white,
                                  // color: (index % 2 == 0) ? AppColor.white : Colors.grey.shade300,
                                  child: ListTile(
                                    leading: snapshot.data!.docChanges[index].doc.get("doc").toString().contains("pdf") ?
                                    Image.asset(AppImage.pdfLogo,fit: BoxFit.fill,height: 45,width: 45,)
                                    // const Icon(Icons.description_outlined,color: AppColor.redMed,size: 55)
                                        :
                                    snapshot.data!.docChanges[index].doc.get("doc").toString().contains("png") ?
                                    Image.asset(AppImage.pngLogo,fit: BoxFit.fill,height: 45,width: 45,)
                                        :
                                    Image.asset(AppImage.jpgLogo,fit: BoxFit.fill,height: 45,width: 45,),
                                    title: Text(snapshot.data!.docChanges[index].doc.get("name").toString().replaceAll(".jpg", "").replaceAll(".png", "").replaceAll(".jpeg", "").replaceAll(".pdf", ""),overflow: TextOverflow.ellipsis),
                                    trailing: const Icon(Icons.chevron_right),
                                  )
                              ),
                            ],
                          ),
                        ),
                      );
                    });
            }
            else{
              return loader();
            }
          }
      ),
    );
  }
}
