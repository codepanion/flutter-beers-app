import 'package:beer_app/data_storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/beer.dart';

class DetailsInfo extends StatelessWidget {
  final Beer beer;

  const DetailsInfo({
    super.key,
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(beer.name),
                  Text(beer.description),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Consumer<DataStorage>(
              builder: (consumerCtx, dataStorage, child) {
                bool beerIsAddedToFavorites = dataStorage.favoriteBeers
                        .firstWhereOrNull(
                            (favoriteBeer) => favoriteBeer.id == beer.id) !=
                    null;
                return ElevatedButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: const Text("Add to Favorites"),
                  onPressed: beerIsAddedToFavorites
                      ? null
                      : () {
                          dataStorage.addBeerToFavorites(beer);
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
