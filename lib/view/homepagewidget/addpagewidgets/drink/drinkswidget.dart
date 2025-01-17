import 'package:flutter/material.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
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
                        listAllNuocSearch = [...listAllNuoc];
                        return Drinklistdialog(
                            listNuoc: widget.customer.listNuoc);
                      }).then((value) {
                    print(widget.customer.listNuoc);
                    setState(() {
                      widget.customer.tongTien = widget.customer.sac! +
                          (widget.customer.muonSac == true ? 3000 : 0) +
                          (widget.customer.nguNgay == true ? 15000 : 0) +
                          (widget.customer.nguDem == true ? 30000 : 0) +
                          (widget.customer.tam == true ? 5000 : 0) +
                          getTotalDrinkPrice(widget.customer.listNuoc) +
                          getTotalTaboccoPrice(widget.customer.listThuoc) +
                          double.parse(widget.customer.comGia.toString()) +
                          double.parse(widget.customer.giaGiatDo.toString()) +
                          double.parse(widget.customer.giaTu.toString());
                      widget.callBackFunc("");
                      widget.customer.listNuoc;
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
                            widget.customer.tongTien = widget.customer.sac! +
                                (widget.customer.muonSac == true ? 3000 : 0) +
                                (widget.customer.nguNgay == true ? 15000 : 0) +
                                (widget.customer.nguDem == true ? 30000 : 0) +
                                (widget.customer.tam == true ? 5000 : 0) +
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
                                  setState(() {
                                    widget.customer.listNuoc.remove(
                                        widget.customer.listNuoc[index]);
                                    widget.customer.listNuoc.length;
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
                                        (widget.customer.tam == true
                                            ? 5000
                                            : 0) +
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
}
