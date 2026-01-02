import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/view/homepagewidget/doanhthupagewidget/chiscreen.dart';

import '../../../apps/globalvariables.dart';
import '../../../model/billmodel.dart';
import '../../loading.dart';
import '../addcustomer.dart';
import '../addpagewidgets/billlist.dart';
import 'package:date_format_field/date_format_field.dart';


// ignore: must_be_immutable
class Doanhthuscreen extends StatefulWidget {
  List<Map<Billmodel, Color>> listBillsTotal;

  List<Map<Billmodel, Color>> listBills = [];
  List<Map<Billmodel, Color>> listSearch = [];
  Function callBack;
  bool loading = false;
  Billmodel customer = Billmodel();
  Doanhthuscreen(
      {super.key, required this.listBillsTotal, required this.callBack});

  @override
  _DoanhthuscreenState createState() => _DoanhthuscreenState();
}

TextEditingController dateOne = TextEditingController();
TextEditingController monthOne = TextEditingController();
TextEditingController dateTwo = TextEditingController();
TextEditingController monthTwo = TextEditingController();

class _DoanhthuscreenState extends State<Doanhthuscreen> {
  callBack(String status) {
    if (mounted) {
      setState(() {});
    }
  }

  void setColor(Map<Billmodel, Color> bill) {
    for (var i = 0; i < widget.listBillsTotal.length; i++) {
      int test = widget.listBillsTotal[i].hashCode;
      int test2 = bill.hashCode;

      if (test == test2) {
        setState(() {
          Map<Billmodel, Color> item = widget.listBillsTotal[i];
          item[item.keys.first] = Colors.amber;
        });
      } else {
        setState(() {
          Map<Billmodel, Color> item = widget.listBillsTotal[i];
          item[item.keys.first] = Colors.white;
        });
      }
    }
  }

