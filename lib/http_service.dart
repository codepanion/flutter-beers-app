import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/beer.dart';

class HttpService {
  static String baseUrl = 'https://api.punkapi.com/v2/';
  static String getBeersUrl = '$baseUrl/beers';

  Future<List<Beer>> fetchBeers() async {
    final response = await http.get(Uri.parse(getBeersUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Beer> beers = body
          .map(
            (item) => Beer.fromJson(item),
          )
          .toList();

      return beers;
    } else {
      throw Exception("Failed to load beers data");
    }
  }

  Future<Beer> fetchSingleBeer(int beerId) async {
    final response = await http.get(Uri.parse('$getBeersUrl/$beerId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Beer> beers = body.map((e) => Beer.fromJson(e)).toList();

      if (beers.length == 1) {
        return beers[0];
      } else {
        throw Exception("Something went wrong with beer details request.");
      }
    } else {
      throw Exception("Failed to load single beer detailed data.");
    }
  }
}
