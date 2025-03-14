import 'package:flutter/material.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 2,
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
                              widget.listNuocSelected.soLuongBan =
                                  widget.listNuocSelected.soLuongBan! - 1;
                              widget.customer.tongTien =
                        widget.customer.soLuongSac8k! * 10000 +
                            widget.customer.soLuongSac12k! * 15000 +
                            widget.customer.soLuongMuonSac! * 3000 +
                            widget.customer.soLuongSacNhanh! * 30000 +
                            15000 * widget.customer.soLuongNguNgay! +
                            (30000 * widget.customer.soLuongNguDem!) +
                            widget.customer.soLuongTam! * 5000 +
                            getTotalComboPrice(widget.customer.listCombo)+
                            getTotalDrinkPrice(widget.customer.listNuoc) +
                            getTotalTaboccoPrice(widget.customer.listThuoc) +
                            double.parse(widget.customer.comGia.toString()) +
                            double.parse(widget.customer.giaGiatDo.toString()) +
                            double.parse(widget.customer.giaTu.toString());
                              widget.callBackFunc("");
                              setState(() {});
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
                            widget.listNuocSelected.soLuongBan =
                                widget.listNuocSelected.soLuongBan! + 1;
                            widget.customer.tongTien =
                        widget.customer.soLuongSac8k! * 10000 +
                            widget.customer.soLuongSac12k! * 15000 +
                            widget.customer.soLuongMuonSac! * 3000 +
                            widget.customer.soLuongSacNhanh! * 30000 +
                            15000 * widget.customer.soLuongNguNgay! +
                            (30000 * widget.customer.soLuongNguDem!) +
                            widget.customer.soLuongTam! * 5000 +
                            getTotalComboPrice(widget.customer.listCombo)+
                            getTotalDrinkPrice(widget.customer.listNuoc) +
                            getTotalTaboccoPrice(widget.customer.listThuoc) +
                            double.parse(widget.customer.comGia.toString()) +
                            double.parse(widget.customer.giaGiatDo.toString()) +
                            double.parse(widget.customer.giaTu.toString());

                            widget.callBackFunc("");
                            setState(() {});
                          },
                        )),
                  ],
                )),
            //
            const Expanded(
              flex: 2,
              child: SizedBox(
                width: 5,
              ),
            )
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
  double getTotalComboPrice(List<ComboModel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.price.toString()) ;
    }
    return total;
  }
}
