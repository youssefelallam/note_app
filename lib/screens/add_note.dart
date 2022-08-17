import 'package:flutter/material.dart';
import 'package:note_app/module/note_module.dart';
import 'package:note_app/util/note_provider.dart';
import 'package:provider/provider.dart';

class addNote extends StatefulWidget {
  const addNote({Key? key}) : super(key: key);

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  TextEditingController c_title = TextEditingController();
  TextEditingController c_note = TextEditingController();
  int _value = 1;
  Color BGcolor = Color(0xFFF28B82);
  switchColor() {
    switch (_value) {
      case 1:
        BGcolor = Color(0xFFF28B82);
        break;
      case 2:
        BGcolor = Color(0xFFCAF18C);
        break;
      case 3:
        BGcolor = Color(0xFFFFF174);
        break;
      case 4:
        BGcolor = Color(0xFFA6F9EA);
        break;
      case 5:
        BGcolor = Color(0xFFD7ADF7);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGcolor,
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: Consumer<NoteData>(
        builder: (context, controller, child) {
          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: c_title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customRadio(1, Color(0xFFF28B82)),
                      SizedBox(width: 8),
                      customRadio(2, Color(0xFFCAF18C)),
                      SizedBox(width: 8),
                      customRadio(3, Color(0xFFFFF174)),
                      SizedBox(width: 8),
                      customRadio(4, Color(0xFFA6F9EA)),
                      SizedBox(width: 8),
                      customRadio(5, Color(0xFFD7ADF7)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: c_note,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Note',
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 8,
                    maxLines: 15,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(160, 40),
                    ),
                    onPressed: () async {
                      if ((c_title.text != '' && c_note.text == '') ||
                          (c_title.text == '' && c_note.text != '') ||
                          (c_title.text != '' && c_note.text != '')) {
                        var response = await controller.insertData('notes', {
                          'title': c_title.text,
                          'note': c_note.text,
                          'color': _value,
                        });
                        if (response > 0) {
                          c_title.clear();
                          c_note.clear();
                          Navigator.of(context).pop(true);
                        }
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customRadio(int value, Color color) {
    return InkWell(
      child: CircleAvatar(
        radius: 11.0,
        backgroundColor: _value == value ? Colors.black : Colors.transparent,
        child: CircleAvatar(
          radius: 9.0,
          backgroundColor: color,
        ),
      ),
      onTap: () {
        setState(() {
          _value = value;
          switchColor();
        });
      },
    );
  }
}
