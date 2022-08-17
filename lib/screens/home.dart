import 'package:flutter/material.dart';
import 'package:note_app/module/note_module.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/show_note.dart';
import 'package:note_app/util/note_provider.dart';
import 'package:provider/provider.dart';

class noteHome extends StatefulWidget {
  const noteHome({Key? key}) : super(key: key);

  @override
  State<noteHome> createState() => _noteHomeState();
}

class _noteHomeState extends State<noteHome> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => addNote()));
            },
            icon: Icon(Icons.add_circle),
          )
        ],
      ),
      body: Consumer<NoteData>(
        builder: (context, controller, child) {
          return FutureBuilder(
            future: controller.readData('notes'),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Note note = Note.fromMap(snapshot.data[index]);
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showNote(
                                      note: note,
                                    ))),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(Icons.delete_forever),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            await controller.deleteData(
                                'notes', 'id = ${note.id}');
                            setState(() {});
                          },
                          child: Card(
                            elevation: 5,
                            color: switchColor(note.color),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 5),
                                  Flexible(
                                    child: Text(
                                      note.note,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          );
        },
      ),
    );
  }
}
