import 'package:flutter/material.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/features/all_notes/all_notes_view.dart';
import 'package:nota/features/note_details/note_detail.dart';

class AppRoute {
  static const String allNotes = '/';
  static const String noteDetail = '/NoteDetail';

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allNotes:
        return toRoute(
          const AllNotesView(),
        );
      case noteDetail:
        final args = settings.arguments as Nota?;
        return toRoute(
          NoteDetail(
            nota: args,
          ),
        );
      default:
        return toRoute(
          const AllNotesView(),
        );
    }
  }

  PageRouteBuilder toRoute(Widget route) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return route;
      },
    );
  }
}
