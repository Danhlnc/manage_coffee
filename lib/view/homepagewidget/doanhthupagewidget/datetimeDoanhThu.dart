import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tscoffee/apps/globalvariables.dart';

class DatetimeDoanhThu extends StatefulWidget {
  Function callBack;
  DatetimeDoanhThu({super.key, required this.callBack});

  @override
  _DatetimeDoanhThuState createState() => _DatetimeDoanhThuState();
}

class _DatetimeDoanhThuState extends State<DatetimeDoanhThu> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 150,
        height: 50,
        child: InkWell(
          onTap: () async {
            dateTimeRange = (await showDateRangePicker(
                initialDateRange: dateTimeRange,
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100)))!;
                dateTimeRange.start.day != DateTime.now().day
                ? setState(() {
                    listBillsTotalDate = [...listBillsTotal];
                    var listProDate = [...listBillsTotalDate];
                    dateTimeRange = DateTimeRange(
    start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        dateTimeRange.start.year, dateTimeRange.start.month, dateTimeRange.start.day,7))),
    end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        dateTimeRange.end.year, dateTimeRange.end.month, dateTimeRange.end.day,7))));
                    for (var action in listProDate) {
                      if (action.keys.first.createdOn!
                              .isBefore(dateTimeRange.end) &&
                          action.keys.first.createdOn!
                              .isAfter(dateTimeRange.start)) {
                      } else {
                        listBillsTotalDate.remove(action);
                      }
                    }
                    widget.callBack("");
                  })
                : setState(() {
                    dateTimeRange = DateTime.now().hour<7? DateTimeRange(
    start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day-1,7))),
    end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day,7)))):DateTimeRange(
    start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day,7))),
    end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day+1,7))));
                    listBillsTotalDate = [...listBillsTotal];
                    var listProDate = [...listBillsTotalDate];
                    for (var action in listProDate) {
                      if (action.keys.first.createdOn!
                              .isBefore(dateTimeRange.end) &&
                          action.keys.first.createdOn!
                              .isAfter(dateTimeRange.start)) {
                      } else {
                        listBillsTotalDate.remove(action);
                      }
                    }
                    widget.callBack("");
                  });
          },
          child: Center(
            child: Text(
                '${dateTimeRange.start.day}/${dateTimeRange.start.month} Đến ${dateTimeRange.end.day}/${dateTimeRange.end.month}'),
          ),
        ),
      ),
    );
  }
}
