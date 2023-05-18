import 'package:get_it/get_it.dart';
import 'package:nota/core/db/nota_db.dart';
import 'package:nota/core/services/navigation_service.dart';
import 'package:nota/core/services/note_commands_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  ///The database instance
  locator.registerLazySingleton(
    () => NotaDatabase.instance,
  );

  ///The note commands service instance
  locator.registerLazySingleton(
        () => NoteCommandsService(),
  );

  ///The navigation service instance
  locator.registerLazySingleton(
    () => NavigationService(),
  );
}
