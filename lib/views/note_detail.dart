import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nota/utilities/size_manager.dart';
import 'package:nota/model/nota_model.dart';
import 'package:nota/utilities/colors_constant.dart';

class NoteDetail extends StatefulWidget {
  final Nota? nota;

  const NoteDetail({Key? key, this.nota,}) : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final _formKey = GlobalKey<FormState>();

  late List<String> useColor;
  late Color bgColor;

  late Nota? note;
  late bool isFavorite;
  late String title;
  late String description;

  String lightColor = '0xFFF6F6F6';
  String darkColor = '0xFF6F6F6F';

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  void refreshNote() {
    if (widget.nota != null){
      note = widget.nota;
      isFavorite = note!.isFavorite;
      title = note!.title;
      description = note!.description;
      lightColor = note!.color!;
      darkColor = note!.darkColor!;
    }
    else {
      note = null;
      title = '';
      description = '';
      isFavorite = false;
    }
  }

  void colorSetter(){
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      if (widget.nota == null){
        bgColor = Color(int.parse(lightColor));
      } else {
        bgColor = Color(int.parse(lightColor));
      }
      useColor = kStringLightColorList;
    } else if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      if (widget.nota == null){
        bgColor = Color(int.parse(darkColor));
      } else {
        bgColor = Color(int.parse(darkColor));
      }
      useColor = kStringDarkColorList;
    }
  }


  @override
  Widget build(BuildContext context) {
    colorSetter();
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: WillPopScope(
        onWillPop: () async {
          _validator();
          return false;
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeMg.height(20.0),
                  left: SizeMg.width(7.0),
                  right: SizeMg.width(7.0),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _validator,
                      icon: const Icon(
                        FontAwesomeIcons.chevronLeft,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        (isFavorite) ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: _showBottomSheet,
                      icon: const Icon(
                        Icons.palette_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: SizeMg.height(20.0),
                      left: SizeMg.width(15.0),
                      right: SizeMg.width(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          initialValue: title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: SizeMg.text(25.0),
                                letterSpacing: 0.6,
                              ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                          ),
                          onChanged: (value){
                            setState(() {
                              title = value;
                            });
                          },
                          validator: (value){
                            if (value == null || value.isEmpty){
                              return 'Empty value';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              "Last Opened",
                              style:
                                  Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: SizeMg.text(16.0),
                                        letterSpacing: 0.4,
                                      ),
                            ),
                            SizedBox(
                              width: SizeMg.width(7.0),
                            ),
                            Text(
                              DateFormat('dd MMMM yyyy, hh:mm aa').format(
                                  note?.createdTime ?? DateTime.now()),
                              style:
                                  Theme.of(context).textTheme.headline3!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeMg.text(16.0),
                                        letterSpacing: 0.4,
                                      ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            expands: true,
                            autofocus: true,
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            initialValue: description,
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: SizeMg.text(18.0),
                                  letterSpacing: 0.6,
                                ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Note ...",
                            ),
                            onChanged: (value){
                              setState(() {
                                description = value;
                              });
                            },
                            validator: (value){
                              if (value == null || value.isEmpty){
                                return 'Empty value';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeMg.radius(10.0)),
          topRight: Radius.circular(SizeMg.radius(10.0)),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade300,
      builder: (context) {
        return SizedBox(
          height: SizeMg.height(100.0),
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: SizeMg.width(15.0),
              right: SizeMg.width(15.0),
            ),
            scrollDirection: Axis.horizontal,
            itemCount: useColor.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: SizeMg.width(13.0),
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(int.parse(useColor[index])),
                  ),
                ),
                onTap: (){
                  setState(() {
                    lightColor = kStringLightColorList[index];
                    darkColor = kStringDarkColorList[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _validator() async {
    if (_formKey.currentState?.validate() ?? false){

      if (note != null) {
        Map<String, dynamic> json = {
          'validate': 'true',
          'nota': note!.copy(
            isFavorite: isFavorite,
            color: lightColor,
            darkColor: darkColor,
            title: title,
            description: description,
            createdTime: DateTime.now(),
          ),
          'update': 'true',
        };
        pop(command: json);
      } else {
        Map<String, dynamic> json = {
          'validate': 'true',
          'nota': Nota(
            color: lightColor,
            darkColor: darkColor,
            isFavorite: isFavorite,
            title: title,
            description: description,
            createdTime: DateTime.now(),
          ),
          'update': 'false',
        };
        pop(command: json);
      }
    } else {
      Map<String, dynamic> json = {
        'validate': 'false',
        'nota': 'null',
        'update': 'false',
      };
      pop(command: json);
    }
  }

  void pop({required Map command}){
    Navigator.of(context).pop(command);
  }
}
