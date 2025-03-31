import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/billmodel.dart';

import '../../loading.dart';
import '../addcustomer.dart';
import 'billlist.dart';
import 'datetime.dart';

// ignore: must_be_immutable
class KhachhangSceen extends StatefulWidget {
  List<Map<Billmodel, Color>> listBills;

  List<Map<Billmodel, Color>> listSearch = [];
  Billmodel customer = Billmodel();
  List<Map<Billmodel, Color>> listBillsGridView = [];
  Function callBack;
  KhachhangSceen({
    super.key,
    required this.listBills,
    required this.callBack,
  });

  @override
  _KhachhangSceenState createState() => _KhachhangSceenState();
}

class _KhachhangSceenState extends State<KhachhangSceen> {
  callBack(String status) {
    if (status == "reload") {
      setState(() {});
    } else {
      widget.callBack(status);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  void setColor(Map<Billmodel, Color> bill) {
    for (var i = 0; i < widget.listBills.length; i++) {
      int test = widget.listBills[i].hashCode;
      int test2 = bill.hashCode;
      if (test == test2) {
        setState(() {
          Map<Billmodel, Color> item = widget.listBills[i];
          item[item.keys.first] = Colors.amberAccent;
        });
      } else {
        setState(() {
          Map<Billmodel, Color> item = widget.listBills[i];
          item[item.keys.first] = Colors.white;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              child: Row(
                children: [
                  Expanded(flex: 1, child: Datetime(callBack: callBack)),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        widget.callBack("update");
                      },
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'TS COFFEE',
                          style: TextStyle(
                              fontFamily: 'BungeeShade-Regular',
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: TextField(
                        obscureText: false,
                        onChanged: (value) {
                          if (value != "") {
                            listBills = [...listBillsTotal];
                            var listPro = [...listBills];
                            for (var action in listPro) {
                              if (DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(action.keys.first.createdOn
                                          .toString())) !=
                                  DateFormat('yyyy-MM-dd').format(date)) {
                                listBills.remove(action);
                              }
                            }

                            listBillsSearch.clear();
                            for (var action in listBills) {
                              if (action.keys.first.bienSoXe!
                                      .toString()
                                      .toUpperCase()
                                      .contains(value.toUpperCase()) &&
                                  action.keys.first.trangThai == true) {
                                listBillsSearch.add(action);
                              }
                            }
                            listBills = [...listBillsSearch];
                            callBack("");
                          } else if (value == "") {
                            listBillsSearch.clear();
                            listBills = [...listBillsTotal];
                            var listPro = [...listBills];
                            for (var action in listPro) {
                              if (DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(action.keys.first.createdOn
                                          .toString())) !=
                                  DateFormat('yyyy-MM-dd').format(date)) {
                                listBills.remove(action);
                              }
                            }
                            callBack("");
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tìm kiếm',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Builder(builder: (context) {
                return FractionallySizedBox(
                    widthFactor: 1, //20% width
                    heightFactor: 1, //50% height
                    alignment: FractionalOffset.center,
                    child: Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("CTT hôm trước: "),
                          TextButton(
                            onPressed: () {
                              date = DateTime.parse(DateFormat('yyyy-MM-dd')
                                  .format(DateTime(
                                      date.year, date.month, date.day - 1)));
                              listBills = [...listBillsTotal];
                              loadData = false;
                              listBills.sort((b, a) => a.keys.first.modifyOn!
                                  .compareTo(
                                      b.keys.first.modifyOn as DateTime));
                              listBillsTotal = [...listBills];
                              var listPro = [...listBills];
                              for (var action in listPro) {
                                if (action.keys.first.createdOn!.day !=
                                        date.day ||
                                    action.keys.first.createdOn!.month !=
                                        date.month ||
                                    action.keys.first.createdOn!.year !=
                                        date.year) {
                                  listBills.remove(action);
                                }
                              }
                              widget.callBack("reload");
                            },
                            child: Builder(
                              builder: (context) {
                                double tongTien = 0;
                                for (var action in listBillsTotal) {
                                  var test = DateTime.parse(
                                      DateFormat('yyyy-MM-dd').format(DateTime(
                                          date.year,
                                          date.month,
                                          date.day - 1)));
                                  if (DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(action
                                                  .keys.first.createdOn
                                                  .toString())) ==
                                          DateFormat('yyyy-MM-dd')
                                              .format(test) &&
                                      action.keys.first.trangThai == true) {
                                    tongTien += action.keys.first.tongTien!;
                                  }
                                }
                                return Text(
                                  tongTien.toStringAsFixed(0),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ));
              }),
            ),
            Expanded(
              child: Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:

                      //gridview khach hang
                      Builder(builder: (context) {
                    if (widget.listBillsGridView.isEmpty) {
                      widget.listBillsGridView = [...listBills];
                      for (var item in listBills) {
                        if (item.keys.first.trangThai == false) {
                          widget.listBillsGridView.remove(item);
                        }
                      }
                    }
                    return loadData == true
                        ? const Loading()
                        : NotificationListener(
                            child: SizeChangedLayoutNotifier(
                              child: MediaQuery.of(context).size.width < 700
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 4),
                                      itemCount:
                                          widget.listBillsGridView.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        return InkWell(
                                            onTap: () {
                                              setColor(widget
                                                  .listBillsGridView[index]);
                                            },
                                            onDoubleTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddCustomer(
                                                              customer: widget
                                                                  .listBillsGridView[
                                                                      index]
                                                                  .keys
                                                                  .first,
                                                              callBack:
                                                                  callBack))).then(
                                                  (item) {
                                                setState(() {
                                                  widget.listBillsGridView = [
                                                    ...listBills
                                                  ];

                                                  for (var item
                                                      in listBillsTotal) {
                                                    if (item.keys.first
                                                            .trangThai ==
                                                        false) {
                                                      widget.listBillsGridView
                                                          .remove(item);
                                                    }
                                                  }
                                                });
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(3),
                                              child: Card(
                                                  elevation: 8,
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16), // if you need this
                                                    side: BorderSide(
                                                      color: (widget
                                                                  .listBillsGridView[
                                                                      index]
                                                                  .keys
                                                                  .first
                                                                  .trangThai ==
                                                              true
                                                          ? widget
                                                                          .listBillsGridView[
                                                                              index]
                                                                          .keys
                                                                          .first
                                                                          .doiSac ==
                                                                      true &&
                                                                  checkDoiSac ==
                                                                      true
                                                              ? Colors.yellow
                                                              : Colors.white
                                                          : Colors.blue),
                                                      width: 6,
                                                    ),
                                                  ),
                                                  color: widget
                                                      .listBillsGridView[index]
                                                      .values
                                                      .first,
                                                  child: Bills(
                                                      Bill: widget
                                                              .listBillsGridView[
                                                          index])),
                                            ));
                                      })
                                  : MediaQuery.of(context).size.width < 1400
                                      ? GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 8,
                                                  mainAxisSpacing: 4),
                                          itemCount:
                                              widget.listBillsGridView.length,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return InkWell(
                                                onTap: () {
                                                  setColor(
                                                      widget.listBillsGridView[
                                                          index]);
                                                },
                                                onDoubleTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddCustomer(
                                                                  customer: widget
                                                                      .listBillsGridView[
                                                                          index]
                                                                      .keys
                                                                      .first,
                                                                  callBack:
                                                                      callBack))).then(
                                                      (item) {
                                                    setState(() {
                                                      widget.listBillsGridView =
                                                          [...listBills];

                                                      for (var item
                                                          in listBillsTotal) {
                                                        if (item.keys.first
                                                                .trangThai ==
                                                            false) {
                                                          widget
                                                              .listBillsGridView
                                                              .remove(item);
                                                        }
                                                      }
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(3),
                                                  child: Card(
                                                      elevation: 8,
                                                      shadowColor: Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16), // if you need this
                                                        side: BorderSide(
                                                          color: (widget
                                                                      .listBillsGridView[
                                                                          index]
                                                                      .keys
                                                                      .first
                                                                      .trangThai ==
                                                                  true
                                                              ? widget.listBillsGridView[index].keys.first.doiSac ==
                                                                          true &&
                                                                      checkDoiSac ==
                                                                          true
                                                                  ? Colors
                                                                      .yellow
                                                                  : Colors.white
                                                              : Colors.blue),
                                                          width: 6,
                                                        ),
                                                      ),
                                                      color: widget
                                                          .listBillsGridView[
                                                              index]
                                                          .values
                                                          .first,
                                                      child: Bills(
                                                          Bill: widget
                                                                  .listBillsGridView[
                                                              index])),
                                                ));
                                          })
                                      : GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 12,
                                                  mainAxisSpacing: 4),
                                          itemCount:
                                              widget.listBillsGridView.length,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return InkWell(
                                                onTap: () {
                                                  setColor(
                                                      widget.listBillsGridView[
                                                          index]);
                                                },
                                                onDoubleTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddCustomer(
                                                                  customer: widget
                                                                      .listBillsGridView[
                                                                          index]
                                                                      .keys
                                                                      .first,
                                                                  callBack:
                                                                      callBack))).then(
                                                      (item) {
                                                    setState(() {
                                                      widget.listBillsGridView =
                                                          [...listBills];

                                                      for (var item
                                                          in listBillsTotal) {
                                                        if (item.keys.first
                                                                .trangThai ==
                                                            false) {
                                                          widget
                                                              .listBillsGridView
                                                              .remove(item);
                                                        }
                                                      }
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(3),
                                                  child: Card(
                                                      elevation: 8,
                                                      shadowColor: Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16), // if you need this
                                                        side: BorderSide(
                                                          color: (widget
                                                                      .listBillsGridView[
                                                                          index]
                                                                      .keys
                                                                      .first
                                                                      .trangThai ==
                                                                  true
                                                              ? widget.listBillsGridView[index].keys.first.doiSac ==
                                                                          true &&
                                                                      checkDoiSac ==
                                                                          true
                                                                  ? Colors
                                                                      .yellow
                                                                  : Colors.white
                                                              : Colors.blue),
                                                          width: 6,
                                                        ),
                                                      ),
                                                      color: widget
                                                          .listBillsGridView[
                                                              index]
                                                          .values
                                                          .first,
                                                      child: Bills(
                                                          Bill: widget
                                                                  .listBillsGridView[
                                                              index])),
                                                ));
                                          }),
                            ),
                          );
                  }),
                ),
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
                          listNuoc = [];
                          listThuoc = [];
                        }

                        setState(() {
                          widget.listBillsGridView = [...listBills];

                          for (var item in listBillsTotal) {
                            if (item.keys.first.trangThai == false) {
                              widget.listBillsGridView.remove(item);
                            }
                          }
                        });
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm khách hàng'),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
