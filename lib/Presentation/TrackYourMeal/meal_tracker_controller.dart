import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:flutter/material.dart';

class MealTrackerController extends GetxController {
  // Observable date
  var selectedDate = DateTime.now().obs;
  var consumedCalories = 530.0.obs;
  var targetCalories = 2500.0.obs;

  // Function to pick date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  // Function to format the selected date
  String get formattedDate => DateFormat('dd MMM').format(selectedDate.value);
}
