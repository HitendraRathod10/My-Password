import 'package:flutter/material.dart';
import 'package:my_pswd/Notes%20Screen/design/add_note_screen.dart';
import '../../utils/app_color.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkMaroon,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNoteScreen()));
        },
      ),
    );
  }
}
