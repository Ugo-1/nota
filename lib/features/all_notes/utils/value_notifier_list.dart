import 'package:flutter/material.dart';
import 'package:nota/core/db/nota_db.dart';
import 'package:nota/core/services/locator_services.dart';

class ValueNotifierList<T> extends ValueNotifier<List<T>> {
  ValueNotifierList(List<T> value) : super(value);

  final NotaDatabase _instance = locator<NotaDatabase>();

  Future addAllNotes() async {
    final list = await _instance.readAll() as List<T>; // Cast the list to List<T>
    value = list;
  }
}
