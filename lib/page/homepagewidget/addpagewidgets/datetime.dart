import 'package:flutter/material.dart';
import 'package:tscoffee/apps/globalvariables.dart';

class Datetime extends StatefulWidget {
  Function callBack;
  Datetime({super.key, required this.callBack});

  @override
  _DatetimeState createState() => _DatetimeState();
}

DatePickerDialog selectedDate =
    DatePickerDialog(firstDate: DateTime.now(), lastDate: DateTime.now());

class _DatetimeState extends State<Datetime> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 100,
        height: 50,
        child: InkWell(
          onTap: () async {
            DateTime? dataTimeRange = await showDatePicker(
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            dataTimeRange != null
                ? setState(() {
                    date = dataTimeRange;
                    listBills = [...listBillsTotal];
                    loadData = false;
                    listBills.sort((b, a) => a.keys.first.modifyOn!
                        .compareTo(b.keys.first.modifyOn as DateTime));
                    listBillsTotal = [...listBills];
                    var listPro = [...listBills];
                    for (var action in listPro) {
                      if (action.keys.first.createdOn!.day != date.day) {
                        listBills.remove(action);
                      }
                    }
                    widget.callBack("");
                  })
                : setState(() {
                    date = DateTime.now();
                    widget.callBack("");
                  });
          },
          child: Center(child: Text('${date.day}/${date.month}/${date.year}')),
        ),
      ),
    );
  }
}
