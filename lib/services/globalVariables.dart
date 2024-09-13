import 'package:flutter/material.dart';

// lib imports
import 'package:ads_course_project_minimum_cost_of_ticket/services/node.dart';
import 'package:ads_course_project_minimum_cost_of_ticket/services/dayOfYear.dart';

// sync fusion date picker imports
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

List<DateTime> selectedDates = [];
List<int> days = [];
List<int> costs = [];
List<Node> minNode = [];

// day of year instance
DayOfYear dayOfYear = DayOfYear();

// date range picker controller
DateRangePickerController selectedDatesController = DateRangePickerController();

// text form controllers
TextEditingController daily = TextEditingController();
TextEditingController weekly = TextEditingController();
TextEditingController monthly = TextEditingController();

dynamic onSubmit() {
  selectedDates = selectedDatesController.selectedDates!;
  days = dayOfYear.getListDayOfYear(selectedDates);
}

dynamic onCancel() {
  selectedDatesController.selectedDates = [];
  daily.clear();
  weekly.clear();
  monthly.clear();
  days = [];
  costs = [];
  minNode = [];
  selectedDates = [];
}
