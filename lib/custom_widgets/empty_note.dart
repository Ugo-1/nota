import 'package:flutter/material.dart';
import 'package:nota/utilities/size_manager.dart';

class EmptyNote extends StatelessWidget {
  const EmptyNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Column(
      children: [
        const Expanded(
          flex: 3,
          child: Image(
            image: AssetImage('assets/images/no_note.png'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "No note, write something interesting.",
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: SizeMg.text(24.0),
                ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
