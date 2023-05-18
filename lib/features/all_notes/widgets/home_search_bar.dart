import 'package:flutter/material.dart';
import 'package:nota/core/model/nota_model.dart';
import 'package:nota/core/utilities/size_manager.dart';
import 'package:nota/features/all_notes/utils/value_notifier_list.dart';

class HomeSearchBar extends StatefulWidget {
  final ValueNotifierList<Nota> noteListListener;

  const HomeSearchBar({
    Key? key,
    required this.noteListListener,
  }) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  ///If the search bar is visible
  bool searchBar = false;

  ///To open or close the search bar
  void updateSearchBar() {
    setState(() {
      searchBar = !searchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: !searchBar
          ? IconButton(
              icon: const Icon(
                Icons.search_rounded,
              ),
              onPressed: updateSearchBar,
            )
          : _SearchBar(
              noteListListener: widget.noteListListener,
              closeSearch: updateSearchBar,
            ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final ValueNotifierList<Nota> noteListListener;
  final VoidCallback closeSearch;

  const _SearchBar({
    Key? key,
    required this.noteListListener,
    required this.closeSearch,
  }) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  ///The text controller
  late TextEditingController _searchTextController;

  ///The note list
  ValueNotifierList<Nota> get _noteList => widget.noteListListener;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      if (_searchTextController.text.isEmpty) {
        //Add all the notes
        _noteList.addAllNotes();
      } else {
        final String searchText = _searchTextController.text.toLowerCase();
        //Filter based on the note description or title
        _noteList.value = _noteList.value
            .where((element) =>
                element.description.toLowerCase().contains(searchText) ||
                element.title.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeMg.width(200.0),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeMg.height(10.0),
            horizontal: SizeMg.width(10.0),
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeMg.radius(10.0),
              ),
            ),
          ),
          focusedBorder: const OutlineInputBorder(),
          suffixIcon: IconButton(
            color: Colors.black,
            focusColor: Colors.black,
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              widget.closeSearch();
              _searchTextController.clear();
              _noteList.addAllNotes();
            },
          ),
          hintText: 'Search note',
        ),
      ),
    );
  }
}
