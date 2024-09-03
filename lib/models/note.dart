import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  String? taskName;
  bool? isChecked;

  Note({
    this.isChecked = false,
  });
}
