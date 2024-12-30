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
                    dateTimeRange = DateTimeRange(
                        start: DateTime.parse(DateFormat('yyyy-MM-dd').format(
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day))),
                        end: DateTime.parse(DateFormat('yyyy-MM-dd').format(
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day + 1))));
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
