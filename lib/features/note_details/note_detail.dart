import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/model/note_detail_model.dart';
import 'package:nota/core/utilities/app_colors.dart';
import 'package:nota/core/utilities/extension_int.dart';
import 'package:nota/core/utilities/size_manager.dart';

class NoteDetail extends StatefulWidget {
  ///The note if any
  final Nota? nota;

  const NoteDetail({Key? key, this.nota,}) : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final _formKey = GlobalKey<FormState>();

  ///The note
  late Nota? note;
  ///If the note is a favorite
  late bool isFavorite;
  ///The title of the note
  late String title;
  ///The description or details about the note
  late String description;
  ///The color of the note
  late int? noteColor;

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
      noteColor = note!.colorIndex;
    }
    else {
      note = null;
      title = '';
      description = '';
      isFavorite = false;
      noteColor = null;
    }
  }


  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: noteColor.getNoteColor(appColors),
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
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                  Theme.of(context).textTheme.displaySmall!.copyWith(
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
        final AppColors appColors = Theme.of(context).extension<AppColors>()!;
        return SizedBox(
          height: SizeMg.height(100.0),
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: SizeMg.width(15.0),
              right: SizeMg.width(15.0),
            ),
            scrollDirection: Axis.horizontal,
            itemCount: noteColorsLength,
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
                    backgroundColor: index.getNoteColor(appColors),
                  ),
                ),
                onTap: (){
                  setState(() {
                    noteColor = index;
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
        NoteDetailValidateModel model = NoteDetailValidateModel(
          validate: true,
          nota: note!.copy(
            isFavorite: isFavorite,
            colorIndex: noteColor,
            title: title,
            description: description,
            createdTime: DateTime.now(),
          ),
          update: true,
        );
        pop(command: model,);
      } else {
        NoteDetailValidateModel model = NoteDetailValidateModel(
          validate: true,
          nota: Nota(
            colorIndex: noteColor,
            isFavorite: isFavorite,
            title: title,
            description: description,
            createdTime: DateTime.now(),
          ),
          update: false,
        );
        pop(command: model,);
      }
    } else {
      NoteDetailValidateModel model = const NoteDetailValidateModel(
        validate: false,
        nota: null,
        update: false,
      );
      pop(command: model,);
    }
  }

  void pop({required NoteDetailValidateModel command}){
    Navigator.of(context).pop(command);
  }
}
