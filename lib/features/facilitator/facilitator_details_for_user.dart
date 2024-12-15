import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';
import 'components/facilitator_about.dart';
import 'components/facilitator_gallary.dart';
import 'components/facilitator_in_trainer.dart';
import 'components/facilitator_review.dart';

class FacilitatorDetailsForUser extends StatelessWidget {
  const FacilitatorDetailsForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCarousel(),
                RatingAndInfo(),
                LocationCard(),
                TabNavigation(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BookingSection(),
            )
          ],
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> _imageUrls = [
    // Replace these URLs with the actual image URLs
    'https://image.cnbcfm.com/api/v1/image/104048950-GettyImages-557920441.jpg?v=1665838801&w=1920&h=1080',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Youth-soccer-indiana.jpg/600px-Youth-soccer-indiana.jpg',
    'https://images.unsplash.com/photo-1593013820725-ca0b6076576f?q=80&w=4140&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://img.freepik.com/free-photo/one-jump-before-winning-african-american-young-basketball-player-red-team-action-neon-lights-dark-studio-background-concept-sport-movement-energy-dynamic-healthy-lifestyle_155003-34475.jpg?size=626&ext=jpg&ga=GA1.1.1981913578.1723304236&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/football-soccer-player-black-background-mixed-light-fire-shadows_155003-42066.jpg?w=2000&t=st=1723304339~exp=1723304939~hmac=ea8eb34a9fb44cc8a6a0ee9a88fa616e44ebd285dad7979974440f852de58dff',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                _imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
        ),
        Positioned(
          right: AppDefaults.space,
          left: AppDefaults.space,
          bottom: 4,
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: AppColors.background50,
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppDefaults.radius),
                        child: Image.network(
                          _imageUrls[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class RatingAndInfo extends StatelessWidget {
  const RatingAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.sports_soccer),
          const SizedBox(width: 8),
          Text(
            'Football, Cricket',
            style: AppDefaults.bodyTextStyle,
          ),
          const Spacer(),
          SvgPicture.asset('icons/ic_star.svg'),
          const SizedBox(
            width: 4,
          ),
          Text('4.8 (100 Reviews)', style: AppDefaults.bodyTextStyle),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kingdom stadium',
                style: AppDefaults.titleHeadlineStyle,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.white,
                  ),
                  Text(
                    'Green Valley, Hill road, NY',
                    style: AppDefaults.titleStyle,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          SvgPicture.asset('icons/ic_send.svg'),
        ],
      ),
    );
  }
}

class ImageTabIndicator extends Decoration {
  final String assetImagePath;

  const ImageTabIndicator({required this.assetImagePath});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ImagePainter(this, assetImagePath, onChanged);
  }
}

class _ImagePainter extends BoxPainter {
  final ImageTabIndicator decoration;
  final String assetImagePath;

  _ImagePainter(this.decoration, this.assetImagePath, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final ImageProvider imageProvider = AssetImage(assetImagePath);
    final ImageStream imageStream = imageProvider.resolve(configuration);
    imageStream.addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        final Size imageSize = Size(imageInfo.image.width.toDouble(),
            imageInfo.image.height.toDouble());
        final Offset imageOffset = offset +
            Offset((configuration.size!.width - imageSize.width) / 2,
                configuration.size!.height - imageSize.height);

        paintImage(
          canvas: canvas,
          rect: imageOffset & imageSize,
          image: imageInfo.image,
          fit: BoxFit.cover,
        );
      }),
    );
  }
}

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.transparent,
                  width: 0), // Ensure no bottom border
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Trainer'),
              Tab(text: 'Gallery'),
              Tab(text: 'Reviews'),
            ],
            indicator: const ImageTabIndicator(
                assetImagePath: 'icons/ic_indicator.png'),
            labelColor: AppColors.text00,
            unselectedLabelColor: AppColors.background100,
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.zero,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.transparent,
                  width: 0), // Ensure no bottom border
            ),
          ),
          height: 500, // Adjust this height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              const Center(child: FacilitatorAbout()),
              Center(child: TrainerListView()),
              const Center(child: FacilitatorGallary()),
              const Center(child: FacilitatorReview()),
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
      ),
    );
  }
}

class OwnerInformation extends StatelessWidget {
  const OwnerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('JD'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jhony Deep', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Owner'),
            ],
          ),
          Spacer(),
          Icon(Icons.phone),
          SizedBox(width: 8),
          Icon(Icons.message),
        ],
      ),
    );
  }
}

class FacilitiesList extends StatelessWidget {
  const FacilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [Icon(Icons.local_parking), Text('Car Park')]),
          Column(children: [Icon(Icons.wc), Text('Washroom')]),
          Column(children: [Icon(Icons.shower), Text('Shower')]),
          Column(children: [Icon(Icons.lock), Text('Locker')]),
          Column(children: [Icon(Icons.wifi), Text('Wi-Fi')]),
        ],
      ),
    );
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Address'),
          const Text('Green Valley, Hill road, NY'),
          Container(
            height: 200,
            color: Colors.grey,
            child: const Center(child: Text('Map Placeholder')),
          ),
        ],
      ),
    );
  }
}

class BookingSection extends StatelessWidget {
  const BookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.background400,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      padding: const EdgeInsets.only(bottom: 40.0, top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Total Price', style: AppDefaults.titleStyleSmall),
                Row(
                  children: [
                    Text('\$130.00', style: AppDefaults.bodyTitleTextStyle),
                    Text('/month', style: AppDefaults.titleStyleSmall),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.PaymentMethod);
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
