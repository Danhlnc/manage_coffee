import 'package:flutter/material.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:tscoffee/page/homepagewidget/addpagewidgets/drinkswidget.dart';
import 'package:tscoffee/page/homepagewidget/addpagewidgets/tobaccowidget.dart';

import '../../../apps/globalvariables.dart';
import '../../../model/billmodel.dart';

// ignore: must_be_immutable
class Doanhthuwidget extends StatefulWidget {
  Billmodel customer = Billmodel();
  List<Drinkbillmodel> listNuoc;
  List<Taboccobillmodel> listThuoc;
  Doanhthuwidget({super.key, required this.listNuoc, required this.listThuoc});

  @override
  _DoanhthuwidgetState createState() => _DoanhthuwidgetState();
}

class _DoanhthuwidgetState extends State<Doanhthuwidget> {
  callBack(Billmodel customer) {
    setState(() {
      widget.customer = customer;
    });
  }

  TextEditingController bienSoXe = TextEditingController();

  String sac = '';
  bool? isCheckedDay = false;
  bool? isCheckedNight = false;
  bool? isCheckedTam = false;
  bool? isCheckedMuonSac = false;
  double comGia = 0;
  double giatDoGia = 0;
  String tu = '';
  String ghiChu = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            title: const Text('Thêm khách hàng'),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: const TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Biển số xe',
                      ),
                    ),
                  ),
                  Container(
                    // ignore: sort_child_properties_last
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(2), // if you need this
                        side: const BorderSide(
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              const Text("  Sạc:"),
                              RadioMenuButton(
                                value: '>70',
                                groupValue: sac,
                                onChanged: (value) {
                                  setState(() {
                                    sac = value.toString();
                                  });
                                },
                                child: const Text('>70%'),
                              ),
                              RadioMenuButton(
                                value: '<70',
                                groupValue: sac,
                                onChanged: (value) {
                                  setState(() {
                                    sac = value.toString();
                                  });
                                },
                                child: const Text('<70%'),
                              ),
                              RadioMenuButton(
                                value: 'Không',
                                groupValue: sac,
                                onChanged: (value) {
                                  setState(() {
                                    sac = value.toString();
                                  });
                                },
                                child: const Text('Không'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: isCheckedMuonSac,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheckedMuonSac = value;
                                    });
                                  }),
                              const Text('Mượn sạc')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // ignore: sort_child_properties_last
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(2), // if you need this
                        side: const BorderSide(
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                              value: isCheckedDay,
                              onChanged: (value) {
                                setState(() {
                                  isCheckedDay = value;
                                });
                              }),
                          const Text('Ngủ ngày'),
                          Checkbox(
                              value: isCheckedNight,
                              onChanged: (value) {
                                setState(() {
                                  isCheckedNight = value;
                                });
                              }),
                          const Text('Ngủ đêm'),
                          Checkbox(
                              value: isCheckedNight,
                              onChanged: (value) {
                                setState(() {
                                  isCheckedNight = value;
                                });
                              }),
                          const Text('Tắm')
                        ],
                      ),
                    ),
                  ),
                  AbsorbPointer(
                      absorbing:
                          !bool.parse(widget.customer.trangThai.toString()),
                      child: Drinkswidget(
                          customer: widget.customer, callBackFunc: callBack)),
                  //thuốc
                  AbsorbPointer(
                      absorbing:
                          !bool.parse(widget.customer.trangThai.toString()),
                      child: Tobaccowidget(
                          customer: widget.customer, callBackFunc: callBack)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(2), // if you need this
                        side: const BorderSide(
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: const Text('Cơm: '))),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.all(5),
                                    child: const TextField(
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Nhập số tiền',
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: const Text('Giặt đồ: '))),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.all(5),
                                    child: const TextField(
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Nhập số tiền',
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(2), // if you need this
                      side: const BorderSide(
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            const Text("  Tủ:"),
                            RadioMenuButton(
                              value: 'Tuần',
                              groupValue: tu,
                              onChanged: (value) {
                                setState(() {
                                  tu = value!;
                                });
                              },
                              child: const Text('Tuần'),
                            ),
                            RadioMenuButton(
                              value: 'Tháng',
                              groupValue: tu,
                              onChanged: (value) {
                                setState(() {
                                  tu = value!;
                                });
                              },
                              child: const Text('Tháng'),
                            ),
                            RadioMenuButton(
                              value: 'Không',
                              groupValue: tu,
                              onChanged: (value) {
                                setState(() {
                                  tu = value!;
                                });
                              },
                              child: const Text('Không'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
                        obscureText: false,
                        minLines: 3,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ghi chú',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ]),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5, right: 10),
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Thanh Toán'),
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
