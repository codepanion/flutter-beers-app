import 'package:beer_app/data_storage.dart';
import 'package:beer_app/http_service.dart';
import 'package:beer_app/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/beer.dart';

class BeersList extends StatefulWidget {
  const BeersList({super.key});

  @override
  State<BeersList> createState() => _BeersListState();
}

class _BeersListState extends State<BeersList> {
  final HttpService _httpService = HttpService();
  late Future<List<Beer>> _beers;

  @override
  void initState() {
    super.initState();
    _beers = _httpService.fetchBeers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - 275,
      child: FutureBuilder(
        future: _beers,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Consumer<DataStorage>(builder: (
              consumerCtx,
              dataStorage,
              child,
            ) {
              List<Beer> beersData = snapshot.data;
              List<Beer> filteredBeersData = beersData
                  .where((beer) => beer.name
                      .toLowerCase()
                      .contains(dataStorage.searchedTerm.toLowerCase()))
                  .toList();

              return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: filteredBeersData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              id: filteredBeersData[index].id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: Image.network(
                                filteredBeersData[index].imageUrl,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: Text(
                                filteredBeersData[index].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  });
            });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
