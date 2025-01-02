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
    widget.callBack(status);
    
    setState(() {});
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Center(
              child: InkWell(
                onTap: (){
                  widget.callBack("update");
                },
                child: const Text(
                  'TS COFFEE',
                  style: TextStyle(
                    fontFamily: 'BungeeShade-Regular',
                    fontSize: 36,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(flex: 1, child: Datetime(callBack: callBack)),
                Expanded(
                  flex: 2,
                  child: TextField(
                    obscureText: false,
                    onChanged: (value) {
                      if (value != "") {
                        listBillsSearch.clear();
                        for (var action in widget.listBills) {
                          if (action.keys.first.bienSoXe!.contains(value) &&
                              action.keys.first.trangThai == true) {
                            listBillsSearch.add(action);
                          }
                        }
                        listBills = [...listBillsSearch];
                        callBack("");
                      } else if (value == "")  {
                        listBillsSearch.clear();
                         listBills = [...listBillsTotal];
                        var listPro = [...listBills];
                        for (var action in listPro) {
                          if (DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(action.keys.first.createdOn.toString())) !=
                                DateFormat('yyyy-MM-dd').format(date)) {
                              listBills.remove(action);
                            }
                        } callBack("");
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
                            widget.callBack("update");
                            setState(() {});
                          },
                          child: Builder(
                            builder: (context) {
                              double tongTien = 0;
                              for (var action in listBillsTotal) {
                                var test = DateTime.parse(
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        date.year, date.month, date.day - 1)));
                                if (DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse(action
                                                .keys.first.createdOn
                                                .toString())) ==
                                        DateFormat('yyyy-MM-dd').format(test) &&
                                    action.keys.first.trangThai == true) {
                                  tongTien += action.keys.first.tongTien!;
                                }
                              }
                              return Text(
                                tongTien.toStringAsFixed(0),
                                style: const TextStyle(fontWeight: FontWeight.bold),
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
                          child:MediaQuery.of(context).size.width<700 ? Scaffold(
                              resizeToAvoidBottomInset: true,
                              body: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, mainAxisSpacing: 4),
                                  itemCount: widget.listBillsGridView.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setColor(widget.listBillsGridView[index]);
                                        },
                                        onDoubleTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddCustomer(
                                                      customer: widget
                                                          .listBillsGridView[index]
                                                          .keys
                                                          .first,
                                                      callBack: callBack))).then(
                                              (item) {
                                            setState(() {
                                              widget.listBillsGridView = [
                                                ...listBills
                                              ];
                          
                                              for (var item in listBillsTotal) {
                                                if (item.keys.first.trangThai ==
                                                    false) {
                                                  widget.listBillsGridView
                                                      .remove(item);
                                                }
                                              }
                                            });
                                          });
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  2), // if you need this
                                              side: BorderSide(
                                                color: (widget
                                                            .listBillsGridView[
                                                                index]
                                                            .keys
                                                            .first
                                                            .trangThai ==
                                                        true
                                                    ? Colors.red
                                                    : Colors.blue),
                                                width: 3,
                                              ),
                                            ),
                                            color: widget.listBillsGridView[index]
                                                .values.first,
                                            child: Bills(
                                                Bill: widget
                                                    .listBillsGridView[index])));
                                  }),
                            ):MediaQuery.of(context).size.width<1400 ?GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6, mainAxisSpacing: 4),
                                  itemCount: widget.listBillsGridView.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setColor(widget.listBillsGridView[index]);
                                        },
                                        onDoubleTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddCustomer(
                                                      customer: widget
                                                          .listBillsGridView[index]
                                                          .keys
                                                          .first,
                                                      callBack: callBack))).then(
                                              (item) {
                                            setState(() {
                                              widget.listBillsGridView = [
                                                ...listBills
                                              ];
                          
                                              for (var item in listBillsTotal) {
                                                if (item.keys.first.trangThai ==
                                                    false) {
                                                  widget.listBillsGridView
                                                      .remove(item);
                                                }
                                              }
                                            });
                                          });
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  2), // if you need this
                                              side: BorderSide(
                                                color: (widget
                                                            .listBillsGridView[
                                                                index]
                                                            .keys
                                                            .first
                                                            .trangThai ==
                                                        true
                                                    ? Colors.red
                                                    : Colors.blue),
                                                width: 3,
                                              ),
                                            ),
                                            color: widget.listBillsGridView[index]
                                                .values.first,
                                            child: Bills(
                                                Bill: widget
                                                    .listBillsGridView[index])));
                                  }):
                            GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 8, mainAxisSpacing: 4),
                                  itemCount: widget.listBillsGridView.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setColor(widget.listBillsGridView[index]);
                                        },
                                        onDoubleTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddCustomer(
                                                      customer: widget
                                                          .listBillsGridView[index]
                                                          .keys
                                                          .first,
                                                      callBack: callBack))).then(
                                              (item) {
                                            setState(() {
                                              widget.listBillsGridView = [
                                                ...listBills
                                              ];
                          
                                              for (var item in listBillsTotal) {
                                                if (item.keys.first.trangThai ==
                                                    false) {
                                                  widget.listBillsGridView
                                                      .remove(item);
                                                }
                                              }
                                            });
                                          });
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  2), // if you need this
                                              side: BorderSide(
                                                color: (widget
                                                            .listBillsGridView[
                                                                index]
                                                            .keys
                                                            .first
                                                            .trangThai ==
                                                        true
                                                    ? Colors.red
                                                    : Colors.blue),
                                                width: 3,
                                              ),
                                            ),
                                            color: widget.listBillsGridView[index]
                                                .values.first,
                                            child: Bills(
                                                Bill: widget
                                                    .listBillsGridView[index])));
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
    );
  }
}
