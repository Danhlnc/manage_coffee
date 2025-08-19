import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/providerModel.dart';

import '../../loading.dart';
import '../addcustomer.dart';
import 'billlist.dart';
import 'datetime.dart';

// ignore: must_be_immutable
class KhachhangSceen extends StatefulWidget {
  List<Map<Billmodel, Color>> listBills;

  List<Map<Billmodel, Color>> listSearch = [];
  Billmodel customer = Billmodel();
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
    if (mounted) {
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
    return Consumer<ProviderModel>(builder: (context, providerModel, child) {
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
                            if (value != "") {}
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
                                providerModel.listBills = [
                                  ...context
                                      .read<ProviderModel>()
                                      .listBillsTotal
                                ];

                                context
                                    .read<ProviderModel>()
                                    .updateloadData(false);
                                providerModel.listBills.sort((b, a) =>
                                    a.keys.first.modifyOn!.compareTo(
                                        b.keys.first.modifyOn as DateTime));
                                context.read<ProviderModel>().listBillsTotal = [
                                  ...providerModel.listBills
                                ];
                                var listPro = [...providerModel.listBills];
                                for (var action in listPro) {
                                  if (action.keys.first.createdOn!.day !=
                                          date.day ||
                                      action.keys.first.createdOn!.month !=
                                          date.month ||
                                      action.keys.first.createdOn!.year !=
                                          date.year ||
                                      action.keys.first.trangThai == false) {
                                    providerModel.listBills.remove(action);
                                  }
                                }
                                context
                                    .read<ProviderModel>()
                                    .updateListBill(providerModel.listBills);
                              },
                              child: Builder(
                                builder: (context) {
                                  double tongTien = 0;
                                  for (var action in context
                                      .read<ProviderModel>()
                                      .listBillsTotal) {
                                    var test = DateTime.parse(
                                        DateFormat('yyyy-MM-dd').format(
                                            DateTime(date.year, date.month,
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
                      return context.read<ProviderModel>().loadData == true
                          ? const Loading()
                          : MediaQuery.of(context).size.width < 700
                              ? GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 4),
                                  itemCount: providerModel.listBills.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setColor(
                                              providerModel.listBills[index]);
                                        },
                                        onDoubleTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddCustomer(
                                                          customer:
                                                              providerModel
                                                                  .listBills[
                                                                      index]
                                                                  .keys
                                                                  .first,
                                                          callBack:
                                                              callBack))).then(
                                              (item) {});
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
                                              ),
                                              color: providerModel
                                                  .listBills[index]
                                                  .values
                                                  .first,
                                              child: Bills(
                                                  Bill: providerModel
                                                      .listBills[index])),
                                        ));
                                  })
                              : MediaQuery.of(context).size.width < 1400
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 8,
                                              mainAxisSpacing: 4),
                                      itemCount: providerModel.listBills.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        return InkWell(
                                            onTap: () {
                                              setColor(providerModel
                                                  .listBills[index]);
                                            },
                                            onDoubleTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddCustomer(
                                                              customer:
                                                                  providerModel
                                                                      .listBills[
                                                                          index]
                                                                      .keys
                                                                      .first,
                                                              callBack:
                                                                  callBack))).then(
                                                  (item) {});
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
                                                  ),
                                                  color: providerModel
                                                      .listBills[index]
                                                      .values
                                                      .first,
                                                  child: Bills(
                                                      Bill: providerModel
                                                          .listBills[index])),
                                            ));
                                      })
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 12,
                                              mainAxisSpacing: 4),
                                      itemCount: providerModel.listBills.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        return InkWell(
                                            onTap: () {
                                              setColor(providerModel
                                                  .listBills[index]);
                                            },
                                            onDoubleTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddCustomer(
                                                              customer:
                                                                  providerModel
                                                                      .listBills[
                                                                          index]
                                                                      .keys
                                                                      .first,
                                                              callBack:
                                                                  callBack))).then(
                                                  (item) {});
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
                                                  ),
                                                  color: providerModel
                                                      .listBills[index]
                                                      .values
                                                      .first,
                                                  child: Bills(
                                                      Bill: providerModel
                                                          .listBills[index])),
                                            ));
                                      });
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
            ],
          ),
        ),
      );
    });
  }
}
