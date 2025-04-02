import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:http/http.dart' as http;
import 'package:tscoffee/view/homepagewidget/addpagewidgets/combo/comboswidget.dart';
import 'package:tscoffee/view/homepagewidget/addpagewidgets/datetime.dart';
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
      if (widget.customer.listCombo.isNotEmpty &&
          widget.customer.listNuoc.isEmpty) {
        widget.customer.listCombo.forEach((action) async {
          if (action.id != 5 && widget.customer.listNuoc.isEmpty) {
            await showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('Vui lòng chọn nước!'),
                  );
                });
          } else if (widget.customer.bienSoXe == "") {
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
            widget.customer.modifyOn = DateTime.utc(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute);
            widget.customer.trangThai = trangThai;
            widget.customer.createdBy =
                WebStorage.instance.sessionId.toString();
            widget.customer.modifyBy = WebStorage.instance.sessionId.toString();
            var details = {widget.customer: Colors.white};
            var test = widget.customer.toJson();
            test.remove('_id');
            if (staTus) {
              if (widget.customer.doiSac == true) {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Chưa sạc xe không được thanh toán!'),
                      );
                    });
              } else {
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
              }
            } else {
              EasyLoading.show(status: 'loading...');
              setState(() {
                widget.loading = true;
              });
              updateBill(widget.customer.toJson()).then((onValue) {
                try {
                  if (widget.customer.listNuoc.first.soLuongBan! > 0) {
                    for (var element in listAllNuoc) {
                      if (element.drinkName ==
                          widget
                              .customer.listNuoc.first.drinkmodel!.drinkName) {
                        try {
                          element.countStore = (element.countStore as int) -
                              (widget.customer.listNuoc.first.soLuongBan
                                  as int);

                          updateDrink(element.toJson()).then((onValue) {
                            setState(() {});
                          });
                        } catch (e) {}
                      }
                    }
                  }
                } catch (e) {}

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
        });
      } else if (widget.customer.bienSoXe == "") {
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
        widget.customer.createdBy = WebStorage.instance.sessionId.toString();
        widget.customer.modifyBy = WebStorage.instance.sessionId.toString();
        widget.customer.modifyOn = DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute);
        widget.customer.trangThai = trangThai;
        var details = {widget.customer: Colors.white};
        var test = widget.customer.toJson();
        test.remove('_id');
        if (staTus) {
          if (widget.customer.doiSac == true) {
            await showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('Chưa sạc xe không được thanh toán!'),
                  );
                });
          } else {
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
          }
        } else {
          EasyLoading.show(status: 'loading...');
          setState(() {
            widget.loading = true;
          });
          updateBill(widget.customer.toJson()).then((onValue) {
            try {
              if (widget.customer.listNuoc.first.soLuongBan! > 0) {
                for (var element in listAllNuoc) {
                  if (element.drinkName ==
                      widget.customer.listNuoc.first.drinkmodel!.drinkName) {
                    try {
                      element.countStore = (element.countStore as int) -
                          (widget.customer.listNuoc.first.soLuongBan as int);

                      updateDrink(element.toJson()).then((onValue) {
                        setState(() {});
                      });
                    } catch (e) {}
                  }
                }
              }
            } catch (e) {}

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
    widget.customer.tongTien = widget.customer.soLuongSac8k! * 10000 +
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
    callBack("");
  }

  TextEditingController bienSoXe = TextEditingController();
  TextEditingController createdOn = TextEditingController();
  TextEditingController ghiChu = TextEditingController();
  String sac = '';
  bool? isCheckedDay = false;
  bool isChecktrangThai = true;
  bool? isCheckedNight = false;
  bool? isCheckedTam = false;
  bool? isCheckedMuonSac = false;
  TextEditingController comGia = TextEditingController();
  TextEditingController giaGiatDo = TextEditingController();
  String giaTu = '';

  @override
  Widget build(BuildContext context) {
    if (widget.customer.trangThai == false &&
        WebStorage.instance.sessionId == "admin") {
      isChecktrangThai = false;
    } else if (widget.customer.trangThai == true &&
            WebStorage.instance.sessionId == widget.customer.createdBy ||
        widget.customer.trangThai == true && widget.customer.createdBy == "" ||
        widget.customer.trangThai == true &&
            widget.customer.createdBy == null) {
      isChecktrangThai = false;
    }
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
                      CreateCustomer(false, false);
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text(' Xác nhận'),
                  );
                },
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        widget.customer.createdBy.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: AbsorbPointer(
                      absorbing: isChecktrangThai,
                      child: Card(
                        child: TextField(
                          controller: createdOn
                            ..text = DateFormat("yyyy-MM-dd HH:mm:ss")
                                .format(DateTime.parse(
                                    widget.customer.createdOn.toString()))
                                .toString(),
                          obscureText: false,
                          onSubmitted: (value) {
                            setState(() {
                              widget.customer.createdOn = DateTime.parse(value);
                              widget.customer;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AbsorbPointer(
                                absorbing: isChecktrangThai,
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
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Tổng tiền: ${widget.customer.tongTien!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: widget.customer.chuyenKhoan,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.customer.chuyenKhoan = value;
                                          });
                                        }),
                                    const Text('CK')
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    //sạc
                    AbsorbPointer(
                      absorbing: isChecktrangThai,
                      child: Container(
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
                                                icon: const Icon(Icons
                                                    .remove_circle_outlined),
                                                onPressed: () {
                                                  if (widget.customer
                                                          .soLuongSac8k! >
                                                      0) {
                                                    widget.customer
                                                        .soLuongSac8k = (widget
                                                            .customer
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
                                      absorbing: isChecktrangThai,
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
                                                icon: const Icon(Icons
                                                    .remove_circle_outlined),
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
                                                          .customer
                                                          .soLuongSac12k
                                                          .toString())))),
                                          Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                    Icons.add_circle_outlined),
                                                onPressed: () {
                                                  widget.customer
                                                      .soLuongSac12k = (widget
                                                          .customer
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
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        const Text(' Mượn Sạc:'),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongMuonSac! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongMuonSac = (widget
                                                          .customer
                                                          .soLuongMuonSac! -
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
                                                        .customer.soLuongMuonSac
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer.soLuongMuonSac =
                                                    (widget.customer
                                                            .soLuongMuonSac! +
                                                        1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            ))
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [Text('')],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        const Text(' Sạc Nhanh:'),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongSacNhanh! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongSacNhanh = (widget
                                                          .customer
                                                          .soLuongSacNhanh! -
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
                                                    child: Text(widget.customer
                                                        .soLuongSacNhanh
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer
                                                    .soLuongSacNhanh = (widget
                                                        .customer
                                                        .soLuongSacNhanh! +
                                                    1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            )),
                                        const Text('  trên 50%  '),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.remove_circle_outlined),
                                              onPressed: () {
                                                if (widget.customer
                                                        .soLuongSacNhanh20k! >
                                                    0) {
                                                  widget.customer
                                                      .soLuongSacNhanh20k = (widget
                                                          .customer
                                                          .soLuongSacNhanh20k! -
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
                                                    child: Text(widget.customer
                                                        .soLuongSacNhanh20k
                                                        .toString())))),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                  Icons.add_circle_outlined),
                                              onPressed: () {
                                                widget.customer
                                                    .soLuongSacNhanh20k = (widget
                                                        .customer
                                                        .soLuongSacNhanh20k! +
                                                    1);
                                                getTongTien();
                                                setState(() {});
                                              },
                                            ))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: widget.customer.doiSac,
                                            onChanged: (value) {
                                              widget.customer.doiSac = value;
                                              setState(() {
                                                getTongTien();
                                              });
                                            }),
                                        const Text('Đợi sạc')
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //ngủ
                    AbsorbPointer(
                      absorbing: isChecktrangThai,
                      child: Container(
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
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                            child:
                                                Center(child: Text('Ngủ đêm'))),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .remove_circle_outlined),
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
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Text(widget
                                                                .customer
                                                                .soLuongNguDem
                                                                .toString())))),
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .add_circle_outlined),
                                                      onPressed: () {
                                                        widget.customer
                                                            .soLuongNguDem = (widget
                                                                .customer
                                                                .soLuongNguDem! +
                                                            1);
                                                        getTongTien();
                                                        setState(() {});
                                                      },
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Center(
                                                child: Text('Ngủ ngày'))),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .remove_circle_outlined),
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
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Text(widget
                                                                .customer
                                                                .soLuongNguNgay
                                                                .toString())))),
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .add_circle_outlined),
                                                      onPressed: () {
                                                        widget.customer
                                                            .soLuongNguNgay = (widget
                                                                .customer
                                                                .soLuongNguNgay! +
                                                            1);
                                                        getTongTien();
                                                        setState(() {});
                                                      },
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Center(child: Text('Tắm'))),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .remove_circle_outlined),
                                                      onPressed: () {
                                                        if (widget.customer
                                                                .soLuongTam! >
                                                            0) {
                                                          widget.customer
                                                              .soLuongTam = (widget
                                                                  .customer
                                                                  .soLuongTam! -
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
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Text(widget
                                                                .customer
                                                                .soLuongTam
                                                                .toString())))),
                                                Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(Icons
                                                          .add_circle_outlined),
                                                      onPressed: () {
                                                        widget.customer
                                                            .soLuongTam = (widget
                                                                .customer
                                                                .soLuongTam! +
                                                            1);
                                                        getTongTien();
                                                        setState(() {});
                                                      },
                                                    )),
                                              ],
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Comboswidget(
                                      customer: widget.customer,
                                      callBackFunc: callBack))
                            ],
                          ),
                        ),
                      ),
                    ),
                    //screen nước
                    AbsorbPointer(
                        absorbing: isChecktrangThai,
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
                                        absorbing: isChecktrangThai,
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
                                        absorbing: isChecktrangThai,
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
                                absorbing: isChecktrangThai,
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
                                absorbing: isChecktrangThai,
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
                                absorbing: isChecktrangThai,
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
                          absorbing: isChecktrangThai,
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

  double getTotalComboPrice(List<ComboModel> list) {
    double total = 0;
    for (var item in list) {
      total += num.parse(item.price.toString());
    }
    return total;
  }
}
