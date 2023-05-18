import 'package:nota/core/model/nota_model.dart';

class NoteDetailValidateModel {
  ///if validation is true
  final bool validate;

  //The note if there's any
  final Nota? nota;

  ///If its an update
  final bool update;

  const NoteDetailValidateModel({
    required this.validate,
    required this.nota,
    required this.update,
  });
}
