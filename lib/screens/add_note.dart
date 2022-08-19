import 'package:flutter/material.dart';
import 'package:note_app/constant/const_color.dart';
import 'package:note_app/util/note_provider.dart';
import 'package:provider/provider.dart';

class addNote extends StatefulWidget {
  const addNote({Key? key}) : super(key: key);

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  String _value = 'red';
  TextEditingController c_title = TextEditingController();
  TextEditingController c_note = TextEditingController();
  AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: appColor.NoteColors[_value],
          appBar: AppBar(
            title: Text('Add Note'),
            centerTitle: true,
          ),
          body: Padding(
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
                      customRadio('red', Color(0xFFF28B82)),
                      SizedBox(width: 8),
                      customRadio('green', Color(0xFFCAF18C)),
                      SizedBox(width: 8),
                      customRadio('yellow', Color(0xFFFFF174)),
                      SizedBox(width: 8),
                      customRadio('blue', Color(0xFFA6F9EA)),
                      SizedBox(width: 8),
                      customRadio('purple', Color(0xFFD7ADF7)),
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
          ),
        );
      },
    );
  }

  Widget customRadio(String value, Color color) {
    var controller = Provider.of<NoteData>(context, listen: false);
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
        controller.changeNoteColor(value);
        _value = value;
      },
    );
  }
}
