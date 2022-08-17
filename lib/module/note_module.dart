class Note {
  int? _id;
  late String _title;
  late String _note;
  late int _color;

  Note(dynamic obj) {
    _id = obj['id'];
    _title = obj['title'];
    _note = obj['note'];
    _color = obj['color'];
  }
  Note.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _title = data['title'];
    _note = data['note'];
    _color = data['color'];
  }

  Map<String, dynamic> toMap() =>
      {'id': _id, 'title': _title, 'note': _note, 'color': _color};

  int? get id => _id;
  String get title => _title;
  String get note => _note;
  int get color => _color;
}
