import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nota/custom_widgets/empty_note.dart';
import 'package:nota/custom_widgets/note_item.dart';
import 'package:nota/model/nota_model.dart';
import 'package:nota/db/nota_db.dart';
import 'package:nota/utilities/size_manager.dart';
import 'package:nota/utilities/update_add_note.dart';
import 'note_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searchBar = false;
  NotaDatabase instance = NotaDatabase.instance;
  List<Nota> notaList = [];
  List<Nota> noteList = [];

  late bool darkTheme;

  @override
  void initState() {
    readAllNotes();
    super.initState();
  }

  Future readAllNotes() async {
    try {
      final list = await instance.readAll();
      setState(() {
        noteList = list;
        notaList = list;
      });
    } catch (e) {
      setState(() {
        noteList = [];
        notaList = [];
      });
    }
  }

  void colorSetter() {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      darkTheme = false;
    } else if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      darkTheme = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    colorSetter();
    SizeMg.init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.penClip,
        ),
        onPressed: () async {
           final Map result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteDetail()));
           if (result['validate'] == 'true'){
             await NoteCommands.createNote(result['nota']);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nota",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: SizeMg.text(40.0),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeMg.height(10.0)),
                    child: !searchBar
                        ? IconButton(
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                            onPressed: () {
                              setState(() {
                                searchBar = !searchBar;
                              });
                            },
                          )
                        : SizedBox(
                            width: SizeMg.width(200.0),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeMg.height(10.0),
                                  horizontal: SizeMg.width(10.0),
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(SizeMg.radius(10.0),),),
                                ),
                                focusedBorder: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  focusColor: Colors.black,
                                  icon: const Icon(FontAwesomeIcons.xmark),
                                  onPressed: () {
                                    setState(() {
                                      searchBar = !searchBar;
                                      readAllNotes();
                                    });
                                  },
                                ),
                                hintText: 'Search note',
                              ),
                              onChanged: (String search) {
                                setState(() {
                                  final value = search.toLowerCase();
                                  if (value.isEmpty) {
                                    readAllNotes();
                                  }
                                  notaList = noteList
                                      .where((element) =>
                                          element.description
                                              .toLowerCase()
                                              .contains(value) ||
                                          element.title
                                              .toLowerCase()
                                              .contains(value))
                                      .toList();
                                });
                              },
                            ),
                          ),
                  ),
                ],
              ),
              notaList.isEmpty
                  ? const Expanded(child: EmptyNote())
                  : Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(
                          top: SizeMg.height(40.0),
                        ),
                        itemCount: notaList.length,
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
                                instance.delete(notaList[index]);
                                notaList.removeAt(index);
                              });
                            },
                            child: NoteItem(
                              nota: notaList[index],
                              isDark: darkTheme,
                              onTap: () async {
                                final Map result = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => NoteDetail(nota: notaList[index],)));
                                await NoteCommands.updateNote(result['nota']);
                                readAllNotes();
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void snackBar(){
    NoteCommands.showBar(context, darkTheme);
  }
}
