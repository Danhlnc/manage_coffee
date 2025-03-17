import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tscoffee/apps/globalvariables.dart';

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

class _QuanLyKhoScreenState extends State<QuanLyKhoScreen> {
  @override
  Widget build(BuildContext context) {
    dateOne.text =
        "${dateTimeRange.start.day}/${dateTimeRange.start.month}/${dateTimeRange.start.year}";
    dateTwo.text =
        "${dateTimeRange.end.day}/${dateTimeRange.end.month}/${dateTimeRange.end.year}";
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.blueGrey,
            // ignore: prefer_const_constructors
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                          widthFactor: 1, //20% width
                          heightFactor: 1, //50% height
                          alignment: FractionalOffset.center,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
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
                                                  start: DateFormat(
                                                          "dd/MM/yyyy HH:mm")
                                                      .parse(
                                                          "${dateOne.text} 07:00"),
                                                  end: DateFormat(
                                                          "dd/MM/yyyy HH:mm")
                                                      .parse(
                                                          "${dateTwo.text} 07:00"));
                                              listBillsTotalDate = [
                                                ...listBillsTotal
                                              ];
                                              var listProDate = [
                                                ...listBillsTotalDate
                                              ];
                                              for (var action in listProDate) {
                                                if (action.keys.first.createdOn!
                                                        .isBefore(dateTimeRange
                                                            .end) &&
                                                    action.keys.first.createdOn!
                                                        .isAfter(dateTimeRange
                                                            .start)) {
                                                } else {
                                                  listBillsTotalDate
                                                      .remove(action);
                                                }
                                              }
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element
                                                    .keys.first.soLuongSac12k !=
                                                0) {
                                              count += element
                                                  .keys.first.soLuongSac12k!;
                                              tongTien += 15000;
                                            }
                                            if (element
                                                    .keys.first.soLuongSac8k !=
                                                0) {
                                              count += element
                                                  .keys.first.soLuongSac8k!;
                                              tongTien += 10000;
                                            }
                                            if (element.keys.first.listCombo
                                                .isNotEmpty) {
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element.keys.first
                                                    .soLuongSacNhanh !=
                                                0) {
                                              count += element
                                                  .keys.first.soLuongSacNhanh!;
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;

                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element.keys.first
                                                    .soLuongNguNgay !=
                                                0) {
                                              count += element.keys.first
                                                  .soLuongNguNgay as double;
                                              tongTien += 15000;
                                            }
                                            for (var element in element
                                                .keys.first.listCombo) {
                                              if (element.id == 1 ||
                                                  element.id == 4) {
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element
                                                    .keys.first.soLuongNguDem !=
                                                0) {
                                              count += element.keys.first
                                                  .soLuongNguDem as double;
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            for (var element in element
                                                .keys.first.listNuoc) {
                                              count +=
                                                  element.soLuongBan as double;
                                            }
                                            for (var element in element
                                                .keys.first.listCombo) {
                                              if (element.id != 5) {
                                                count += 1;
                                              }
                                            }
                                          }
                                          return Text(
                                            "Số lượng nước: $count",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            for (var element in element
                                                .keys.first.listThuoc) {
                                              count +=
                                                  element.soLuongBan as double;
                                            }
                                          }
                                          return Text(
                                            "Số lượng thuốc: $count",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element.keys.first.comGia !=
                                                0) {
                                              count += 1;
                                              tongTien +=
                                                  element.keys.first.comGia!;
                                            }
                                            if (element.keys.first.listCombo
                                                .isNotEmpty) {
                                              for (var action in element
                                                  .keys.first.listCombo) {
                                                if (action.id == 2 ||
                                                    action.id == 4) {
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Builder(builder: (context) {
                                          double count = 0;
                                          double tongTien = 0;
                                          for (var element
                                              in listBillsTotalDate) {
                                            if (element.keys.first.giaGiatDo !=
                                                0) {
                                              count += 1;
                                              tongTien +=
                                                  element.keys.first.giaGiatDo!;
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
                          ))),
                  Expanded(
                      flex: 2,
                      child: FractionallySizedBox(
                          widthFactor: 1, ////50% height
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: ListView.builder(
                                itemCount: listAllNuocSearch.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Card(
                                            child: SizedBox(
                                              height: 30,
                                              child: Center(
                                                child: Text(
                                                    "${listAllNuocSearch[index].drinkName} : ${listAllNuocSearch[index].countStore}"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Card(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: TextField(
                                                textAlign: TextAlign.center,
                                                onChanged: (value) {
                                                  try {
                                                    if (int.parse(value) >=
                                                        int.parse(
                                                            listAllNuoc[index]
                                                                .countStore
                                                                .toString())) {
                                                      setState(() {
                                                        listAllNuoc[index]
                                                                .countStore =
                                                            int.parse(value);
                                                      });
                                                    }
                                                  } catch (e) {}
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      '${listAllNuoc[index].countStore}',
                                                )),
                                          ),
                                        ),
                                      ))
                                    ],
                                  );
                                }),
                          ))),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              int count = listAllNuoc.length;
              EasyLoading.show(status: 'loading...');
              setState(() {
                widget.loading = true;
              });
              for (var element in listAllNuoc) {
                updateDrink(element.toJson()).then((onValue) {
                  setState(() {
                    count--;
                    if (count == 0) {
                      setState(() {
                        widget.loading = false;
                      });
                      EasyLoading.dismiss();
                    }
                  });
                });
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Nhập hàng'),
          ),
        )
      ]),
    );
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
