import 'package:flutter/material.dart';

Future<DateTime?> dateTimePicker(BuildContext context) {
  return showDatePicker(
      barrierDismissible: false,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1991),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly);
}

List<String> category = [
  'Education',
  'Food',
  'Transport',
  'Health',
  'Housing',
  'Other'
];

Map<String, String> iconList = {
  'Education': 'assets/icons/education.png',
  'Food': 'assets/icons/food.png',
  'Transport': 'assets/icons/transport.png',
  'Health': 'assets/icons/health.png',
  'Housing': 'assets/icons/house.png',
  'Other': 'assets/icons/food.png'
};
