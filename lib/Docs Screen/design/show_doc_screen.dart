import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_pswd/Docs%20Screen/provider/docs_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/app_color.dart';

//ignore: must_be_immutable
class ShowDocScreen extends StatefulWidget {
  String? doc,name;
  ShowDocScreen({Key? key, this.doc,this.name}) : super(key: key);

  @override
  ShowDocScreenState createState() => ShowDocScreenState();
}

class ShowDocScreenState extends State<ShowDocScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.name);
    debugPrint("show_doc_screen init ${widget.doc}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Document"),
          backgroundColor: AppColor.darkMaroon,
          actions: [
            IconButton(
                onPressed: (){
                  Provider.of<DocsProvider>(context,listen: false).downloadFile(widget.doc,widget.name);
                },
                icon: const Icon(
                    Icons.file_download,
                    size: 35
                )
            ),
            IconButton(
                onPressed: () async {
                  final imageurl = '${widget.doc}';
                  final uri = Uri.parse(imageurl);
                  final response = await http.get(uri);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final String path = '${temp.path}/${widget.name}';
                  File(path).writeAsBytesSync(bytes);
                  await Share.shareXFiles([XFile(path)]);
                  // await Share.shareFiles([path]);
                },
                icon: const Icon(
                  Icons.share,
                  color: AppColor.white,
                  size: 27,
                )
            ),
          ],
        ),
        body: widget.doc!.contains(".jpg") || widget.doc!.contains(".png") || widget.doc!.contains(".jpeg") ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 400,
                width: 400,
                // color: Colors.redAccent,
                child: Image.network('${widget.doc}',
                    fit: BoxFit.fill
                ),
              ),
            )
          ],
        ) :
        widget.doc!.contains(".pdf") ?
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SfPdfViewer.network(
                '${widget.doc}',
              ),
            ) :
        Column(
          children: const [
            Text("Something went wrong! Please try again later")
          ],
        )
      ),
    );
  }
}
