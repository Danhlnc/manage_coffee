import 'package:flutter/material.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';

import '../../../../apps/globalvariables.dart';
import '../../../../model/billmodel.dart';
import 'tabaccolist.dart';
import 'tobaccolistdialog.dart';

// ignore: must_be_immutable
class Tobaccowidget extends StatefulWidget {
  Function callBackFunc;
  Billmodel customer;
  Tobaccowidget(
      {super.key, required this.customer, required this.callBackFunc});

  @override
  _TobaccowidgetState createState() => _TobaccowidgetState();
}

class _TobaccowidgetState extends State<Tobaccowidget> {
  callBakFuncTobacco(value) {
    widget.callBackFunc(value);
    setState(() {});
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
                        listAllThuocSearch = [...listAllThuoc];
                        return Tobaccolistdialog(
                          listThuoc: widget.customer.listThuoc,
                        );
                      });
                  setState(() {
                    widget.customer.tongTien =
                        widget.customer.soLuongSac8k! * 10000 +
                            widget.customer.soLuongSac12k! * 15000 +
                            widget.customer.soLuongMuonSac! * 3000 +
                            widget.customer.soLuongSacNhanh! * 30000 +
                            widget.customer.soLuongSacNhanh20k! * 20000 +
                            15000 * widget.customer.soLuongNguNgay! +
                            (30000 * widget.customer.soLuongNguDem!) +
                            widget.customer.soLuongTam! * 5000 +
                            getTotalComboPrice(widget.customer.listCombo) +
                            getTotalDrinkPrice(widget.customer.listNuoc) +
                            getTotalTaboccoPrice(widget.customer.listThuoc) +
                            double.parse(widget.customer.comGia.toString()) +
                            double.parse(widget.customer.giaGiatDo.toString()) +
                            double.parse(widget.customer.giaTu.toString());
                    widget.callBackFunc("");
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Thêm Thuốc'),
              ),
            ),
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.customer.listThuoc.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.customer;
                            widget.callBackFunc("");
                          });
                        },
                        child: Card(
                          child: Stack(children: [
                            Tabaccolist(
                                listThuocSelected:
                                    widget.customer.listThuoc[index],
                                customer: widget.customer,
                                callBackFunc: callBakFuncTobacco),
                            Positioned(
                              right: 1,
                              child: IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: () {
                                  setState(() {
                                    widget.customer.listThuoc.remove(
                                        widget.customer.listThuoc[index]);
                                    widget.customer.listThuoc.length;
                                    widget.customer.tongTien = widget
                                                .customer.soLuongSac8k! *
                                            10000 +
                                        widget.customer.soLuongSac12k! * 15000 +
                                        widget.customer.soLuongMuonSac! * 3000 +
                                        widget.customer.soLuongSacNhanh! *
                                            30000 +
                                        widget.customer.soLuongSacNhanh20k! *
                                            20000 +
                                        15000 *
                                            widget.customer.soLuongNguNgay! +
                                        (30000 *
                                            widget.customer.soLuongNguDem!) +
                                        widget.customer.soLuongTam! * 5000 +
                                        getTotalComboPrice(
                                            widget.customer.listCombo) +
                                        getTotalDrinkPrice(
                                            widget.customer.listNuoc) +
                                        getTotalTaboccoPrice(
                                            widget.customer.listThuoc) +
                                        double.parse(
                                            widget.customer.comGia.toString()) +
                                        double.parse(widget.customer.giaGiatDo
                                            .toString()) +
                                        double.parse(
                                            widget.customer.giaTu.toString());
                                    widget.callBackFunc("");
                                  });
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

  double getTotalComboPrice(List<ComboModel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.price.toString());
    }
    return total;
  }
}
