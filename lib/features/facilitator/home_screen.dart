import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


import '../../components/buttons.dart';
import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OngoingSession(),
            UpcomingSession(),
            SessionHistory(),
          ],
        ),
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.CreateNewSessionPage);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background500,
              // Set your background color here
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize:
                  const Size(double.infinity, 50), // Optional: adjust padding
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset('icons/ic_plus_circle.svg')),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Create New Session',
                  style: AppDefaults.buttonTextStyle,
                ),
              ],
            )),
          ),
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
        CalendarWidget(
          initialDate: DateTime.now(),
          highlightedDates: [
            DateTime(2024, 9, 9),
            DateTime(2024, 9, 22),
            DateTime(2024, 10, 23),
            DateTime(2024, 19, 9),
            DateTime(2024, 10, 12),
            DateTime(2024, 10, 23),
          ],
          onDateSelected: (selectedDate) {
            print('Selected date: $selectedDate');
            // Handle the selected date
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
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

class CalendarWidget extends StatefulWidget {
  final DateTime initialDate;
  final List<DateTime> highlightedDates;
  final Function(DateTime)? onDateSelected;

  const CalendarWidget({
    super.key,
    required this.initialDate,
    required this.highlightedDates,
    this.onDateSelected,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _currentDate;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _changeMonth(int monthsToAdd) {
    setState(() {
      _currentDate =
          DateTime(_currentDate.year, _currentDate.month + monthsToAdd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.background500,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('MMMM yyyy').format(_currentDate),
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.grey),
              onPressed: () => _changeMonth(-1),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.grey),
              onPressed: () => _changeMonth(1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        _buildWeekdayHeader(),
        const SizedBox(height: 10),
        ...List.generate(6, (index) => _buildWeek(index)),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
          .map((day) => Text(
                day,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ))
          .toList(),
    );
  }

  Widget _buildWeek(int weekIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (dayIndex) {
        final date = _getDateForDayInWeek(weekIndex, dayIndex);
        final isCurrentMonth = date.month == _currentDate.month;
        final isHighlighted = _isDateHighlighted(date);
        final isSelected = _isDateSelected(date);

        return GestureDetector(
          onTap: () => _onDateTap(date),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary500 : Colors.transparent,
              border: isHighlighted
                  ? Border.all(color: AppColors.primary500, width: 1.5)
                  : null,
            ),
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: isCurrentMonth
                    ? (isSelected
                        ? Colors.black
                        : (isHighlighted ? AppColors.primary500 : Colors.white))
                    : Colors.grey,
                fontSize: 16,
                fontWeight: isHighlighted || isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }

  DateTime _getDateForDayInWeek(int weekIndex, int dayIndex) {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final firstDayWeekday = firstDayOfMonth.weekday % 7;
    final firstSundayDate =
        firstDayOfMonth.subtract(Duration(days: firstDayWeekday));
    return firstSundayDate.add(Duration(days: weekIndex * 7 + dayIndex));
  }

  bool _isDateHighlighted(DateTime date) {
    return widget.highlightedDates.any((highlightedDate) =>
        highlightedDate.year == date.year &&
        highlightedDate.month == date.month &&
        highlightedDate.day == date.day);
  }

  bool _isDateSelected(DateTime date) {
    return _selectedDate != null &&
        _selectedDate!.year == date.year &&
        _selectedDate!.month == date.month &&
        _selectedDate!.day == date.day;
  }

  void _onDateTap(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(date);
    }
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

class SessionHistory extends StatelessWidget {
  const SessionHistory({super.key});

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
              Text('Session History', style: AppDefaults.titleHeadlineStyle),
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
            return const HistoryCard(
              title: 'Basketball Workout Training',
              location: 'Green Valley, Hill road, NY',
              date: '14th Apr',
              time: '04pm-05pm',
            );
          },
        ),
      ],
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;

  const HistoryCard({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
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
              style: AppDefaults.textWhite600,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: AppColors.primary500),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: AppDefaults.titleStyleSmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.primary500,
                ),
                const SizedBox(width: 4),
                Text(date, style: AppDefaults.titleStyleSmall),
                const SizedBox(width: 4),
                Text(time),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MoreDetailsButton(
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
