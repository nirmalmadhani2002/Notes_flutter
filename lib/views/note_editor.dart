import 'dart:math';
import 'package:notpad_flutter/views/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateTime.now().toString();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        title: Text("Add a new Note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title'
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8,),
            Text(date, style: AppStyle.dateTitle,),
            SizedBox(height: 28,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: mainController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Contnet'
              ),
              style: AppStyle.maincontent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notbook").add({
            "note_title": textEditingController.text,
            "creation_date": date,
            "note_content": mainController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print("Failed to add new Note due to  $error"));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.save),
      ),
    );
  }
}



