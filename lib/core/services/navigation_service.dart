import 'package:flutter/material.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/utilities/app_router.dart';

///The global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  ///To navigate to the note details screen
  Future<dynamic> navigateToNoteDetailsScreen({Nota? nota}) {
    return navigatorKey.currentState!.pushNamed(
      AppRoute.noteDetail,
      arguments: nota,
    );
  }
}