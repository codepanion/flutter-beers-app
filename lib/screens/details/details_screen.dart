import 'package:beer_app/http_service.dart';
import 'package:beer_app/screens/details/components/details_app_bar.dart';
import 'package:beer_app/screens/details/components/details_info.dart';
import 'package:flutter/material.dart';

import '../../models/beer.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  const DetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final HttpService _httpService = HttpService();
  late Future<Beer> _beerDetails;

  @override
  void initState() {
    super.initState();
    _beerDetails = _httpService.fetchSingleBeer(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _beerDetails,
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (snapshot.hasData) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: <Widget>[
                  DetailsAppBar(
                    imageUrl: snapshot.data.imageUrl,
                  ),
                  DetailsInfo(beer: snapshot.data),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
