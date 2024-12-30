import 'package:flutter/material.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';

import '../../../../apps/globalvariables.dart';

// ignore: must_be_immutable
class Drinklist extends StatefulWidget {
  Drinkbillmodel listNuocSelected;
  Billmodel customer;

  Function callBackFunc;
  Drinklist(
      {super.key,
      required this.listNuocSelected,
      required this.customer,
      required this.callBackFunc});

  @override
  _DrinklistState createState() => _DrinklistState();
}

class _DrinklistState extends State<Drinklist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 5,
                child: Text(widget.listNuocSelected.drinkmodel!.drinkName!)),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove_circle_outlined),
                          onPressed: () {
                            if (widget.listNuocSelected.soLuongBan! > 1) {
                              setState(() {
                                widget.listNuocSelected.soLuongBan =
                                    widget.listNuocSelected.soLuongBan! - 1;
                                widget.customer.tongTien = widget
                                        .customer.sac! +
                                    (widget.customer.muonSac == true
                                        ? 3000
                                        : 0) +
                                    (widget.customer.nguNgay == true
                                        ? 15000
                                        : 0) +
                                    (widget.customer.nguDem == true
                                        ? 30000
                                        : 0) +
                                    (widget.customer.tam == true ? 5000 : 0) +
                                    getTotalDrinkPrice(listNuoc) +
                                    getTotalTaboccoPrice(listThuoc) +
                                    double.parse(
                                        widget.customer.comGia.toString()) +
                                    double.parse(
                                        widget.customer.giaGiatDo.toString()) +
                                    double.parse(
                                        widget.customer.giaTu.toString());
                                widget.callBackFunc("");
                              });
                            }
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Container(
                                padding: EdgeInsets.zero,
                                child: Text(widget.listNuocSelected.soLuongBan!
                                    .toString())))),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add_circle_outlined),
                          onPressed: () {
                            setState(() {
                              widget.listNuocSelected.soLuongBan =
                                  widget.listNuocSelected.soLuongBan! + 1;
                              widget.customer.tongTien = widget.customer.sac! +
                                  (widget.customer.muonSac == true ? 3000 : 0) +
                                  (widget.customer.nguNgay == true
                                      ? 15000
                                      : 0) +
                                  (widget.customer.nguDem == true ? 30000 : 0) +
                                  (widget.customer.tam == true ? 5000 : 0) +
                                  getTotalDrinkPrice(listNuoc) +
                                  getTotalTaboccoPrice(listThuoc) +
                                  double.parse(
                                      widget.customer.comGia.toString()) +
                                  double.parse(
                                      widget.customer.giaGiatDo.toString()) +
                                  double.parse(
                                      widget.customer.giaTu.toString());
                              widget.callBackFunc("");
                            });
                          },
                        )),
                  ],
                )),
            //
            const Expanded(
                flex: 3,
                child: SizedBox(
                  width: 5,
                )),
          ]),
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