  bool isChecktrangThai = true;
  @override
  Widget build(BuildContext context) {
    dateOne
      ..text = "${dateTimeRange.start.day}" +
          "/${dateTimeRange.start.month}" +
          "/${dateTimeRange.start.year}";
    dateTwo
      ..text = "${dateTimeRange.end.day}" +
          "/${dateTimeRange.end.month}" +
          "/${dateTimeRange.end.year}";
    if (widget.listBills.isEmpty) {
      widget.listBills = [...context.read<ProviderModel>().listBillsTotalDate];
    }

    if (WebStorage.instance.sessionId == "admin") {
      isChecktrangThai = false;
    }
    return Consumer<ProviderModel>(builder: (context, providerModel, child) {
      return AbsorbPointer(
        absorbing: widget.loading,
        child: Container(
          color: Colors.blueGrey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: MediaQuery.of(context).size.width > 700
                    ? [
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: 
                            // TextField(
                            //     obscureText: false,
                            //     controller: dateOne,
                            //     onSubmitted: (value) {
                            //       try {
                            //         setState(() {
                            //           dateTimeRange = DateTimeRange(
                            //               start: DateFormat("dd/MM/yyyy HH:mm")
                            //                   .parse("${dateOne.text} 07:00"),
                            //               end: DateTime.parse(
                            //                   DateFormat('yyyy-MM-dd HH:mm')
                            //                       .format(DateTime(
                            //                           dateTimeRange.end.year,
                            //                           dateTimeRange.end.month,
                            //                           dateTimeRange.end.day,
                            //                           7))));
                            //         });
                            //       } catch (e) {}
                            //     },
                            //     onChanged: (value) {
                            //       try {
                            //         setState(() {
                            //           dateTimeRange = DateTimeRange(
                            //               start: DateFormat("dd/MM/yyyy HH:mm")
                            //                   .parse("${dateOne.text} 07:00"),
                            //               end: DateTime.parse(
                            //                   DateFormat('yyyy-MM-dd HH:mm')
                            //                       .format(DateTime(
                            //                           dateTimeRange.end.year,
                            //                           dateTimeRange.end.month,
                            //                           dateTimeRange.end.day,
                            //                           7))));
                            //         });
                            //       } catch (e) {}
                            //     },
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText:
                            //           '${dateTimeRange.start.day} / ${dateTimeRange.start.month}',
                            //     ))
                            DateFormatField(
                                type: DateFormatType.type2,
                                controller: dateOne,decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      '${dateTimeRange.start.day} / ${dateTimeRange.start.month}',
                                ),
                                onComplete: (date) {
                                     try {
                                    setState(() {
                                      dateTimeRange = DateTimeRange(
                                          start: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateOne.text} 07:00"),
                                          end: DateTime.parse(
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(DateTime(
                                                      dateTimeRange.end.year,
                                                      dateTimeRange.end.month,
                                                      dateTimeRange.end.day,
                                                      7))));
                                    });
                                  } catch (e) {}
                                },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: DateFormatField(
                                type: DateFormatType.type2,
                                controller: dateTwo,decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      '${dateTimeRange.end.day} / ${dateTimeRange.start.month}',
                                ),
                                onComplete: (date) {
                                    try {
                                    setState(() {
                                      dateTimeRange = DateTimeRange(
                                          start: DateTime.parse(
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(DateTime(
                                                      dateTimeRange.start.year,
                                                      dateTimeRange.start.month,
                                                      dateTimeRange.start.day,
                                                      7))),
                                          end: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateTwo.text} 07:00"));
                                    });
                                  } catch (e) {}
                                },
                            ),
                            // TextField(
                            //     obscureText: false,
                            //     controller: dateTwo,
                            //     onSubmitted: (value) {
                            //       try {
                            //         setState(() {
                            //           dateTimeRange = DateTimeRange(
                            //               start: DateTime.parse(
                            //                   DateFormat('yyyy-MM-dd HH:mm')
                            //                       .format(DateTime(
                            //                           dateTimeRange.start.year,
                            //                           dateTimeRange.start.month,
                            //                           dateTimeRange.start.day,
                            //                           7))),
                            //               end: DateFormat("dd/MM/yyyy HH:mm")
                            //                   .parse("${dateTwo.text} 07:00"));
                            //         });
                            //       } catch (e) {}
                            //     },
                            //     onChanged: (value) {
                            //       try {
                            //         setState(() {
                            //           dateTimeRange = DateTimeRange(
                            //               start: DateTime.parse(
                            //                   DateFormat('yyyy-MM-dd HH:mm')
                            //                       .format(DateTime(
                            //                           dateTimeRange.start.year,
                            //                           dateTimeRange.start.month,
                            //                           dateTimeRange.start.day,
                            //                           7))),
                            //               end: DateFormat("dd/MM/yyyy HH:mm")
                            //                   .parse("${dateTwo.text} 07:00"));
                            //         });
                            //       } catch (e) {}
                            //     },
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText:
                            //           '${dateTimeRange.end.day} / ${dateTimeRange.end.month}',
                            //     )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<ProviderModel>()
                                    .updateloadData(true);
                                dateTimeRange = DateTimeRange(
                                    start: DateFormat("dd/MM/yyyy HH:mm")
                                        .parse("${dateOne.text} 07:00"),
                                    end: DateFormat("dd/MM/yyyy HH:mm")
                                        .parse("${dateTwo.text} 07:00"));
                                context.read<ProviderModel>().loadDataTotal();
                              },
                              child: const Text("Tìm kiếm"),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 6,
                          child: Text(""),
                        )
                      ]
                    : [
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: DateFormatField(
                                type: DateFormatType.type2,
                                controller: dateOne,decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      '${dateTimeRange.start.day} / ${dateTimeRange.start.month}',
                                ),
                                onComplete: (date) {
                                     try {
                                    setState(() {
                                      dateTimeRange = DateTimeRange(
                                          start: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateOne.text} 07:00"),
                                          end: DateTime.parse(
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(DateTime(
                                                      dateTimeRange.end.year,
                                                      dateTimeRange.end.month,
                                                      dateTimeRange.end.day,
                                                      7))));
                                    });
                                  } catch (e) {}
                                },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: DateFormatField(
                                type: DateFormatType.type2,
                                controller: dateTwo,decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      '${dateTimeRange.end.day} / ${dateTimeRange.start.month}',
                                ),
                                onComplete: (date) {
                                    try {
                                    setState(() {
                                      dateTimeRange = DateTimeRange(
                                          start: DateTime.parse(
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(DateTime(
                                                      dateTimeRange.start.year,
                                                      dateTimeRange.start.month,
                                                      dateTimeRange.start.day,
                                                      7))),
                                          end: DateFormat("dd/MM/yyyy HH:mm")
                                              .parse("${dateTwo.text} 07:00"));
                                    });
                                  } catch (e) {}
                                },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: TextButton(
                              onPressed: () {
                                print("test");
                                context
                                    .read<ProviderModel>()
                                    .updateloadData(true);
                                dateTimeRange = DateTimeRange(
                                    start: DateFormat("dd/MM/yyyy HH:mm")
                                        .parse("${dateOne.text} 07:00"),
                                    end: DateFormat("dd/MM/yyyy HH:mm")
                                        .parse("${dateTwo.text} 07:00"));
                                context
                                    .read<ProviderModel>()
                                    .fetch()
                                    .then((onValue) {
                                  context
                                      .read<ProviderModel>()
                                      .listNuoc
                                      .clear();
                                  context
                                      .read<ProviderModel>()
                                      .listThuoc
                                      .clear();
                                  context
                                      .read<ProviderModel>()
                                      .listBillsTotal
                                      .clear();
                                  context
                                      .read<ProviderModel>()
                                      .listBills
                                      .clear();
                                  for (var item in onValue) {
                                    Map<Billmodel, Color> newmap = {
                                      item: Colors.white
                                    };
                                    context
                                        .read<ProviderModel>()
                                        .listBillsTotal
                                        .add(newmap);
                                  }
                                  context
                                      .read<ProviderModel>()
                                      .listBillsTotal
                                      .sort((b, a) => a.keys.first.createdOn!
                                          .compareTo(b.keys.first.createdOn
                                              as DateTime));
                                  context.read<ProviderModel>().listBills = [
                                    ...context
                                        .read<ProviderModel>()
                                        .listBillsTotal
                                  ];
                                  var listPro = [
                                    ...context.read<ProviderModel>().listBills
                                  ];
                                  for (var action in listPro) {
                                    if (DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(action
                                                    .keys.first.createdOn
                                                    .toString())) !=
                                            DateFormat('yyyy-MM-dd')
                                                .format(date) ||
                                        action.keys.first.trangThai == false) {
                                      context
                                          .read<ProviderModel>()
                                          .listBills
                                          .remove(action);
                                    }
                                  }

                                  context.read<ProviderModel>().listBills.sort(
                                      (b, a) => a.keys.first.modifyOn!
                                          .compareTo(b.keys.first.modifyOn
                                              as DateTime));

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
                                      .updateloadData(false);
                                });
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
                                          .isAfter(dateTimeRange.start) &&
                                      action.keys.first.bienSoXe!
                                          .toUpperCase()
                                          .contains(context
                                              .read<ProviderModel>()
                                              .searchController
                                              .text
                                              .toUpperCase()) &&
                                      (context.read<ProviderModel>().checkTT ==
                                              false
                                          ? action.keys.first.trangThai ==
                                                  false ||
                                              action.keys.first.trangThai ==
                                                  true
                                          : action.keys.first.trangThai ==
                                              true)) {
                                  } else {
                                    context
                                        .read<ProviderModel>()
                                        .listBillsTotalDate
                                        .remove(action);
                                  }
                                }
                                context
                                    .read<ProviderModel>()
                                    .updatelistBillsTotalDate(context
                                        .read<ProviderModel>()
                                        .listBillsTotalDate);
                                context
                                    .read<ProviderModel>()
                                    .updateListTemp(dateTimeRange);
                                context.read<ProviderModel>().getTotalCount();
                              },
                              child: const Text("Tìm kiếm"),
                            ),
                          ),
                        ),
                      
                      ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Card(
                        child: TextField(
                          controller:
                              context.read<ProviderModel>().searchController,
                          obscureText: false,
                          onChanged: (value) {
                            context.read<ProviderModel>().listBillsTotalDate = [
                              ...context.read<ProviderModel>().listBillsTotal
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
                                      .isAfter(dateTimeRange.start) &&
                                  action.keys.first.bienSoXe!
                                      .toUpperCase()
                                      .contains(context
                                          .read<ProviderModel>()
                                          .searchController
                                          .text
                                          .toUpperCase()) &&
                                  (context.read<ProviderModel>().checkTT ==
                                          false
                                      ? action.keys.first.trangThai == false ||
                                          action.keys.first.trangThai == true
                                      : action.keys.first.trangThai == true)) {
                              } else {
                                context
                                    .read<ProviderModel>()
                                    .listBillsTotalDate
                                    .remove(action);
                              }
                            }
                            context
                                .read<ProviderModel>()
                                .updatelistBillsTotalDate(context
                                    .read<ProviderModel>()
                                    .listBillsTotalDate);
                            context
                                .read<ProviderModel>()
                                .updateListTemp(dateTimeRange);
                            context.read<ProviderModel>().getTotalCount();
                          },
                          decoration: const InputDecoration(
                            hintText: "Tìm kiếm",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            const Text(
                              ' Chưa TT',
                              style: TextStyle(color: Colors.white),
                            ),
                            AbsorbPointer(
                              absorbing: !widget.customer.trangThai!,
                              child: Checkbox(
                                  value: providerModel.checkTT,
                                  onChanged: (value) {
                                    if (providerModel.checkTT == true) {
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
                                                .isAfter(dateTimeRange.start) &&
                                            action.keys.first.bienSoXe!
                                                .toUpperCase()
                                                .contains(context
                                                    .read<ProviderModel>()
                                                    .searchController
                                                    .text
                                                    .toUpperCase())) {
                                        } else {
                                          context
                                              .read<ProviderModel>()
                                              .listBillsTotalDate
                                              .remove(action);
                                        }
                                      }
                                      context.read<ProviderModel>().checkTT =
                                          false;
                                      context
                                          .read<ProviderModel>()
                                          .updatecheckTT(context
                                              .read<ProviderModel>()
                                              .checkTT);
                                      context
                                          .read<ProviderModel>()
                                          .updatelistBillsTotalDate(context
                                              .read<ProviderModel>()
                                              .listBillsTotalDate);
                                      context
                                          .read<ProviderModel>()
                                          .updateListTemp(dateTimeRange);
                                      context
                                          .read<ProviderModel>()
                                          .getTotalCount();
                                    } else {
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
                                                .isAfter(dateTimeRange.start) &&
                                            action.keys.first.bienSoXe!
                                                .toUpperCase()
                                                .contains(context
                                                    .read<ProviderModel>()
                                                    .searchController
                                                    .text
                                                    .toUpperCase()) &&
                                            (action.keys.first.trangThai ==
                                                true)) {
                                        } else {
                                          context
                                              .read<ProviderModel>()
                                              .listBillsTotalDate
                                              .remove(action);
                                        }
                                      }
                                      context.read<ProviderModel>().checkTT =
                                          true;
                                      context
                                          .read<ProviderModel>()
                                          .updatelistBillsTotalDate(context
                                              .read<ProviderModel>()
                                              .listBillsTotalDate);
                                      context
                                          .read<ProviderModel>()
                                          .updateListTemp(dateTimeRange);
                                      context
                                          .read<ProviderModel>()
                                          .getTotalCount();
                                      setState(() {});
                                    }
                                  }),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Card(
                      color: Colors.redAccent,
                      child: Row(
                        children: [
                          const Text(
                            ' CThu: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Builder(builder: (context) {
                            return Consumer<ProviderModel>(
                                builder: (context, providerModel, child) {
                              double total = 0;
                              for (var element
                                  in providerModel.listBillsTotalDate) {
                                if (element.keys.first.trangThai == true) {
                                  total += double.parse(element
                                      .keys.first.tongTien!
                                      .toStringAsFixed(0));
                                }
                              }
                              return Text(
                                total.toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              );
                            });
                          }),
                          const Text(
                            ' CK: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Builder(builder: (context) {
                            return Consumer<ProviderModel>(
                                builder: (context, providerModel, child) {
                              double total = 0;
                              for (var element
                                  in providerModel.listBillsTotalDate) {
                                if (element.keys.first.chuyenKhoan == true) {
                                  total += double.parse(element
                                      .keys.first.tongTien!
                                      .toStringAsFixed(0));
                                }
                              }
                              return Text(
                                total.toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              );
                            });
                          })
                        ],
                      ),
                    )),
                    Expanded(
                      child: ChiScreen(),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Card(
                    color: Colors.blue,
                    child: Row(
                      children: [
                        const Text(
                          ' Tổng: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Builder(builder: (context) {
                          return Consumer<ProviderModel>(
                              builder: (context, providerModel, child) {
                            double total = 0;
                            for (var element
                                in providerModel.listBillsTotalDate) {
                              if (element.keys.first.bienSoXe !=
                                  "đổi tiền ck") {
                                total += double.parse(element
                                    .keys.first.tongTien!
                                    .toStringAsFixed(0));
                              }
                            }
                            return Text(total.toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          });
                        }),
                      ],
                    ),
                  )),
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                      child: Row(
                        children: [
                          const Text(
                            ' Còn lại: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Builder(builder: (context) {
                            return Consumer<ProviderModel>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                double totalCThu = 0;
                                for (var element in value.listBillsTotalDate) {
                                  if (element.keys.first.trangThai == true) {
                                    totalCThu += double.parse(element
                                        .keys.first.tongTien!
                                        .toString());
                                  }
                                }
                                double totalCK = 0;
                                for (var element in value.listBillsTotalDate) {
                                  if (element.keys.first.chuyenKhoan == true) {
                                    totalCK += double.parse(element
                                        .keys.first.tongTien!
                                        .toString());
                                  }
                                }
                                double total = 0;
                                for (var element in value.listBillsTotalDate) {
                                  if (element.keys.first.bienSoXe !=
                                      "đổi tiền ck") {
                                    total += double.parse(element
                                        .keys.first.tongTien!
                                        .toStringAsFixed(0));
                                  }
                                }
                                double totalSpend = 0;
                                for (var element in value.listSpend) {
                                  if (element.createdOn!
                                          .isBefore(dateTimeRange.end) &&
                                      element.createdOn!
                                          .isAfter(dateTimeRange.start)) {
                                    totalSpend += element.count!.toDouble();
                                  }
                                }
                                double totalClai =
                                    total - totalCThu - totalCK - totalSpend;
                                return Text("$totalClai",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold));
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  child: Stack(children: [
                    //gridview doanh thu
                    Builder(builder: (context) {
                      return Consumer<ProviderModel>(
                          builder: (context, providerModel, child) {
                        return context.read<ProviderModel>().loadData == true
                            ? const Loading()
                            : MediaQuery.of(context).size.width < 700
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 4),
                                    itemCount:
                                        providerModel.listBillsTotalDate.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Container(
                                        margin: const EdgeInsets.all(1),
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: (providerModel
                                                      .listBillsTotalDate[index]
                                                      .keys
                                                      .first
                                                      .trangThai ==
                                                  true
                                              ? Colors.red
                                              : Colors.blue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // if you need this
                                            side: const BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          color: providerModel
                                              .listBillsTotalDate[index]
                                              .values
                                              .first,
                                          child: InkWell(
                                              onTap: () {
                                                setColor(providerModel
                                                    .listBillsTotalDate[index]);
                                              },
                                              onDoubleTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddCustomer(
                                                              customer:
                                                                  providerModel
                                                                      .listBillsTotalDate[
                                                                          index]
                                                                      .keys
                                                                      .first,
                                                              callBack:
                                                                  callBack,
                                                            ))).then((item) {});
                                              },
                                              child: Bills(
                                                  Bill: providerModel
                                                          .listBillsTotalDate[
                                                      index])),
                                        ),
                                      );
                                    })
                                : MediaQuery.of(context).size.width < 1400
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8,
                                                mainAxisSpacing: 4),
                                        itemCount: providerModel
                                            .listBillsTotalDate.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(3),
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: (providerModel
                                                          .listBillsTotalDate[
                                                              index]
                                                          .keys
                                                          .first
                                                          .trangThai ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.blue),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // if you need this
                                                side: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              color: providerModel
                                                  .listBillsTotalDate[index]
                                                  .values
                                                  .first,
                                              child: InkWell(
                                                  onTap: () {
                                                    setColor(providerModel
                                                            .listBillsTotalDate[
                                                        index]);
                                                  },
                                                  onDoubleTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddCustomer(
                                                                      customer: providerModel
                                                                          .listBillsTotalDate[
                                                                              index]
                                                                          .keys
                                                                          .first,
                                                                      callBack:
                                                                          callBack,
                                                                    ))).then(
                                                        (item) {});
                                                  },
                                                  child: Bills(
                                                      Bill: providerModel
                                                              .listBillsTotalDate[
                                                          index])),
                                            ),
                                          );
                                        })
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 12,
                                                mainAxisSpacing: 4),
                                        itemCount: providerModel
                                            .listBillsTotalDate.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(3),
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: (providerModel
                                                          .listBillsTotalDate[
                                                              index]
                                                          .keys
                                                          .first
                                                          .trangThai ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.blue),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // if you need this
                                                side: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              color: providerModel
                                                  .listBillsTotalDate[index]
                                                  .values
                                                  .first,
                                              child: InkWell(
                                                  onTap: () {
                                                    setColor(providerModel
                                                            .listBillsTotalDate[
                                                        index]);
                                                  },
                                                  onDoubleTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddCustomer(
                                                                      customer: providerModel
                                                                          .listBillsTotalDate[
                                                                              index]
                                                                          .keys
                                                                          .first,
                                                                      callBack:
                                                                          callBack,
                                                                    ))).then(
                                                        (item) {});
                                                  },
                                                  child: Bills(
                                                      Bill: providerModel
                                                              .listBillsTotalDate[
                                                          index])),
                                            ),
                                          );
                                        });
                      });
                    }),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: FloatingActionButton.extended(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCustomer(
                                      customer: Billmodel(),
                                      callBack: callBack))).then((item) {
                            if (item == null) {
                              context.read<ProviderModel>().listNuoc = [];
                              context.read<ProviderModel>().listThuoc = [];
                            }
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Thêm khách hàng'),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
