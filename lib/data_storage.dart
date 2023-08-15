import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'models/beer.dart';

class DataStorage extends ChangeNotifier {
  String _searchedTerm = '';
  List<Beer> _favoriteBeers = [];

  String get searchedTerm => _searchedTerm;
  List<Beer> get favoriteBeers => UnmodifiableListView(_favoriteBeers);

  void setSearchedTerm(String newTerm) {
    _searchedTerm = newTerm;
    notifyListeners();
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/favorites.json');
  }

  Future<void> fetchFavoriteBeers() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        await file.create();
      } else {
        String fileContent = await file.readAsString();
        List<dynamic> jsonFileContent = json.decode(fileContent);
        List<Beer> beers = jsonFileContent
            .map(
              (dynamic item) => Beer.fromJson(item),
            )
            .toList();

        _favoriteBeers = beers;
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addBeerToFavorites(Beer newFavoriteBeer) async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        await file.create();
      }

      _favoriteBeers.add(newFavoriteBeer);
      notifyListeners();
      await file.writeAsString(json.encode(_favoriteBeers).toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeBeerFromFavorites(int beerId) async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        await file.create();
      }

      List<Beer> newList =
          _favoriteBeers.where((beer) => beer.id != beerId).toList();

      _favoriteBeers = newList;

      notifyListeners();
      await file.writeAsString(json.encode(_favoriteBeers).toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}
