import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/data/pokemons.dart';

class SearchBar extends StatelessWidget {
  final EdgeInsets margin;
  final Function refreshFunc;

  SearchBar({
    Key key,
    this.margin = const EdgeInsets.symmetric(horizontal: 28),
    this.refreshFunc,
  }) : super(key: key) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        searchText = "";
        searchResult = pokemons;
        refreshFunc();
      } else {
        searchText = _filter.text;
        refreshFunc();
      }
    });
  }

  final TextEditingController _filter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      margin: margin,
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search),
          SizedBox(width: 13),
          Expanded(
            child: TextFormField(
              controller: _filter,
              decoration: InputDecoration(
                hintText: "Search Pokemon, Move, Ability etc",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
