import 'package:flutter/material.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:tscoffee/view/homepagewidget/addpagewidgets/combo/comboListDialog.dart';

import '../../../../apps/globalvariables.dart';
import '../../../../model/billmodel.dart';

// ignore: must_be_immutable
class Comboswidget extends StatefulWidget {
  Function callBackFunc;
  Billmodel customer;
  Comboswidget({super.key, required this.customer, required this.callBackFunc});
  @override
  _DrinkswidgetState createState() => _DrinkswidgetState();
}

class _DrinkswidgetState extends State<Comboswidget> {
  callBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
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
                    listAllNuocSearch = [...listAllNuoc];
                    return ComboListDialog(
                      customer: widget.customer,
                      callBackFunc: callBack,
                    );
                  }).then((value) {
                setState(() {
                  widget.customer.tongTien =
                      widget.customer.soLuongSac8k! * 10000 +
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
                });
                widget.callBackFunc("");
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Thêm Combo'),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.customer.listCombo.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                              "${widget.customer.listCombo[index].name} : ${widget.customer.listCombo[index].price}")),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                widget.customer.listCombo
                                    .remove(widget.customer.listCombo[index]);
                                widget.customer.tongTien = widget
                                            .customer.soLuongSac8k! *
                                        10000 +
                                    widget.customer.soLuongSac12k! * 15000 +
                                    widget.customer.soLuongMuonSac! * 3000 +
                                    widget.customer.soLuongSacNhanh! * 30000 +
                                    15000 * widget.customer.soLuongNguNgay! +
                                    (30000 * widget.customer.soLuongNguDem!) +
                                    widget.customer.soLuongTam! * 5000 +
                                    getTotalComboPrice(
                                        widget.customer.listCombo) +
                                    getTotalDrinkPrice(
                                        widget.customer.listNuoc) +
                                    getTotalTaboccoPrice(
                                        widget.customer.listThuoc) +
                                    double.parse(
                                        widget.customer.comGia.toString()) +
                                    double.parse(
                                        widget.customer.giaGiatDo.toString()) +
                                    double.parse(
                                        widget.customer.giaTu.toString());
                                widget.callBackFunc("");
                              },
                              icon: const Icon(Icons.delete_forever_outlined)))
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  double getTotalComboPrice(List<ComboModel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.price.toString());
    }
    return total;
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
