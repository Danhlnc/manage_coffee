import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';

import '../../../../apps/globalvariables.dart';
import '../../../../model/billmodel.dart';
import 'drinklist.dart';
import 'drinklistdialog.dart';

// ignore: must_be_immutable
class Drinkswidget extends StatefulWidget {
  Function callBackFunc;
  Billmodel customer;
  Drinkswidget({super.key, required this.customer, required this.callBackFunc});

  @override
  _DrinkswidgetState createState() => _DrinkswidgetState();
}

class _DrinkswidgetState extends State<Drinkswidget> {
  late Drinkbillmodel nuoc;
  callBakFuncDrink(value) {
    widget.callBackFunc(value);
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2), // if you need this
          side: const BorderSide(
            width: 1,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        context.read<ProviderModel>().listAllNuocSearch = [
                          ...context.read<ProviderModel>().listAllNuoc
                        ];
                        return Drinklistdialog(
                            listNuoc: widget.customer.listNuoc);
                      }).then((value) {
                    setState(() {
                      widget.customer.tongTien = widget.customer.soLuongSac8k! *
                              10000 +
                          widget.customer.soLuongSac12k! * 15000 +
                          widget.customer.soLuongMuonSac! * 3000 +
                          widget.customer.soLuongSacNhanh! * 30000 +
                          15000 * widget.customer.soLuongNguNgay! +
                          (30000 * widget.customer.soLuongNguDem!) +
                          widget.customer.soLuongTam! * 5000 +
                          getTotalComboPrice(widget.customer.listCombo) +
                          getTotalDrinkPrice(widget.customer.listNuoc) +
                          getTotalTaboccoPrice(widget.customer.listThuoc) +
                          double.parse(widget.customer.comGia.toString()) +
                          double.parse(widget.customer.giaGiatDo.toString()) +
                          double.parse(widget.customer.giaTu.toString());
                      widget.customer.listNuoc;

                      widget.callBackFunc("");
                    });
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Thêm Nước'),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.customer.listNuoc.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.customer.tongTien = widget
                                        .customer.soLuongSac8k! *
                                    10000 +
                                widget.customer.soLuongSac12k! * 15000 +
                                widget.customer.soLuongMuonSac! * 3000 +
                                widget.customer.soLuongSacNhanh! * 30000 +
                                widget.customer.soLuongSacNhanh20k! * 20000 +
                                15000 * widget.customer.soLuongNguNgay! +
                                (30000 * widget.customer.soLuongNguDem!) +
                                widget.customer.soLuongTam! * 5000 +
                                getTotalComboPrice(widget.customer.listCombo) +
                                getTotalDrinkPrice(widget.customer.listNuoc) +
                                getTotalTaboccoPrice(
                                    widget.customer.listThuoc) +
                                double.parse(
                                    widget.customer.comGia.toString()) +
                                double.parse(
                                    widget.customer.giaGiatDo.toString()) +
                                double.parse(widget.customer.giaTu.toString());
                            widget.callBackFunc("");
                          });
                        },
                        child: Card(
                          child: Stack(children: [
                            Drinklist(
                                listNuocSelected:
                                    widget.customer.listNuoc[index],
                                customer: widget.customer,
                                callBackFunc: callBakFuncDrink),
                            Positioned(
                              right: 1,
                              child: IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: () {
                                  try {
                                    for (var element in context
                                        .read<ProviderModel>()
                                        .listAllNuoc) {
                                      if (element.drinkName ==
                                          widget.customer.listNuoc.first
                                              .drinkmodel!.drinkName) {
                                        element.countStore =
                                            (element.countStore as int) +
                                                (widget.customer.listNuoc.first
                                                    .soLuongBan as int);
                                        updateDrink(element.toJson())
                                            .then((onValue) {
                                          setState(() {
                                            widget.customer.listNuoc.remove(
                                                widget
                                                    .customer.listNuoc[index]);
                                            widget.customer.listNuoc.length;
                                            widget.customer.tongTien = widget
                                                        .customer
                                                        .soLuongSac8k! *
                                                    10000 +
                                                widget.customer.soLuongSac12k! *
                                                    15000 +
                                                widget.customer.soLuongMuonSac! *
                                                    3000 +
                                                widget.customer.soLuongSacNhanh! *
                                                    30000 +
                                                widget.customer
                                                        .soLuongSacNhanh20k! *
                                                    20000 +
                                                15000 *
                                                    widget.customer
                                                        .soLuongNguNgay! +
                                                (30000 *
                                                    widget.customer
                                                        .soLuongNguDem!) +
                                                widget.customer.soLuongTam! *
                                                    5000 +
                                                getTotalComboPrice(
                                                    widget.customer.listCombo) +
                                                getTotalDrinkPrice(
                                                    widget.customer.listNuoc) +
                                                getTotalTaboccoPrice(
                                                    widget.customer.listThuoc) +
                                                double.parse(widget.customer.comGia
                                                    .toString()) +
                                                double.parse(widget.customer.giaGiatDo.toString()) +
                                                double.parse(widget.customer.giaTu.toString());
                                            widget.callBackFunc("");
                                          });
                                        });
                                      }
                                    }
                                  } catch (e) {}
                                },
                              ),
                            ),
                          ]),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getTotalDrinkPrice(List<Drinkbillmodel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.drinkmodel!.price.toString()) *
          (int.parse(item.soLuongBan!.toString()));
    }
    return total;
  }

  double getTotalTaboccoPrice(List<Taboccobillmodel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.taboccomodel!.price.toString()) *
          (int.parse(item.soLuongBan!.toString()));
    }
    return total;
  }
}

double getTotalComboPrice(List<ComboModel> list) {
  double total = 0;
  for (var item in list) {
    total += num.parse(item.price.toString());
  }
  return total;
}
