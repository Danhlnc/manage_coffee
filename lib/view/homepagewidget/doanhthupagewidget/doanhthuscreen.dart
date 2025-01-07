import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/model/spendmodel.dart';

import '../../../apps/globalvariables.dart';
import '../../../model/billmodel.dart';
import '../../loading.dart';
import '../addcustomer.dart';
import '../addpagewidgets/billlist.dart';
import 'datetimeDoanhThu.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Doanhthuscreen extends StatefulWidget {
  List<Map<Billmodel, Color>> listBillsTotal;

  List<Map<Billmodel, Color>> listBills = [];
  List<Map<Billmodel, Color>> listSearch = [];
  Function callBack;
  Billmodel customer = Billmodel();
  Doanhthuscreen(
      {super.key, required this.listBillsTotal, required this.callBack});

  @override
  _DoanhthuscreenState createState() => _DoanhthuscreenState();
}

class _DoanhthuscreenState extends State<Doanhthuscreen> {
  callBack(String status) {
    widget.callBack(status);
    setState(() {});
  }

  final TextEditingController searchController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    if (widget.listBills.isEmpty) {
      widget.listBills = [...listBillsTotalDate];
    }
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(flex: 2, child: DatetimeDoanhThu(callBack: callBack)),
                Expanded(
                  flex: 4,
                  child: Card(
                    child: TextField(
                      controller: searchController,
                      obscureText: false,
                      onChanged: (value) {
                        if (checkTT) {
                          if (value != "") {
                            listBillsTotalDate = [...listBillsTotal];
                            var listProDate = [...listBillsTotalDate];
                            for (var action in listProDate) {
                              if (action.keys.first.createdOn!
                                      .isBefore(dateTimeRange.end) &&
                                  action.keys.first.createdOn!
                                      .isAfter(dateTimeRange.start) &&
                                  action.keys.first.trangThai == true) {
                              } else {
                                listBillsTotalDate.remove(action);
                              }
                            }
                            listBillsTotalSearch.clear();
                            for (var action in listBillsTotalDate) {
                              if (action.keys.first.bienSoXe!
                                  .toUpperCase()
                                  .contains(value.toUpperCase())) {
                                listBillsTotalSearch.add(action);
                              }
                            }
                            listBillsTotalDate = [...listBillsTotalSearch];
                            callBack("");
                          } else {
                            listBillsTotalDate = [...listBillsTotal];
                            var listProDate = [...listBillsTotalDate];
                            for (var action in listProDate) {
                              if (action.keys.first.createdOn!
                                      .isBefore(dateTimeRange.end) &&
                                  action.keys.first.createdOn!
                                      .isAfter(dateTimeRange.start) &&
                                  action.keys.first.trangThai == true) {
                              } else {
                                listBillsTotalDate.remove(action);
                              }
                            }
                            callBack("");
                          }
                        } else {
                          if (value != "") {
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
                            listBillsTotalSearch.clear();
                            for (var action in listBillsTotalDate) {
                              if (action.keys.first.bienSoXe!
                                  .toUpperCase()
                                  .contains(value.toUpperCase())) {
                                listBillsTotalSearch.add(action);
                              }
                            }
                            listBillsTotalDate = [...listBillsTotalSearch];
                            callBack("");
                          } else {
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
                            callBack("");
                          }
                        }
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
                              value: checkTT,
                              onChanged: (value) {
                                if (searchController.text != "") {
                                  if (checkTT == false) {
                                    listBillsTotalDate = [
                                      ...listBillsTotalSearch
                                    ];
                                    var listProDate = [...listBillsTotalDate];
                                    for (var action in listProDate) {
                                      if (action.keys.first.createdOn!
                                              .isBefore(dateTimeRange.end) &&
                                          action.keys.first.createdOn!
                                              .isAfter(dateTimeRange.start) &&
                                          action.keys.first.trangThai == true) {
                                      } else {
                                        listBillsTotalDate.remove(action);
                                      }
                                    }
                                    checkTT = !checkTT;
                                  } else {
                                    listBillsTotalDate = [
                                      ...listBillsTotalSearch
                                    ];
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
                                    checkTT = !checkTT;
                                  }
                                } else if (searchController.text == "") {
                                  if (checkTT == false) {
                                    listBillsTotalDate = [...listBillsTotal];
                                    var listProDate = [...listBillsTotalDate];
                                    for (var action in listProDate) {
                                      if (action.keys.first.createdOn!
                                              .isBefore(dateTimeRange.end) &&
                                          action.keys.first.createdOn!
                                              .isAfter(dateTimeRange.start) &&
                                          action.keys.first.trangThai == true) {
                                      } else {
                                        listBillsTotalDate.remove(action);
                                      }
                                    }
                                    checkTT = !checkTT;
                                  } else {
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
                                    checkTT = !checkTT;
                                  }
                                }
                                callBack("");
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Builder(builder: (context) {
                        double total = 0;
                        for (var element in listBillsTotalDate) {
                          if (element.keys.first.trangThai == true) {
                            total += double.parse(element.keys.first.tongTien!
                                .toStringAsFixed(0));
                          }
                        }
                        return Text(
                          total.toStringAsFixed(0),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                )),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Consumer<ProviderModel>(
                                builder: (context, providerModel, child) {
                              return FractionallySizedBox(
                                  widthFactor: 1,
                                  heightFactor: 1,
                                  child: AlertDialog(
                                    title: SizedBox(
                                      width: 400,
                                      height: 330,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              child: ListView.builder(
                                            itemCount: providerModel
                                                .listSpendTemp!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                title: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Card(
                                                        child: Text("    " +
                                                            "${providerModel.listSpendTemp![index].createdOn!.day}" +
                                                            "/"
                                                                "${providerModel.listSpendTemp![index].createdOn!.month}" +
                                                            " " +
                                                            "${providerModel.listSpendTemp![index].name}" +
                                                            ": " +
                                                            "${providerModel.listSpendTemp![index].count}"),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        icon: const Icon(Icons
                                                            .delete_forever_outlined),
                                                        onPressed: () {
                                                          deleteSpend(
                                                                  providerModel
                                                                      .listSpend![
                                                                          index]
                                                                      .toJson())
                                                              .then((onValue) {
                                                            providerModel
                                                                .removeSpend(
                                                                    index);
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: ElevatedButton(
                                                child:
                                                    const Text("Thêm chi tiêu"),
                                                onPressed: () async {
                                                  TextEditingController
                                                      tenChitieu =
                                                      new TextEditingController();
                                                  TextEditingController soTien =
                                                      new TextEditingController();
                                                  spendmodel model =
                                                      spendmodel();
                                                  await showDialog<double>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return FractionallySizedBox(
                                                          widthFactor: 0.5,
                                                          heightFactor: 0.5,
                                                          child: AlertDialog(
                                                            title: SizedBox(
                                                              width: 300,
                                                              height: 70,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Card(
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                tenChitieu,
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                              hintText: 'Tên chi tiêu',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Card(
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                soTien,
                                                                            onChanged:
                                                                                (value) {},
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
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
                                                                  onPressed: () => Navigator.of(
                                                                          context)
                                                                      .pop(double
                                                                          .tryParse(0
                                                                              .toString())),
                                                                  child:
                                                                      const Text(
                                                                          'Hủy')),
                                                              ElevatedButton(
                                                                  onPressed: () => Navigator.of(
                                                                          context)
                                                                      .pop(double
                                                                          .tryParse(1
                                                                              .toString())), // returns val
                                                                  child:
                                                                      const Text(
                                                                          'OK')),
                                                            ],
                                                          ),
                                                        );
                                                      }).then((onValue) {
                                                    if (onValue == 1) {
                                                      model.name =
                                                          tenChitieu.text;
                                                      model.count = int.parse(
                                                          soTien.text);

                                                      var item = model.toJson();
                                                      item.remove("_id");
                                                      addSpend(item)
                                                          .then((onValue) {
                                                        providerModel.listSpend!
                                                            .add(model);
                                                        providerModel.update(
                                                            providerModel
                                                                .listSpend);
                                                      });
                                                    }
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                          });
                    },
                    child: Card(
                      color: Colors.amber,
                      child: Row(
                        children: [
                          const Text(
                            ' Chi: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Builder(builder: (context) {
                            return Consumer<ProviderModel>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return Text("${value.countTotal}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold));
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Builder(builder: (context) {
                      double total = 0;
                      for (var element in listBillsTotalDate) {
                        total += double.parse(
                            element.keys.first.tongTien!.toStringAsFixed(0));
                      }
                      return Text(total.toStringAsFixed(0),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold));
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
                            for (var element in listBillsTotalDate) {
                              if (element.keys.first.trangThai == true) {
                                totalCThu += double.parse(element
                                    .keys.first.tongTien!
                                    .toStringAsFixed(0));
                              }
                            }
                            double total = 0;
                            for (var element in listBillsTotalDate) {
                              total += double.parse(element.keys.first.tongTien!
                                  .toStringAsFixed(0));
                            }
                            double totalClai = total -
                                totalCThu -
                                double.parse(value.countTotal.toString());
                            return Text("${totalClai}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
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
                  return loadData == true
                      ? const Loading()
                      : NotificationListener(
                          child: SizeChangedLayoutNotifier(
                            child: MediaQuery.of(context).size.width < 700
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 4),
                                    itemCount: widget.listBills.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Container(
                                        margin: const EdgeInsets.all(1),
                                        child: Card(
                                          elevation: 8,
                                          shadowColor: (widget.listBills[index]
                                                      .keys.first.trangThai ==
                                                  true
                                              ? Colors.red
                                              : Colors.blue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // if you need this
                                            side: BorderSide(
                                              color: (widget
                                                          .listBills[index]
                                                          .keys
                                                          .first
                                                          .trangThai ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.blue),
                                              width: 2,
                                            ),
                                          ),
                                          color: widget
                                              .listBills[index].values.first,
                                          child: InkWell(
                                              onTap: () {
                                                setColor(
                                                    widget.listBills[index]);
                                              },
                                              onDoubleTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddCustomer(
                                                              customer: widget
                                                                  .listBills[
                                                                      index]
                                                                  .keys
                                                                  .first,
                                                              callBack:
                                                                  callBack,
                                                            ))).then((item) {
                                                  setState(() {
                                                    listBills;
                                                  });
                                                });
                                              },
                                              child: Bills(
                                                  Bill:
                                                      widget.listBills[index])),
                                        ),
                                      );
                                    })
                                : MediaQuery.of(context).size.width < 1400
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8,
                                                mainAxisSpacing: 4),
                                        itemCount: widget.listBills.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(3),
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: (widget
                                                          .listBills[index]
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
                                                side: BorderSide(
                                                  color: (widget
                                                              .listBills[index]
                                                              .keys
                                                              .first
                                                              .trangThai ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.blue),
                                                  width: 2,
                                                ),
                                              ),
                                              color: widget.listBills[index]
                                                  .values.first,
                                              child: InkWell(
                                                  onTap: () {
                                                    setColor(widget
                                                        .listBills[index]);
                                                  },
                                                  onDoubleTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddCustomer(
                                                                      customer: widget
                                                                          .listBills[
                                                                              index]
                                                                          .keys
                                                                          .first,
                                                                      callBack:
                                                                          callBack,
                                                                    ))).then(
                                                        (item) {
                                                      setState(() {
                                                        listBills;
                                                      });
                                                    });
                                                  },
                                                  child: Bills(
                                                      Bill: widget
                                                          .listBills[index])),
                                            ),
                                          );
                                        })
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 16,
                                                mainAxisSpacing: 4),
                                        itemCount: widget.listBills.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(3),
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: (widget
                                                          .listBills[index]
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
                                                side: BorderSide(
                                                  color: (widget
                                                              .listBills[index]
                                                              .keys
                                                              .first
                                                              .trangThai ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.blue),
                                                  width: 2,
                                                ),
                                              ),
                                              color: widget.listBills[index]
                                                  .values.first,
                                              child: InkWell(
                                                  onTap: () {
                                                    setColor(widget
                                                        .listBills[index]);
                                                  },
                                                  onDoubleTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddCustomer(
                                                                      customer: widget
                                                                          .listBills[
                                                                              index]
                                                                          .keys
                                                                          .first,
                                                                      callBack:
                                                                          callBack,
                                                                    ))).then(
                                                        (item) {
                                                      setState(() {
                                                        listBills;
                                                      });
                                                    });
                                                  },
                                                  child: Bills(
                                                      Bill: widget
                                                          .listBills[index])),
                                            ),
                                          );
                                        }),
                          ),
                        );
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
