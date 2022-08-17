import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:note_app/module/note_module.dart';
import 'package:note_app/screens/edite_note.dart';
import 'package:note_app/util/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class showNote extends StatelessWidget {
  final Note note;
  const showNote({Key? key, required this.note}) : super(key: key);
  switchColor(int value) {
    switch (value) {
      case 1:
        return Color(0xFFF28B82);
      case 2:
        return Color(0xFFCAF18C);
      case 3:
        return Color(0xFFFFF174);
      case 4:
        return Color(0xFFA6F9EA);
      case 5:
        return Color(0xFFD7ADF7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: switchColor(note.color),
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
