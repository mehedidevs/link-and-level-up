import 'package:flutter/material.dart';

import '../../parent/home/components/favorite_facilitator.dart';
import '../../parent/home/components/favorite_trainer.dart';
import 'components/nearby_facilitator.dart';

class NestedScrollViewExample extends StatelessWidget {
  const NestedScrollViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("NestedScrollView Example",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://via.placeholder.com/350x150",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const NearbyFacilitator(),
              ),
            ),
            const Expanded(
              child: FavoriteTrainer(),
            ),
          ],
        ),
      ),
    );
  }
}

class AthleteFavorite extends StatefulWidget {
  const AthleteFavorite({super.key});

  @override
  State<AthleteFavorite> createState() => _AthleteFavoriteState();
}

class _AthleteFavoriteState extends State<AthleteFavorite> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FavoriteFacilitator(),
              FavoriteTrainer(),
            ],
          ),
        ),
      ),
    );
  }
}
