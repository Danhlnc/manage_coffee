import 'package:flutter/material.dart';

import '../../../apps/globalvariables.dart';
import '../../../model/billmodel.dart';
import '../../loading.dart';
import '../addcustomer.dart';
import '../addpagewidgets/billlist.dart';
import 'datetimeDoanhThu.dart';

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

  @override
  Widget build(BuildContext context) {
    if (widget.listBills.isEmpty) {
      widget.listBills = [...listBillsTotalDate];
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.blueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'Tổng:   ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Builder(builder: (context) {
                double total = 0;
                for (var element in listBillsTotalDate) {
                  total += double.parse(
                      element.keys.first.tongTien!.toStringAsFixed(0));
                }
                return Text(
                  total.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                );
              })
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              DatetimeDoanhThu(callBack: callBack),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  obscureText: false,
                  onChanged: (value) {
                    if (value != "") {
                     listBillsTotalSearch.clear();
                        for (var action in widget.listBills) {
                          if (action.keys.first.bienSoXe!.contains(value)) {
                            listBillsTotalSearch.add(action);
                          }
                        }
                        listBillsTotalDate = [...listBillsTotalSearch];
                        callBack("");
                    } else {
                      listBillsTotalDate = [...listBillsTotal];
                      var listProDate = [...listBillsTotalDate];
                      for (var action in listProDate) {
                        if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
                            action.keys.first.createdOn!.isAfter(dateTimeRange.start)) {
                        } else {
                          listBillsTotalDate.remove(action);
                        }
                      }
                      callBack("");
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Tìm kiếm",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                  ),
                ),
              )
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
                color: Colors.lightBlueAccent,
                child: Row(
                  children: [
                    const Text(
                      '  TThu:   ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Builder(builder: (context) {
                      double total = 0;
                      for (var element in listBillsTotalDate) {
                        if (element.keys.first.trangThai == false) {
                          total += double.parse(
                              element.keys.first.tongTien!.toStringAsFixed(0));
                        }
                      }
                      return Text(
                        total.toStringAsFixed(0),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
              )),
              Expanded(
                  child: Card(
                color: Colors.redAccent,
                child: Row(
                  children: [
                    const Text(
                      '  CThu:   ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Builder(builder: (context) {
                      double total = 0;
                      for (var element in listBillsTotalDate) {
                        if (element.keys.first.trangThai == true) {
                          total += double.parse(
                              element.keys.first.tongTien!.toStringAsFixed(0));
                        }
                      }
                      return Text(
                        total.toStringAsFixed(0),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Stack(children: [
              //gridview doanh thu
              Builder(builder: (context) {
                return loadData == true
                    ? const Loading()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, mainAxisSpacing: 4),
                        itemCount: widget.listBills.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(2), // if you need this
                              side: BorderSide(
                                color: (widget.listBills[index].keys.first
                                            .trangThai ==
                                        true
                                    ? Colors.red
                                    : Colors.green),
                                width: 1,
                              ),
                            ),
                            color: widget.listBills[index].values.first,
                            child: InkWell(
                                onTap: () {
                                  setColor(widget.listBills[index]);
                                },
                                onDoubleTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddCustomer(
                                                customer: widget
                                                    .listBills[index]
                                                    .keys
                                                    .first,
                                                callBack: callBack,
                                              ))).then((item) {
                                    setState(() {
                                      listBills;
                                    });
                                  });
                                },
                                child: Bills(Bill: widget.listBills[index])),
                          );
                        });
              }),
            ]),
          ),
        ),
      ],
    );
  }
}
