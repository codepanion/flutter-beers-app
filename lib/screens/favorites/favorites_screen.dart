import 'package:beer_app/data_storage.dart';
import 'package:beer_app/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/beer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataStorage>(context, listen: false).fetchFavoriteBeers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Consumer<DataStorage>(builder: (
        consumerCtx,
        dataStorage,
        child,
      ) {
        List<Beer> favoriteBeers = dataStorage.favoriteBeers;

        if (favoriteBeers.isNotEmpty) {
          return ListView.builder(
              itemCount: favoriteBeers.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            id: favoriteBeers[index].id,
                          ),
                        ),
                      );
                    },
                    title: Text(favoriteBeers[index].name),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        favoriteBeers[index].imageUrl,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        dataStorage.removeBeerFromFavorites(
                          favoriteBeers[index].id,
                        );
                      },
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: Text("List of favorite beers is empty"),
          );
        }
      }),
    );
  }
}
