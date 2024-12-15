import 'package:flutter/material.dart';

import 'config/app_colors.dart';
import 'config/app_defaults.dart';


class TimeSlot {
  final String day;
  bool isAvailable;
  String fromTime;
  String toTime;

  TimeSlot({
    required this.day,
    this.isAvailable = true,
    this.fromTime = '10:00 AM',
    this.toTime = '10:00 AM',
  });
}

class TimeSlotSelector extends StatefulWidget {
  final List<TimeSlot> initialTimeSlots;
  final Function(List<TimeSlot>) onTimeSlotChanged;

  const TimeSlotSelector({super.key, 
    required this.initialTimeSlots,
    required this.onTimeSlotChanged,
  });

  @override
  _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  late List<TimeSlot> _timeSlots;

  @override
  void initState() {
    super.initState();
    _timeSlots = widget.initialTimeSlots;
  }

  String _abbreviateDay(String day) {
    return day.substring(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows the inner ListView to take only the necessary space
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                children: [
                  Switch(
                    value: _timeSlots[index].isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _timeSlots[index].isAvailable = value;
                        widget.onTimeSlotChanged(_timeSlots);
                      });
                    },
                    activeColor: AppColors.secondary500,
                    inactiveThumbColor: AppColors.thumbColorD9,
                    inactiveTrackColor: AppColors.background300,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 40,
                    child: Text(
                      _abbreviateDay(_timeSlots[index].day),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_timeSlots[index].isAvailable)
                    Expanded(
                      child: constraints.maxWidth > 300
                          ? Row(
                              children: [
                                Expanded(
                                    child: _buildTimeDropdown(
                                        'From', index, true)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child:
                                        _buildTimeDropdown('To', index, false)),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTimeDropdown('From', index, true),
                                const SizedBox(height: 8),
                                _buildTimeDropdown('To', index, false),
                              ],
                            ),
                    )
                  else
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background450,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          textAlign: TextAlign.center,
                          'Not Available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTimeDropdown(String label, int index, bool isFromTime) {
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.background450,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppDefaults.titleStyleReview,
          ),
          const SizedBox(width: 2),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: isFromTime
                    ? _timeSlots[index].fromTime
                    : _timeSlots[index].toTime,
                dropdownColor: AppColors.background450,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.white, size: 20),
                isDense: true,
                isExpanded: true,
                items: _generateTimeList().map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      if (isFromTime) {
                        _timeSlots[index].fromTime = newValue;
                      } else {
                        _timeSlots[index].toTime = newValue;
                      }
                      widget.onTimeSlotChanged(_timeSlots);
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _generateTimeList() {
    List<String> times = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String period = hour >= 12 ? 'PM' : 'AM';
        int displayHour = hour % 12 == 0 ? 12 : hour % 12;
        times.add(
            '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period');
      }
    }
    return times;
  }
}


