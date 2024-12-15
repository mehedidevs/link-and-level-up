import 'package:flutter/material.dart';


import '../../components/buttons.dart';
import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class FacilitatorSession extends StatelessWidget {
  const FacilitatorSession({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          OngoingSession(),
          SizedBox(
            height: 8,
          ),
          UpcomingSession()
        ],
      ),
    );
  }
}

class OngoingSession extends StatelessWidget {
  const OngoingSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongoing Session',
                style: AppDefaults.titleHeadlineStyle,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppDefaults.titleSeeAll,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const SessionCard(
              title: 'Football Keeping Session',
              description:
                  'There are many variations of passages of Lorem Ipsum available, but the majority...',
              time: '05:00 PM - 06:00 PM',
              location: 'Ark Sports Club, NY',
            );
          },
        ),
      ],
    );
  }
}

class SessionCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String location;

  const SessionCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background500,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppDefaults.textWhite500,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppDefaults.titleStyleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  time,
                  style: AppDefaults.textWhite12_400,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: AppDefaults.textWhite12_400,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MoreDetailsButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.SessionDetailsPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingSession extends StatelessWidget {
  const UpcomingSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Session',
                style: AppDefaults.titleHeadlineStyle,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppDefaults.titleSeeAll,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const UpcomingSessionCard(
              title: 'Football Keeping Session',
              description:
                  'There are many variations of passages of Lorem Ipsum available, but the majority...',
              date: '20th May, 2024',
              time: '05:00 PM - 06:00 PM',
              location: 'Ark Sports Club, Herison Road, NY, 71005363',
            );
          },
        ),
      ],
    );
  }
}

class UpcomingSessionCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;

  const UpcomingSessionCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.SessionDetailsPage);
      },
      child: Card(
        color: AppColors.background500,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppDefaults.textWhite600,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppDefaults.titleStyleSmall,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: AppDefaults.titleStyleSmall,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 16,
                      width: 1,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: AppColors.primary500),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: AppDefaults.titleStyleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 16, color: AppColors.primary500),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Text(
                    location,
                    style: AppDefaults.titleStyleSmall,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
