import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Experience',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
        ),
      ),
      home: const EditExperiencePage(),
    );
  }
}

class EditExperiencePage extends StatefulWidget {
  const EditExperiencePage({super.key});

  @override
  _EditExperiencePageState createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends State<EditExperiencePage> {
  bool _isCurrentlyWorking = false;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text('Edit Experience'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExperienceTextField(label: 'Designation*', initialValue: 'Head Trainer'),
            const SizedBox(height: 16),
            const ExperienceTextField(label: 'Company Name*', initialValue: 'Sports club, NY'),
            const SizedBox(height: 16),
            CurrentlyWorkingCheckbox(
              value: _isCurrentlyWorking,
              onChanged: (value) {
                setState(() {
                  _isCurrentlyWorking = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DatePickerField(
              label: 'Start Date*',
              date: _startDate,
              onChanged: (date) {
                setState(() {
                  _startDate = date;
                });
              },
            ),
            const SizedBox(height: 16),
            DatePickerField(
              label: 'End Date*',
              date: _endDate,
              onChanged: (date) {
                setState(() {
                  _endDate = date;
                });
              },
            ),
            const SizedBox(height: 16),
            const JobTypeDropdown(),
            const SizedBox(height: 24),
            const SaveButton(),
          ],
        ),
      ),
    );
  }
}

class ExperienceTextField extends StatelessWidget {
  final String label;
  final String initialValue;

  const ExperienceTextField({super.key, required this.label, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}

class CurrentlyWorkingCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CurrentlyWorkingCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.amber;
            }
            return Colors.grey;
          }),
        ),
        const Text('I am Currently Working Here'),
      ],
    );
  }
}

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;

  const DatePickerField({super.key, required this.label, required this.date, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null ? DateFormat('MMM - yyyy').format(date!) : 'Select Date',
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(Icons.calendar_today, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class JobTypeDropdown extends StatefulWidget {
  const JobTypeDropdown({super.key});

  @override
  _JobTypeDropdownState createState() => _JobTypeDropdownState();
}

class _JobTypeDropdownState extends State<JobTypeDropdown> {
  String? _selectedJobType = 'Full Time';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Job Type*', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedJobType,
              isExpanded: true,
              dropdownColor: const Color(0xFF1E1E1E),
              items: ['Full Time', 'Part Time', 'Contract']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedJobType = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Handle save action
        },
        child: const Text('Save'),
      ),
    );
  }
}