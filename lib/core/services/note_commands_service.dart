import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/db/nota_db.dart';
import 'package:nota/core/services/locator_services.dart';

class NoteCommandsService {
  final NotaDatabase _instance = locator<NotaDatabase>();

  Future updateNote(Nota note) async {
    await _instance.update(note);
  }

  Future createNote(Nota note) async {
    await _instance.create(note);
  }
}
