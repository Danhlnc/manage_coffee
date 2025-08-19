import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/model/spendmodel.dart';
import 'package:tscoffee/view/homepagewidget/doanhthupagewidget/listspend.dart';

class ChiScreen extends StatefulWidget {
  bool loading = false;

  ChiScreen({super.key});
  @override
  State<ChiScreen> createState() => _ChiScreenState();
}

Future addSpend(Map<String, dynamic> item) async {
  final response = await http.post(
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

TextEditingController thoiGian = TextEditingController();
TextEditingController tenChitieu = TextEditingController();

TextEditingController soTien = TextEditingController();

class _ChiScreenState extends State<ChiScreen> {
  @override
  Widget build(BuildContext context) {
    thoiGian.text = "${DateTime.now().day}/${DateTime.now().month}"
        "/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}";
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return Consumer<ProviderModel>(
                  builder: (context, providerModel, child) {
                return AlertDialog(
                  title: SizedBox(
                    width: 400,
                    height: 330,
                    child: Stack(
                      children: [
                        listSpend(),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: ElevatedButton(
                              child: const Text("Thêm chi tiêu"),
                              onPressed: () async {
                                spendmodel model = spendmodel();
                                await showDialog<double>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FractionallySizedBox(
                                        widthFactor: 0.5,
                                        heightFactor: 0.5,
                                        child: AlertDialog(
                                          title: SizedBox(
                                            width: 300,
                                            height: 70,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Card(
                                                        child: TextField(
                                                          controller: thoiGian,
                                                          onChanged: (value) {},
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                DateTime.now()
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Card(
                                                        child: TextField(
                                                          controller:
                                                              tenChitieu,
                                                          onChanged: (value) {},
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Tên chi tiêu',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Card(
                                                        child: TextField(
                                                          controller: soTien,
                                                          onChanged: (value) {},
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'Số tiền',
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(
                                                        double.tryParse(
                                                            0.toString())),
                                                child: const Text('Hủy')),
                                            ElevatedButton(
                                                onPressed: () => Navigator.of(
                                                        context)
                                                    .pop(double.tryParse(1
                                                        .toString())), // returns val
                                                child: const Text('OK')),
                                          ],
                                        ),
                                      );
                                    }).then((onValue) {
                                  if (onValue == 1) {
                                    EasyLoading.show(status: 'loading...');
                                    setState(() {
                                      widget.loading = true;
                                    });
                                    model.name = tenChitieu.text;
                                    model.count = int.parse(soTien.text);
                                    model.createdOn =
                                        DateFormat("dd/MM/yyyy HH:mm")
                                            .parse(thoiGian.text);
                                    var item = model.toJson();
                                    item.remove("_id");
                                    addSpend(item).then((onValue) {
                                      context
                                          .read<ProviderModel>()
                                          .fetchSpend()
                                          .then((onValue) {
                                        context
                                            .read<ProviderModel>()
                                            .update(onValue);
                                        context
                                            .read<ProviderModel>()
                                            .updateListTemp(dateTimeRange);
                                        context
                                            .read<ProviderModel>()
                                            .getTotalCount();
                                      });
                                      setState(() {
                                        widget.loading = false;
                                        EasyLoading.dismiss();
                                      });
                                    });
                                  }
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                );
              });
            });
      },
      child: Card(
        color: Colors.amber,
        child: Row(
          children: [
            const Text(
              ' Chi: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Builder(builder: (context) {
              return Consumer<ProviderModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return Text("${value.countTotal}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold));
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
