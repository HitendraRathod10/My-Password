import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/app_color.dart';

class ShowDocScreen extends StatefulWidget {
  String? doc,name;
  ShowDocScreen({this.doc,this.name});

  @override
  _ShowDocScreenState createState() => _ShowDocScreenState();
}

class _ShowDocScreenState extends State<ShowDocScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
    print(widget.doc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doc"),
        actions: [
          IconButton(
              onPressed: () async {
                final imageurl = '${widget.doc}';
                final uri = Uri.parse(imageurl);
                final response = await http.get(uri);
                final bytes = response.bodyBytes;
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/${widget.name}';
                File(path).writeAsBytesSync(bytes);
                await Share.shareFiles([path]);
              },
              icon: const Icon(
                Icons.share,
                color: AppColor.white,
                size: 27,
              )
          )
        ],
      ),
      body: widget.doc!.contains(".jpg") || widget.doc!.contains(".png") || widget.doc!.contains(".jpeg") ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
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
          Text("data")
        ],
      )
    );
  }
}
