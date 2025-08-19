import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/providerModel.dart';

class QuanLyKhoScreen extends StatefulWidget {
  bool loading = false;
  QuanLyKhoScreen({super.key});

  @override
  State<QuanLyKhoScreen> createState() => _QuanLyKhoScreenState();
}

TextEditingController dateOne = TextEditingController();
TextEditingController monthOne = TextEditingController();
TextEditingController dateTwo = TextEditingController();
TextEditingController monthTwo = TextEditingController();
bool isChecktrangThai = true;

class _QuanLyKhoScreenState extends State<QuanLyKhoScreen> {
  @override
  Widget build(BuildContext context) {
    dateOne.text =
        "${dateTimeRange.start.day}/${dateTimeRange.start.month}/${dateTimeRange.start.year}";
    dateTwo.text =
        "${dateTimeRange.end.day}/${dateTimeRange.end.month}/${dateTimeRange.end.year}";
    if (WebStorage.instance.sessionId == "admin") {
      isChecktrangThai = false;
    }
    return Consumer<ProviderModel>(builder: (context, providerModel, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.blueGrey,
          // ignore: prefer_const_constructors
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Text(
                                  "Từ ngày:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                              flex: 1,
                              child: Card(
                                child: TextField(
                                    obscureText: false,
                                    controller: dateOne,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          '${dateTimeRange.start.day} / ${dateTimeRange.start.month}',
                                    )),
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: Text("Đến ngày:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                              flex: 1,
                              child: Card(
                                child: TextField(
                                    obscureText: false,
                                    controller: dateTwo,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          '${dateTimeRange.end.day} / ${dateTimeRange.end.month}',
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Card(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dateTimeRange = DateTimeRange(
                                          start: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateOne.text} 07:00"),
                                          end: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateTwo.text} 07:00"));
                                      context
                                          .read<ProviderModel>()
                                          .listBillsTotalDate = [
                                        ...context
                                            .read<ProviderModel>()
                                            .listBillsTotal
                                      ];
                                      var listProDate = [
                                        ...context
                                            .read<ProviderModel>()
                                            .listBillsTotalDate
                                      ];
                                      for (var action in listProDate) {
                                        if (action.keys.first.createdOn!
                                                .isBefore(dateTimeRange.end) &&
                                            action.keys.first.createdOn!
                                                .isAfter(dateTimeRange.start)) {
                                        } else {
                                          context
                                              .read<ProviderModel>()
                                              .listBillsTotalDate
                                              .remove(action);
                                        }
                                      }
                                      context
                                          .read<ProviderModel>()
                                          .updateListTemp(dateTimeRange);
                                      context
                                          .read<ProviderModel>()
                                          .getTotalCount();
                                    });
                                  },
                                  child: const Text("Tìm kiếm"),
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(""),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    count++;
                                    tongTien +=
                                        element.keys.first.tongTien as double;
                                  }
                                  return Text(
                                    "Tổng lượt khách: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.soLuongSac12k != 0) {
                                      count +=
                                          element.keys.first.soLuongSac12k!;
                                      tongTien += 15000;
                                    }
                                    if (element.keys.first.soLuongSac8k != 0) {
                                      count += element.keys.first.soLuongSac8k!;
                                      tongTien += 10000;
                                    }
                                    if (element
                                        .keys.first.listCombo.isNotEmpty) {
                                      count += 1;
                                      tongTien += 15000;
                                    }
                                  }
                                  return Text(
                                    "Số lượng sạc thường: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.soLuongSacNhanh !=
                                        0) {
                                      count +=
                                          element.keys.first.soLuongSacNhanh!;
                                      tongTien += 30000;
                                    }
                                  }
                                  return Text(
                                    "Số lượng sạc nhanh: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;

                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.soLuongNguNgay !=
                                        0) {
                                      count += element.keys.first.soLuongNguNgay
                                          as double;
                                      tongTien += 15000;
                                    }
                                    for (var element
                                        in element.keys.first.listCombo) {
                                      if (element.id == 1 || element.id == 4) {
                                        count += 1;
                                      }
                                    }
                                  }
                                  return Text(
                                    "Số lượng ngủ ngày: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.soLuongNguDem != 0) {
                                      count += element.keys.first.soLuongNguDem
                                          as double;
                                      tongTien += 30000;
                                    }
                                  }
                                  return Text(
                                    "Số lượng ngủ Đêm: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    for (var element
                                        in element.keys.first.listNuoc) {
                                      count += element.soLuongBan as double;
                                      tongTien += element.drinkmodel!.price! *
                                          (element.soLuongBan as double);
                                    }
                                    for (var element
                                        in element.keys.first.listCombo) {
                                      if (element.id != 5) {
                                        count += 1;
                                      }
                                    }
                                  }
                                  return Text(
                                    "Số lượng nước: $count Tổng tiền =$tongTien ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    for (var element
                                        in element.keys.first.listThuoc) {
                                      count += element.soLuongBan as double;
                                      tongTien += element.taboccomodel!.price! *
                                          (element.soLuongBan as double);
                                    }
                                  }
                                  return Text(
                                    "Số lượng thuốc: $count Tổng tiền =$tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.comGia != 0) {
                                      count += 1;
                                      tongTien += element.keys.first.comGia!;
                                    }
                                    if (element
                                        .keys.first.listCombo.isNotEmpty) {
                                      for (var action
                                          in element.keys.first.listCombo) {
                                        if (action.id == 2 || action.id == 4) {
                                          count += 1;

                                          tongTien += 30000;
                                        }
                                      }
                                    }
                                  }
                                  return Text(
                                    "Số lượng cơm: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Builder(builder: (context) {
                                  double count = 0;
                                  double tongTien = 0;
                                  for (var element in context
                                      .read<ProviderModel>()
                                      .listBillsTotalDate) {
                                    if (element.keys.first.giaGiatDo != 0 &&
                                        element.keys.first.bienSoXe !=
                                            "đổi tiền ck") {
                                      count += 1;
                                      tongTien += element.keys.first.giaGiatDo!;
                                    }
                                  }
                                  return Text(
                                    "Số lượng giặt đồ: $count    Tổng tiền = $tongTien",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Builder(builder: (context) {
                    return ListView.builder(
                        itemCount: providerModel.listAllNuoc.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          int count = 0;
                          for (var element
                              in providerModel.listBillsTotalDate) {
                            for (var action in element.keys.first.listNuoc) {
                              if (action.drinkmodel!.drinkName ==
                                  providerModel.listAllNuoc[index].drinkName) {
                                count += action.soLuongBan!;
                              }
                            }
                          }
                          return Card(
                            child: Center(
                              child: Text(
                                  "${providerModel.listAllNuoc[index].drinkName}: $count"),
                            ),
                          );
                        });
                  }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future updateDrink(Map<String, dynamic> item) async {
    final response = await http.put(
      Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/drinks'),
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
}
