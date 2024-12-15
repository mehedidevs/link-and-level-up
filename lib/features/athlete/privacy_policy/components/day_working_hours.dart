import 'package:flutter/material.dart';

class DayWorkingHours extends StatefulWidget {
  final String day;

  const DayWorkingHours({super.key, required this.day});

  @override
  _DayWorkingHoursState createState() => _DayWorkingHoursState();
}

class _DayWorkingHoursState extends State<DayWorkingHours> {
  bool isAvailable = true;
  TimeOfDay fromTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay toTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(widget.day),
              value: isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                });
              },
            ),
            if (isAvailable) _buildTimePickers() else _buildNotAvailable(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timePicker("From", fromTime, (newTime) {
          setState(() => fromTime = newTime);
        }),
        _timePicker("To", toTime, (newTime) {
          setState(() => toTime = newTime);
        }),
      ],
    );
  }

  Widget _timePicker(String label, TimeOfDay initialTime, Function(TimeOfDay) onSelected) {
    return Flexible(
      child: Column(
        children: [
          Text(label),
          InkWell(
            onTap: () => _selectTime(context, initialTime, onSelected),
            child: Text(initialTime.format(context)),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime, Function(TimeOfDay) onSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && picked != initialTime) {
      onSelected(picked);
    }
  }

  Widget _buildNotAvailable() {
    return const Center(
      child: Text("Not Available"),
    );
  }
}
