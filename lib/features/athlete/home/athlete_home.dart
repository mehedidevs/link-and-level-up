import 'package:flutter/material.dart';
import '../../parent/home/components/athlete_search_bar.dart';
import '../../parent/home/components/fetured_trainer.dart';
import '../../parent/home/components/nearby_facilitator.dart';
import '../../parent/home/components/top_trainer.dart';

class AthleteHomePage extends StatefulWidget {
  const AthleteHomePage({super.key});

  @override
  State<AthleteHomePage> createState() => _AthleteHomePageState();
}

class _AthleteHomePageState extends State<AthleteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AthleteSearchBar(),
            ),
            const SliverToBoxAdapter(
              child: FeaturedTrainer(),
            ),
            const SliverToBoxAdapter(
              child: TopTrainer(),
            ),
            const SliverToBoxAdapter(
              child: NearbyFacilitator(),
            ),
            SliverToBoxAdapter(
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/banner%2FFrame%201171275776%20(1).png?alt=media&token=914706c1-7d48-4521-a5d4-4f15b2290c49'),
            )
          ],
        ),
      ),
    );
  }
}
