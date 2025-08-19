library tscoffee.globals;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tscoffee/model/WebStorage.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inDays);
}

DateTimeRange dateTimeRangeQLKho = DateTime.now().hour < 7
    ? DateTimeRange(
        start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day - 1,
            7))),
        end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 7))))
    : DateTimeRange(
        start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 7))),
        end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 7))));
setTimeRange() {
  dateTimeRangeQLKho = DateTime.now().hour < 7
      ? DateTimeRange(
          start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 1,
              7))),
          end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              7))))
      : DateTimeRange(
          start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              7))),
          end: DateTime.parse(
              DateFormat('yyyy-MM-dd HH:mm').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 7))));
}

bool checkDoiSac = true;
DateTime date = DateTime.now();
WebStorage webStorage = WebStorage();
DateTimeRange dateTimeRange = DateTime.now().hour < 7
    ? DateTimeRange(
        start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day - 1,
            7))),
        end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 7))))
    : DateTimeRange(
        start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 7))),
        end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 7))));
