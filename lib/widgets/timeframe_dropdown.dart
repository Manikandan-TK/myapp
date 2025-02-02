import 'package:flutter/material.dart';

const List<Map<String, dynamic>> timeframeOptions = [
  {'label': 'Hourly', 'minutes': 60},
  {'label': 'Daily', 'minutes': 1440},
  {'label': 'Weekly', 'minutes': 10080},
  {'label': 'Off', 'minutes': 0},
];

class TimeframeDropdown extends StatefulWidget {
  final ValueChanged<int> onTimeframeChanged;

  const TimeframeDropdown({
    super.key,
    required this.onTimeframeChanged,
  });

  @override
  State<TimeframeDropdown> createState() => _TimeframeDropdownState();
}

class _TimeframeDropdownState extends State<TimeframeDropdown> {
  String _selectedLabel = timeframeOptions.first['label'] as String;

  // Helper method to get the minute value for a given label
  int _getMinutesForLabel(String label) {
    final option = timeframeOptions.firstWhere(
      (option) => option['label'] == label,
      orElse: () => timeframeOptions.first, // Fallback to the first option if label not found (shouldn't happen)
    );
    return option['minutes'] as int;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedLabel,
      decoration: const InputDecoration(
        labelText: 'Change Frequency',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      items: timeframeOptions.map((option) {
        return DropdownMenuItem<String>(
          value: option['label'] as String,
          child: Text(option['label'] as String),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _selectedLabel = newValue);
          widget.onTimeframeChanged(_getMinutesForLabel(newValue));
        }
      },
    );
  }
}