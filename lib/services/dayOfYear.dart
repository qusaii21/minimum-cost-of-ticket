import 'package:flutter/rendering.dart';
import 'package:jiffy/jiffy.dart';

class DayOfYear {
  List<int> getListDayOfYear(List<DateTime> listDateTime) {
    List<int> listDayOfYear = [];

    listDateTime.forEach((element) {
      int current =
          Jiffy.parseFromDateTime(DateTime(element.year, element.month, element.day)).dayOfYear;
      listDayOfYear.add(current);
    });

    listDayOfYear.sort();
    return listDayOfYear;
  }
}
