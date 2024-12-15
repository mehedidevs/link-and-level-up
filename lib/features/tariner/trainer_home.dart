import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../components/buttons.dart';
import '../../components/shapes.dart';
import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class TrainerHomePage extends StatelessWidget {
  const TrainerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpcomingSessionsSection(),
              SizedBox(height: 20),
              AthleteRequestsSection(),
              SizedBox(height: 20),
              YourStatSection(),
              SizedBox(height: 20),
              CalendarSection(),
              SizedBox(height: 20),
              ProfileCompletionSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingSessionsSection extends StatelessWidget {
  const UpcomingSessionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Upcoming Session', style: AppDefaults.otpTextStyle),
            TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppDefaults.titleSeeAll,
                )),
          ],
        ),
        const SessionCard(
          title: 'Basketball Workout Training',
          location: 'Green Valley, Hill road, NY',
          date: '14th Apr',
          time: '04pm-05pm',
        ),
        // Add more SessionCard widgets as needed
      ],
    );
  }
}

class SessionCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;

  const SessionCard({
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: AppDefaults.bodyTextStyle
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(
              height: AppDefaults.padding / 2,
            ),
            Row(
              children: [
                SvgPicture.asset('icons/ic_location.svg',
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary500, BlendMode.srcIn)),
                const SizedBox(
                  width: AppDefaults.padding / 4,
                ),
                Text(location, style: AppDefaults.titleStyleSmall),
              ],
            ),
            const SizedBox(
              height: AppDefaults.padding / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('icons/ic_calendar.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.primary500, BlendMode.srcIn)),
                    const SizedBox(
                      width: AppDefaults.padding / 4,
                    ),
                    Text('$date $time', style: AppDefaults.titleStyleSmall),
                  ],
                ),
                MoreDetailsButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.SessionDetailsPage);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: AppDefaults.padding / 2,
            ),
          ],
        ),
      ),
    );
  }
}

class AthleteRequestsSection extends StatelessWidget {
  const AthleteRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Athlete Request', style: AppDefaults.otpTextStyle),
            TextButton(
                onPressed: () {},
                child: Text('See all', style: AppDefaults.titleSeeAll)),
          ],
        ),
        const AthleteRequestCard(
          id: 'Jhony Dep',
          name: 'Jhony Dep',
          message:
              'There are many variations of passages of Lorem Ipsum available, but the majority...',
          location: 'Green Valley, Hill road, NY',
          isToday: true,
        ),
        const AthleteRequestCard(
          id: 'Jhony Dep',
          name: 'Jhon Doe',
          message:
              'There are many variations of passages of Lorem Ipsum available, but the majority...',
          location: 'Green Valley, Hill road, NY',
          isToday: false,
          date: '11th Mar',
        ),
      ],
    );
  }
}

class AthleteRequestCard extends StatelessWidget {
  final String id; // Added ID
  final String name;
  final String message;
  final String location;
  final bool isToday;
  final String? date;
  final void Function(String id)? onReject; // Callback for Reject button
  final void Function(String id)? onAccept; // Callback for Accept button
  final void Function(String id)? onTap; // Callback for tapping the card

