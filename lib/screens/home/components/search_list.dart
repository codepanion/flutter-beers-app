import 'package:beer_app/screens/home/components/beers_list.dart';
import 'package:beer_app/screens/home/components/search_input.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SearchInput(),
        BeersList(),
      ],
    );
  }
}
