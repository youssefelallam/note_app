import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:note_app/constant/const_color.dart';
import 'package:note_app/module/note_module.dart';
import 'package:note_app/screens/edite_note.dart';
import 'package:url_launcher/url_launcher.dart';

class showNote extends StatelessWidget {
  final Note note;
  showNote({Key? key, required this.note}) : super(key: key);
  AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.NoteColors[note.color],
      appBar: AppBar(
        title: Text('Show Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => editeNote(note: note)));
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Divider(thickness: 3),
            SizedBox(height: 10),
            Linkify(
              text: note.note,
              options: LinkifyOptions(humanize: false),
              onOpen: _onopen,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onopen(LinkableElement link) async {
    launchUrl(Uri.parse(link.url), mode: LaunchMode.externalApplication);
  }
}
