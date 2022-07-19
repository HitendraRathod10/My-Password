import 'package:flutter/material.dart';
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
              onPressed: () {},
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
              color: Colors.redAccent,
              child: Image.network('${widget.doc}',
                  fit: BoxFit.fill
              ),
            ),
          )
        ],
      ) : widget.doc!.contains(".pdf") ?
          Center(
            child: SfPdfViewer.network(
              '${widget.doc}',
            ),
          ) :
      Column(
        children: [
          Text("data")
        ],
      )
    );
  }
}
