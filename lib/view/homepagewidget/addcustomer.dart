import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:http/http.dart' as http;
import '../../model/billmodel.dart';
import 'addpagewidgets/drink/drinkswidget.dart';
import 'addpagewidgets/tobacco/tobaccowidget.dart';

enum SingingCharacter { lafayette, jefferson }

// ignore: must_be_immutable
class AddCustomer extends StatefulWidget {
  bool onConfirm = false;
  Billmodel customer;
  Function callBack;
  AddCustomer({super.key, required this.customer, required this.callBack});
  bool loading = false;

  @override
  // ignore: library_private_types_in_public_api
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  callBack(String status) {
    widget.callBack(status);
    setState(() {});
  }

  Future addBill(Map<String, dynamic> item) async {
    final response = await http.post(
      Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/bills'),
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

  Future updateBill(Map<String, dynamic> item) async {
    final response = await http.put(
      Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/bills'),
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

  //#region create customer
  CreateCustomer(bool trangThai, bool staTus) async {
    try {
      if (widget.customer.bienSoXe == "") {
        await showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text('Vui lòng nhập biển số xe!'),
              );
            });
      } else {
        widget.customer.bienSoXe = bienSoXe.text;
        widget.customer.comGia =
            (comGia.text != '' ? double.parse(comGia.text) : 0);
        widget.customer.giaGiatDo =
            (comGia.text != '' ? double.parse(giaGiatDo.text) : 0);
        widget.customer.ghiChu = ghiChu.text;
        widget.customer.trangThai = trangThai;
        widget.customer.createdBy = '';
        widget.customer.modifyOn = DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute);
        widget.customer.modifyBy = '';
        widget.customer.trangThai = trangThai;
        var details = {widget.customer: Colors.white};
        var test = widget.customer.toJson();
        test.remove('_id');
        if (staTus) {
          EasyLoading.show(status: 'loading...');
          setState(() {
            widget.loading = true;
          });
          addBill(test).then((onValue) {
            setState(() {
              widget.loading = false;
            });
            EasyLoading.dismiss();
            Navigator.of(context).pop();
            widget.callBack("update");
          });
        } else {
          EasyLoading.show(status: 'loading...');
          setState(() {
            widget.loading = true;
          });
          updateBill(widget.customer.toJson()).then((onValue) {
            for (var element in listBillsTotal) {
              if (element.keys.first.sId == widget.customer.sId) {
                element.keys.first.trangThai = widget.customer.trangThai;
              }
            }
            setState(() {
              widget.loading = false;
            });

            EasyLoading.dismiss();
            Navigator.of(context).pop();
            callBack("reload");
          });
        }
      }
    } catch (e) {
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Cơm và giặt đồ chỉ được nhập số!'),
            );
          });
    }
  }

  //#endregion
  getTongTien() {
    widget.customer.tongTien = widget.customer.soLuongSac8k! * 8000 +
        widget.customer.soLuongSac12k! * 12000 +
        (widget.customer.muonSac == true ? 3000 : 0) +
        15000 * widget.customer.soLuongNguNgay! +
        (30000 * widget.customer.soLuongNguDem!) +
        (widget.customer.tam == true ? 5000 : 0) +
        getTotalDrinkPrice(widget.customer.listNuoc) +
        getTotalTaboccoPrice(widget.customer.listThuoc) +
        (comGia.text != '' ? double.parse(comGia.text) : 0) +
        (giaGiatDo.text != '' ? double.parse(giaGiatDo.text) : 0) +
        double.parse(widget.customer.giaTu.toString());
    callBack("");
  }

  TextEditingController bienSoXe = TextEditingController();
  TextEditingController ghiChu = TextEditingController();
  String sac = '';
  bool? isCheckedDay = false;
  bool? isCheckedNight = false;
  bool? isCheckedTam = false;
  bool? isCheckedMuonSac = false;
  TextEditingController comGia = TextEditingController();
  TextEditingController giaGiatDo = TextEditingController();
  String giaTu = '';

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.loading,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(bottom: 5, right: 10),
              child: Builder(
                builder: (context) {
                  if (widget.customer.sId == '') {
                    return FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        CreateCustomer(true, true);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(' Thêm'),
                    );
                  } else if (widget.customer.sId != '') {
                    if (widget.customer.trangThai == true) {
                      listNuoc = widget.customer.listNuoc;
                      listThuoc = widget.customer.listThuoc;
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: FloatingActionButton.extended(
                                heroTag: null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                onPressed: () {
                                  CreateCustomer(true, false);
                                },
                                icon: const Icon(Icons.update),
                                label: const Text(' Cập nhật'),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: FloatingActionButton.extended(
                                heroTag: null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                onPressed: () async {
                                  double? val = await showDialog<double>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Xác nhận thanh toán'),
                                              Text(
                                                ' ${widget.customer.tongTien!.toStringAsFixed(0)}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.redAccent),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(
                                                        double.tryParse(
                                                            0.toString())),
                                                child: const Text('Hủy')),
                                            ElevatedButton(
                                                onPressed: () => Navigator.of(
                                                        context)
                                                    .pop(double.tryParse(1
                                                        .toString())), // returns val
                                                child: const Text('OK')),
                                          ],
                                        );
                                      });
                                  if (val == 1) {
                                    CreateCustomer(false, false);
                                  }
                                },
                                icon: const Icon(Icons.payment),
                                label: const Text(' Thanh toán'),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text(' Xác nhận'),
                  );
                },
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text('Khách hàng'),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    //biển số xe
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: AbsorbPointer(
                          absorbing: !widget.customer.trangThai!,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: bienSoXe
                                      ..text = widget.customer.bienSoXe!,
                                    obscureText: false,
                                    onSubmitted: (value) {
                                      setState(() {
                                        widget.customer.bienSoXe = value;
                                        widget.customer;
                                      });
                                    },
                                    onChanged: (value) {
                                      widget.customer.bienSoXe = value;
                                      widget.customer;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Biển số xe',
                                    )),
                              ),
                              Expanded(
                                child: Text(
                                  'Tổng tiền: ${widget.customer.tongTien!.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //sạc
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
                                const Expanded(
                                  flex: 1,
                                  child: Center(child: Text('>70%')),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongSac8k! >
                                                    0) {
                                                  widget.customer.soLuongSac8k =
                                                      (widget.customer
                                                              .soLuongSac8k! -
                                                          1);
                                                }
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(widget
                                                        .customer.soLuongSac8k
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer.soLuongSac8k =
                                                    (widget.customer
                                                            .soLuongSac8k! +
                                                        1);

                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                      ],
                                    )),
                                //,
                                Expanded(
                                  flex: 1,
                                  child: AbsorbPointer(
                                    absorbing: !widget.customer.trangThai!,
                                    child: const Center(child: Text('<70%')),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongSac12k! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongSac12k = (widget
                                                          .customer
                                                          .soLuongSac12k! -
                                                      1);
                                                }
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(widget
                                                        .customer.soLuongSac12k
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer.soLuongSac12k =
                                                    (widget.customer
                                                            .soLuongSac12k! +
                                                        1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                      ],
                                    )),
                                const Expanded(flex: 3, child: Text(""))
                              ],
                            ),
                            const Row(
                              children: [],
                            ),
                            Row(
                              children: [
                                AbsorbPointer(
                                  absorbing: !widget.customer.trangThai!,
                                  child: Checkbox(
                                      value: widget.customer.muonSac,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.customer.muonSac = value;
                                          getTongTien();
                                        });
                                      }),
                                ),
                                const Text('Mượn sạc'),
                                AbsorbPointer(
                                  absorbing: !widget.customer.trangThai!,
                                  child: Checkbox(
                                      value: widget.customer.doiSac,
                                      onChanged: (value) {
                                        widget.customer.doiSac = value;
                                        setState(() {
                                          getTongTien();
                                        });
                                      }),
                                ),
                                const Text('Đợi sạc')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //ngủ
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
                              children: [
                                const Expanded(
                                    child: Center(child: Text('Ngủ ngày'))),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongNguNgay! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongNguNgay = (widget
                                                          .customer
                                                          .soLuongNguNgay! -
                                                      1);
                                                }
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(widget
                                                        .customer.soLuongNguNgay
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer.soLuongNguNgay =
                                                    (widget.customer
                                                            .soLuongNguNgay! +
                                                        1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                      ],
                                    )),
                                Expanded(
                                  child: AbsorbPointer(
                                    absorbing: !widget.customer.trangThai!,
                                    child: Checkbox(
                                        value: widget.customer.tam,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.customer.tam = value;
                                            getTongTien();
                                          });
                                        }),
                                  ),
                                ),
                                const Expanded(child: Text('Tắm'))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    child: Center(child: Text('Ngủ đêm'))),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongNguDem! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongNguDem = (widget
                                                          .customer
                                                          .soLuongNguDem! -
                                                      1);
                                                }
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(widget
                                                        .customer.soLuongNguDem
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer.soLuongNguDem =
                                                    (widget.customer
                                                            .soLuongNguDem! +
                                                        1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                      ],
                                    )),
                                const Expanded(
                                  flex: 2,
                                  child: SizedBox(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //screen nước
                    AbsorbPointer(
                        absorbing: !widget.customer.trangThai!,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Drinkswidget(
                                    customer: widget.customer,
                                    callBackFunc: callBack),
                              ),
                              Expanded(
                                flex: 1,
                                child: Tobaccowidget(
                                    customer: widget.customer,
                                    callBackFunc: callBack),
                              ),
                            ],
                          ),
                        )),
                    //thuốc
                    //cơm giặt đồ
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
                                    flex: 3,
                                    child: Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: AbsorbPointer(
                                        absorbing: !widget.customer.trangThai!,
                                        child: TextField(
                                          controller: comGia
                                            ..text = widget.customer.comGia!
                                                .toStringAsFixed(0),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nhập số tiền',
                                          ),
                                          onSubmitted: (value) {
                                            setState(() {
                                              try {
                                                widget.customer.comGia =
                                                    double.parse(value);
                                              } catch (e) {}
                                              getTongTien();
                                            });
                                          },
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: const Text('Giặt đồ: '))),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: AbsorbPointer(
                                        absorbing: !widget.customer.trangThai!,
                                        child: TextField(
                                          controller: giaGiatDo
                                            ..text = widget.customer.giaGiatDo!
                                                .toStringAsFixed(0),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nhập số tiền',
                                          ),
                                          onSubmitted: (value) {
                                            setState(() {
                                              try {
                                                widget.customer.giaGiatDo =
                                                    double.parse(value);
                                              } catch (e) {}
                                              getTongTien();
                                            });
                                          },
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //tủ
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
                              AbsorbPointer(
                                absorbing: !widget.customer.trangThai!,
                                child: RadioMenuButton(
                                  value: 25000,
                                  groupValue: widget.customer.giaTu,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.customer.giaTu =
                                          double.parse(value.toString());
                                      getTongTien();
                                    });
                                  },
                                  child: const Text('Tuần'),
                                ),
                              ),
                              AbsorbPointer(
                                absorbing: !widget.customer.trangThai!,
                                child: RadioMenuButton(
                                  value: 100000,
                                  groupValue: widget.customer.giaTu,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.customer.giaTu =
                                          double.parse(value.toString());
                                      getTongTien();
                                    });
                                  },
                                  child: const Text('Tháng'),
                                ),
                              ),
                              AbsorbPointer(
                                absorbing: !widget.customer.trangThai!,
                                child: RadioMenuButton(
                                  value: 0,
                                  groupValue: widget.customer.giaTu,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.customer.giaTu =
                                          double.parse(value.toString());
                                      getTongTien();
                                    });
                                  },
                                  child: const Text('Không'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //ghi chú
                    Card(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: AbsorbPointer(
                          absorbing: !widget.customer.trangThai!,
                          child: TextField(
                            controller: ghiChu..text = widget.customer.ghiChu!,
                            obscureText: false,
                            minLines: 2,
                            maxLines: 2,
                            onChanged: (value) {
                              setState(() {
                                try {
                                  widget.customer.ghiChu = value;
                                } catch (e) {}
                                getTongTien();
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ghi chú',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            )),
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
