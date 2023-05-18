import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/utilities/app_colors.dart';
import 'package:nota/core/utilities/extension_int.dart';
import 'package:nota/core/utilities/fonts.dart';
import 'package:nota/core/utilities/size_manager.dart';

class NoteItem extends StatelessWidget {

  final Nota nota;
  final bool isDark;
  final Function() onTap;

  const NoteItem({Key? key, required this.nota, required this.isDark, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: nota.colorIndex.getNoteColor(appColors),
          borderRadius: BorderRadius.all(
              Radius.circular(SizeMg.radius(8.0)),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: SizeMg.height(20.0),
          horizontal: SizeMg.width(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMM').format(nota.createdTime).toUpperCase(),
                  style: TextStyle(
                    fontFamily: Fonts.playfairDisplay,
                    fontSize: SizeMg.text(16.0),
                    fontWeight: FontWeight.w600,
                    color: isDark? const Color(0xFFC9C9C9) : const Color(0xFF8C8C8C),
                  ),
                ),
                Icon(
                  (nota.isFavorite) ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                  size: 16.0,
                ),
              ],
            ),
            SizedBox(
              height: SizeMg.height(13.0),
            ),
            Text(
              nota.title,
              style: TextStyle(
                fontFamily: Fonts.roboto,
                fontSize: SizeMg.text(20.0),
                fontWeight: FontWeight.w700,
                color: isDark? const Color(0xFFFFFFFF) : const Color(0xFF1C2121),
              ),
            ),
            SizedBox(
              height: SizeMg.height(10.0),
            ),
            Flexible(
              flex: 1,
              child: Text(
                nota.description,
                style: TextStyle(
                  fontFamily: Fonts.nunitoSans,
                  fontSize: SizeMg.text(15.0),
                  fontWeight: FontWeight.w400,
                  color: isDark? const Color(0xFFFFFFFF) : const Color(0xFF1C2121),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
