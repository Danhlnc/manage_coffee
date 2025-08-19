import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/providerModel.dart';

class Datetime extends StatefulWidget {
  Function callBack;
  Datetime({super.key, required this.callBack});

  @override
  _DatetimeState createState() => _DatetimeState();
}

DatePickerDialog selectedDate =
    DatePickerDialog(firstDate: date, lastDate: date);

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
                    context.read<ProviderModel>().listBills = [
                      ...context.read<ProviderModel>().listBillsTotal
                    ];
                    context.read<ProviderModel>().updateloadData(false);
                    context.read<ProviderModel>().listBills.sort((b, a) => a
                        .keys.first.modifyOn!
                        .compareTo(b.keys.first.modifyOn as DateTime));
                    context.read<ProviderModel>().listBillsTotal = [
                      ...context.read<ProviderModel>().listBills
                    ];
                    var listPro = [...context.read<ProviderModel>().listBills];
                    for (var action in listPro) {
                      if (action.keys.first.createdOn!.day != date.day ||
                          action.keys.first.createdOn!.month != date.month ||
                          action.keys.first.createdOn!.year != date.year ||
                          action.keys.first.trangThai == false) {
                        context.read<ProviderModel>().listBills.remove(action);
                      }
                    }
                  })
                : setState(() {
                    date = DateTime.now();
                  });
          },
          child: Center(child: Text('${date.day}/${date.month}/${date.year}')),
        ),
      ),
    );
  }
}
