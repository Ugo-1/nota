import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nota/core/db/nota_db.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/model/note_detail_model.dart';
import 'package:nota/core/services/locator_services.dart';
import 'package:nota/core/services/navigation_service.dart';
import 'package:nota/core/utilities/fonts.dart';
import 'package:nota/core/utilities/size_manager.dart';
import 'package:nota/core/services/note_commands_service.dart';
import 'package:nota/features/all_notes/widgets/empty_note.dart';
import 'package:nota/features/all_notes/widgets/note_item.dart';
import 'package:nota/features/all_notes/utils/value_notifier_list.dart';
import 'package:nota/features/all_notes/widgets/home_search_bar.dart';

class AllNotesView extends StatefulWidget {
  const AllNotesView({Key? key}) : super(key: key);

  @override
  State<AllNotesView> createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  ///Instance of the database
  NotaDatabase instance = NotaDatabase.instance;

  ///The note list
  final ValueNotifierList<Nota> _notaList = ValueNotifierList([]);

  ///The navigation service
  final NavigationService _navigationService = locator<NavigationService>();

  ///The note command service
  final NoteCommandsService _noteCommandsService = locator<NoteCommandsService>();

  @override
  void initState() {
    super.initState();
    readAllNotes();
  }

  ///To read all the notes in the database
  void readAllNotes() {
    _notaList.addAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.penClip,
        ),
        onPressed: () async {
          final NoteDetailValidateModel result =
              await _navigationService.navigateToNoteDetailsScreen();
          if (result.validate == true){
             await _noteCommandsService.createNote(result.nota!);
             readAllNotes();
           } else {
             snackBar();
           }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeMg.width(15.0),
            vertical: SizeMg.height(15.0),
          ),
          child: Column(
            children: [
              //Nota header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nota",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: SizeMg.text(40.0),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeMg.height(10.0),),
                    child: HomeSearchBar(noteListListener: _notaList,),
                  ),
                ],
              ),
              //Empty notes or note list
              ValueListenableBuilder(
                valueListenable: _notaList,
                builder: (_, notaList, __){
                  if (_notaList.value.isEmpty){
                    return const Expanded(
                      child: EmptyNote(),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        top: SizeMg.height(40.0),
                      ),
                      itemCount: _notaList.value.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 17.0,
                        crossAxisSpacing: 22.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              instance.delete(_notaList.value[index]);
                              _notaList.value.removeAt(index);
                            });
                          },
                          child: NoteItem(
                            nota: _notaList.value[index],
                            isDark: false,
                            onTap: () async {
                              final NoteDetailValidateModel result =
                              await _navigationService.navigateToNoteDetailsScreen(
                                nota: _notaList.value[index],
                              );
                              await _noteCommandsService.updateNote(result.nota!);
                              readAllNotes();
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Displays a snack bar to discard the note
  void snackBar(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        'Empty note discarded.',
        style: TextStyle(
          fontFamily: Fonts.nunitoSans,
          fontSize: SizeMg.text(17.0),
          letterSpacing: 0.3,
        ),
      ),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeMg.radius(7.0)),
          topRight: Radius.circular(SizeMg.radius(7.0)),
        ),
      ),
    ),
    );
  }
}