  const AthleteRequestCard({
    super.key,
    required this.id, // Added ID
    required this.name,
    required this.message,
    required this.location,
    required this.isToday,
    this.date,
    this.onReject, // Added reject callback
    this.onAccept, // Added accept callback
    this.onTap, // Added onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.RequestAthleteDetails);

        /*   if (onTap != null) {
          onTap!(id); // Trigger onTap when the card is tapped
        }*/
      },
      child: Card(
        color: AppColors.background500,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                      // Replace with your image URL
                      width: 40, // Set the width of the image
                      height: 40, // Set the height of the image
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire circle
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(name,
                      style: AppDefaults.bodyTextStyle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Text(isToday ? 'Today' : date!,
                      style: AppDefaults.bodyTextStyle),
                ],
              ),
              const SizedBox(height: AppDefaults.padding / 2),
              Text(message, style: AppDefaults.bodyTextStyle),
              const SizedBox(height: AppDefaults.padding),
              Row(
                children: [
                  SvgPicture.asset('icons/ic_calendar.svg'),
                  const SizedBox(width: AppDefaults.padding / 4),
                  Text(location, style: AppDefaults.bodyTextStyle),
                ],
              ),
              const SizedBox(height: AppDefaults.padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RejectButton(
                    height: 30,
                    width: 85,
                    onPressed: () {
                      if (onReject != null) {
                        onReject!(id); // Pass the id on reject
                      }
                    },
                    title: 'Reject',
                  ),
                  const SizedBox(width: AppDefaults.padding),
                  AcceptButton(
                    height: 30,
                    width: 85,
                    onPressed: () {
                      if (onAccept != null) {
                        onAccept!(id); // Pass the id on accept
                      }
                    },
                    title: "Accept",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourStatSection extends StatelessWidget {
  const YourStatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Circular(color: AppColors.color_5899FF),
                SizedBox(
                  width: 4,
                ),
                Text('58 Students',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              width: 16,
            ),
            Row(
              children: [
                Circular(color: AppColors.color_45434D),
                SizedBox(
                  width: 8,
                ),
                Text('58 Facility request',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const titles = ['Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
                      return Text(titles[value.toInt()],
                          style: const TextStyle(
                            color: Colors.white, // Change the color here
                            fontSize: 12,
                          ));
                    },
                    reservedSize: 40,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(toY: 30, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 58, color: AppColors.color_45434D),
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 20, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 10, color: AppColors.color_45434D),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 40, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 30, color: AppColors.color_45434D),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 30, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 50, color: AppColors.color_45434D),
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(toY: 50, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 40, color: AppColors.color_45434D),
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(toY: 55, color: AppColors.color_5899FF),
                  BarChartRodData(toY: 60, color: AppColors.color_45434D),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _selectedDate = DateTime.now();
  DateTime _displayedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calendar', style: AppDefaults.otpTextStyle),
              AddEventButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.entryPoint);
                },
                title: 'Add Event',
                width: 85,
                height: 35,
                borderRadius: AppDefaults.padding,
              )
            ],
          ),
          const SizedBox(height: 16),
          _buildCalendarHeader(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}',
          style: AppDefaults.titleHeadlineStyle,
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: _previousMonth,
            ),
            IconButton(
              icon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              onPressed: _nextMonth,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (index < 7) {
          return _buildDayLabel(['S', 'M', 'T', 'W', 'T', 'F', 'S'][index]);
        }
        final date = _getDateForIndex(index - 7);
        return _buildDateCell(date);
      },
      itemCount: 7 +
          (_daysInMonth(_displayedMonth) +
              _firstDayOfWeek(_displayedMonth) -
              1),
    );
  }

  Widget _buildDayLabel(String day) {
    return Center(
      child: Text(
        day,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildDateCell(DateTime date) {
    final isSelected = date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
    final isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    return GestureDetector(
      onTap: () => setState(() => _selectedDate = date),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : (isToday ? Colors.orange : null),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected || isToday ? Colors.white : Colors.grey,
              fontWeight:
                  isSelected || isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);
    });
  }

  String _getMonthName(int month) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][month - 1];
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _firstDayOfWeek(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  DateTime _getDateForIndex(int index) {
    final firstDayOfMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final dayOffset = _firstDayOfWeek(firstDayOfMonth);
    return firstDayOfMonth.add(Duration(days: index - dayOffset));
  }
}

class ProfileCompletionSection extends StatefulWidget {
  const ProfileCompletionSection({super.key});

  @override
  State<ProfileCompletionSection> createState() =>
      _ProfileCompletionSectionState();
}

class _ProfileCompletionSectionState extends State<ProfileCompletionSection> {
  @override
  Widget build(BuildContext context) {
    int progress = 80;

    return Card(
      color: AppColors.background500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profile Completion', style: AppDefaults.otpTextStyle),
                  Text('80%', style: AppDefaults.otpTextStyle),
                ],
              ),
            ),
            Slider(
              inactiveColor: AppColors.secondary100,
              thumbColor: AppColors.secondary400,
              activeColor: AppColors.secondary400,
              value: progress.toDouble(),
              onChanged: (value) {
                setState(() {
                  progress = value.toInt();
                });
              },
              min: 0,
              max: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Complete Your Profile →',
                      style: AppDefaults.bodyTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
