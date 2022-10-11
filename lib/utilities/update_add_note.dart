import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nota/model/nota_model.dart';
import 'package:nota/db/nota_db.dart';
import 'package:nota/utilities/size_manager.dart';

class NoteCommands {

  static Future updateNote(Nota note) async {
    await NotaDatabase.instance.update(note);
  }

  static Future createNote(Nota note) async {
    await NotaDatabase.instance.create(note);
  }

  static showBar(context, darkTheme) {
    SizeMg.init(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        'Empty note discarded.',
        style: GoogleFonts.nunitoSans(
          fontSize: SizeMg.text(17.0),
          letterSpacing: 0.3,
          color: (darkTheme) ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: (darkTheme) ? Colors.white : Colors.black,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeMg.radius(7.0)),
          topRight: Radius.circular(SizeMg.radius(7.0)),
        ),
      ),
    ));
  }
}
