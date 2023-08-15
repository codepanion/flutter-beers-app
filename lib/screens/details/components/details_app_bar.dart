import 'package:flutter/material.dart';

class DetailsAppBar extends StatelessWidget {
  final String imageUrl;
  const DetailsAppBar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      stretch: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            margin: const EdgeInsets.only(
              top: 50.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ),
    );
  }
}
