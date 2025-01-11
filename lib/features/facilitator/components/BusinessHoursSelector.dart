import 'package:flutter/material.dart';
import 'package:link_level_up/config/app_colors.dart';
import 'package:link_level_up/config/app_defaults.dart';

class BusinessHours {
  final bool isAvailable;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  BusinessHours({
    this.isAvailable = true,
    this.startTime,
    this.endTime,
  });

  // Convert TimeOfDay to DateTime string in UTC
  String? timeOfDayToUTC(TimeOfDay? time) {
    if (time == null) return null;

    final now = DateTime.now().toUtc();
    final datetime = DateTime.utc(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return datetime.toIso8601String();
  }

  // Convert to JSON format
  Map<String, dynamic> toJson(String weekDay) {
    return {
      "week_day": weekDay.toLowerCase(),
      "start_time": isAvailable ? timeOfDayToUTC(startTime) : null,
      "end_time": isAvailable ? timeOfDayToUTC(endTime) : null,
      "available": isAvailable ? 1 : 0,
    };
  }
}

class TimeDropdown extends StatelessWidget {
  final String title;
  final TimeOfDay value;
  final Function(TimeOfDay) onChanged;

  const TimeDropdown({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.inputFiledBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.selectedBorderColor, // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: AppDefaults.buttonTextStyleSmall
                    .copyWith(color: AppColors.textDark9),
              ),
            ),
            Expanded(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<TimeOfDay>(
                  value: value,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  underline: const SizedBox(),
                  dropdownColor: const Color(0xFF1C1C1E),
                  style: AppDefaults.buttonTextStyleSmall,
                  items: [
                    for (int hour = 0; hour < 24; hour++)
                      for (int minute in [0, 30])
                        DropdownMenuItem(
                          value: TimeOfDay(hour: hour, minute: minute),
                          child: Text(
                            TimeOfDay(hour: hour, minute: minute)
                                .format(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                  ],
                  onChanged: (TimeOfDay? newTime) {
                    if (newTime != null) {
                      onChanged(newTime);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessHoursSelector extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onHoursChanged;

  const BusinessHoursSelector({
    super.key,
    required this.onHoursChanged,
  });

  @override
  BusinessHoursSelectorState createState() => BusinessHoursSelectorState();
}

class BusinessHoursSelectorState extends State<BusinessHoursSelector> {
  final Map<String, BusinessHours> businessHours = {
    'Monday': BusinessHours(
      isAvailable: false,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Tuesday': BusinessHours(
      isAvailable: true,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Wednesday': BusinessHours(
      isAvailable: false,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Thursday': BusinessHours(
      isAvailable: true,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Friday': BusinessHours(
      isAvailable: true,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Saturday': BusinessHours(
      isAvailable: true,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    'Sunday': BusinessHours(
      isAvailable: true,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    ),
  };

  void updateHours() {
    final List<Map<String, dynamic>> availableHours = businessHours.entries
        .map((entry) => entry.value.toJson(entry.key))
        .toList();
    widget.onHoursChanged(availableHours);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: businessHours.entries.map((entry) {
              final day = entry.key;
              final hours = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45,
                      child: Switch(
                        activeColor: AppColors.secondary500,
                        value: hours.isAvailable,
                        onChanged: (value) {
                          setState(() {
                            businessHours[day] = BusinessHours(
                              isAvailable: value,
                              startTime: value
                                  ? (hours.startTime ??
                                      const TimeOfDay(hour: 10, minute: 0))
                                  : null,
                              endTime: value
                                  ? (hours.endTime ??
                                      const TimeOfDay(hour: 17, minute: 0))
                                  : null,
                            );
                          });
                          updateHours();
                        },
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    SizedBox(
                      width: 40,
                      child: Text(
                        day.substring(0, 3),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ),

                    Expanded(
                      child: hours.isAvailable
                          ? Row(
                              children: [
                                TimeDropdown(
                                  title: 'From',
                                  value: hours.startTime ??
                                      const TimeOfDay(hour: 9, minute: 0),
                                  onChanged: (TimeOfDay newTime) {
                                    setState(() {
                                      businessHours[day] = BusinessHours(
                                        isAvailable: true,
                                        startTime: newTime,
                                        endTime: hours.endTime,
                                      );
                                    });
                                    updateHours();
                                  },
                                ),
                                const SizedBox(width: 8.0),
                                TimeDropdown(
                                  title: 'To',
                                  value: hours.endTime ??
                                      const TimeOfDay(hour: 17, minute: 0),
                                  onChanged: (TimeOfDay newTime) {
                                    setState(() {
                                      businessHours[day] = BusinessHours(
                                        isAvailable: true,
                                        startTime: hours.startTime,
                                        endTime: newTime,
                                      );
                                    });
                                    updateHours();
                                  },
                                ),
                              ],
                            )
                          : Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.inputFiledBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: AppColors.selectedBorderColor,
                                      width: 1)),
                              child: Text(
                                'Not Available',
                                style: AppDefaults.buttonTextStyleSmall,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
