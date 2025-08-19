import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/providerModel.dart';

class listSpend extends StatefulWidget {
  bool loading = false;
  listSpend({super.key});

  @override
  State<listSpend> createState() => _listSpendState();
}

class _listSpendState extends State<listSpend> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderModel>(builder: (context, providerModel, child) {
      return ListView.builder(
          itemCount: providerModel.listSpendTemp.length,
          itemBuilder: (BuildContext ctx, int index) {
            var item = providerModel.listSpendTemp[index];
            var date = "${item.createdOn!.day}/${item.createdOn!.month}";
            var text = "$date ${item.name}:${item.count}";
            return Card(
                child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text(text),
                  IconButton(
                      onPressed: () {
                        EasyLoading.show(status: 'loading...');
                        setState(() {
                          widget.loading = true;
                        });
                        deleteSpend(item.toJson()).then((onValue) {
                          providerModel.fetchSpend().then((onValue) {
                            providerModel.update(onValue);
                            providerModel.updateListTemp(dateTimeRange);
                            providerModel.getTotalCount();
                          });
                          setState(() {
                            widget.loading = false;
                            EasyLoading.dismiss();
                          });
                        });
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ));
          });
    });
  }
}

Future deleteSpend(Map<String, dynamic> item) async {
  final response = await http.delete(
    Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/spends'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(item),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    date = DateTime.now();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
