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
          
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Expanded(flex: 1,
                child: DatetimeDoanhThu(callBack: callBack)),
           
             
              Expanded(
                flex: 1,
                child: TextField(
                  obscureText: false,
                  onChanged: (value) {
                    if (value != "") {
                       listBillsTotalDate = [...listBillsTotal];
                    var listProDate = [...listBillsTotalDate];
                    for (var action in listProDate) {
                      if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
                          action.keys.first.createdOn!.isAfter(dateTimeRange.start)) {
                      } else {
                        listBillsTotalDate.remove(action);
                      }
                    }
                     listBillsTotalSearch.clear();
                        for (var action in listBillsTotalDate) {
                          if (action.keys.first.bienSoXe!.toUpperCase().contains(value.toUpperCase())) {
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
              ),
              Expanded(child: Row(
                children: [
                  
                            const Text(' Chưa thanh toán'),AbsorbPointer(
                              absorbing: !widget.customer.trangThai!,
                              child: Checkbox(
                                  value: checkTT,
                                  onChanged: (value) {
                                    if(checkTT==false)
                                    {
                                    listBillsTotalDate = [...listBillsTotal];
                                    var listProDate = [...listBillsTotalDate];
                                    for (var action in listProDate) {
                                      if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
                                          action.keys.first.createdOn!.isAfter(dateTimeRange.start) && action.keys.first.trangThai==true) {
                                      } else {
                                        listBillsTotalDate.remove(action);
                                      }
                                    }
                                    checkTT=!checkTT;
                                    }else{
                                      listBillsTotalDate = [...listBillsTotal];
                                    var listProDate = [...listBillsTotalDate];
                                    for (var action in listProDate) {
                                      if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
                                          action.keys.first.createdOn!.isAfter(dateTimeRange.start)) {
                                      } else {
                                        listBillsTotalDate.remove(action);
                                      }
                                    }
                                    checkTT=!checkTT;
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
                color: Colors.lightBlueAccent,
                child: Row(
                  children: [
                    const Text(
                      ' TThu: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                      ' CThu: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
              )),
              Expanded(child: Card(
                color: Colors.amber,
                                  child: Row(
                                    children: [
                                      const Text(
                                        ' Chi: ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),Builder(builder: (context) {
                                                  
                                                   return const Text("0" ,style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)
                                                   );
                                                 }),
                                    ],
                                  ),
                                ),)
            ],
          ),
        ),
         Row(
           children: [
            Expanded(child: Card(
               color: Colors.blue,
              child: Row(
                children: [ Text(
               ' Tổng: ',
               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
             ),Builder(builder: (context) {
                                double total = 0;
                                for (var element in listBillsTotalDate) {
                total += double.parse(
                    element.keys.first.tongTien!.toStringAsFixed(0));
                                }
                                return Text(
                total.toStringAsFixed(0), style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)
                
                                );
                              }),],
              ),
            )),
                               Expanded(child: Card(
               color: Colors.blue,
                                child: Row(
                                  children: [
                                    const Text(
                                      ' Chi: ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),Builder(builder: (context) {
                                                
                                                 return const Text("0" ,style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)
                                                 );
                                               }),
                                  ],
                                ),
                              ),)
                              
           ],
         ),
                
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Stack(children: [
              //gridview doanh thu
              Builder(builder: (context) {
                return loadData == true
                    ? const Loading()
                    : NotificationListener(
                      child: SizeChangedLayoutNotifier(
                        child: MediaQuery.of(context).size.width<700 ?GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, mainAxisSpacing: 4),
                            itemCount: widget.listBills.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Container(

                                
                                margin: const EdgeInsets.all(1),
                                child: Card(
                                                       
                                  elevation: 8,
                                  shadowColor: (widget.listBills[index].keys.first
                                                  .trangThai ==
                                              true
                                          ? Colors.red
                                          : Colors.blue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // if you need this
                                    side: BorderSide(
                                      color: (widget.listBills[index].keys.first
                                                  .trangThai ==
                                              true
                                          ? Colors.red
                                          : Colors.blue),
                                      width: 2,
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
                                ),
                              );
                            }):MediaQuery.of(context).size.width<1400 ?GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8, mainAxisSpacing: 4),
                            itemCount: widget.listBills.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Container(
                                
                                margin: const EdgeInsets.all(3),
                                child: Card(
                                  elevation: 8,
                                  shadowColor: (widget.listBills[index].keys.first
                                                  .trangThai ==
                                              true
                                          ? Colors.red
                                          : Colors.blue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // if you need this
                                    side: BorderSide(
                                      color: (widget.listBills[index].keys.first
                                                  .trangThai ==
                                              true
                                          ? Colors.red
                                          : Colors.blue),
                                      width: 2,
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
                                ),
                              );
                            }):GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 16, mainAxisSpacing: 4),
                            itemCount: widget.listBills.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Container(
                                margin: const EdgeInsets.all(3),
                               
                                child: Card(
                                   elevation: 8,
  shadowColor: (widget.listBills[index].keys.first
                                                .trangThai ==
                                            true
                                        ? Colors.red
                                        : Colors.blue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // if you need this
                                    side: BorderSide(
                                      color: (widget.listBills[index].keys.first
                                                  .trangThai ==
                                              true
                                          ? Colors.red
                                          : Colors.blue),
                                      width: 2,
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
    );
  }
}
