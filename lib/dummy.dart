import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'config/app_colors.dart';





class HourlyRatePicker extends StatefulWidget {
  final String initialCurrency;
  final String initialRate;
  final Function(String, String) onChanged;

  const HourlyRatePicker({
    super.key,
    required this.initialCurrency,
    required this.initialRate,
    required this.onChanged,
  });

  @override
  _HourlyRatePickerState createState() => _HourlyRatePickerState();
}

class _HourlyRatePickerState extends State<HourlyRatePicker> {
  late String _selectedCurrency;
  late TextEditingController _rateController;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'AUD'];

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.initialCurrency;
    _rateController = TextEditingController(text: widget.initialRate);

    // Add a listener to the rate controller to trigger the callback on rate change
    _rateController.addListener(() {
      widget.onChanged(_selectedCurrency, _rateController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hourly Rate',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.background600, // Dark background similar to the image
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              // Dropdown for Currency Picker
              DropdownButton<String>(
                value: _selectedCurrency,
                dropdownColor: const Color(0xFF1C1C1C), // Dark dropdown
                style: const TextStyle(color: Colors.white),
                underline: const SizedBox(), // To remove underline
                items: _currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                    widget.onChanged(_selectedCurrency, _rateController.text); // Trigger callback on currency change
                  });
                },
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 1,
                width: 20,
              ),
              // TextField for the rate
              Expanded(
                child: TextField(
                  controller: _rateController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: const InputDecoration(
                    prefixText: '\$', // Adds the currency symbol before the number
                    prefixStyle: TextStyle(color: Colors.white, fontSize: 20),
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(color: Colors.white70),
                    contentPadding:EdgeInsets.symmetric(vertical: 4)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }
}




class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Colors.green, // Change the color here
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Colors.green, // Change the color here
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 3),
                const FlSpot(2, 7),
                const FlSpot(3, 4),
                const FlSpot(4, 5),
              ],
              isCurved: true,
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEventButton extends StatelessWidget {
  const AddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Define the action when the button is pressed
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Add Event',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4EC5C1), // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside button
      ),
    );
  }
}
