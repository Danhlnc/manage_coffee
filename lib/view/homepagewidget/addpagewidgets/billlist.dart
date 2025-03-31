import 'package:flutter/material.dart';

import '../../../model/billmodel.dart';
import '../../home.dart';

// ignore: must_be_immutable
class Bills extends StatefulWidget {
  Map<Billmodel, Color> Bill;
  Color color = Colors.white;

  Home? home;
  Bills({super.key, required this.Bill});
  void setColor(Home home) {
    this.home = home;
  }

  @override
  // ignore: library_private_types_in_public_api
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "${widget.Bill.keys.first.createdOn!.day}"
              "/"
              "${widget.Bill.keys.first.createdOn!.month}"
              " "
              // ignore: prefer_interpolation_to_compose_strings
              "${widget.Bill.keys.first.createdOn!.hour}:${widget.Bill.keys.first.createdOn!.minute < 10 ? "0" + widget.Bill.keys.first.createdOn!.minute.toString() : widget.Bill.keys.first.createdOn!.minute}",
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Text(
              widget.Bill.keys.first.bienSoXe.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: widget.Bill.keys.first.trangThai == true
                      ? (widget.Bill.keys.first.ghiChu != ""
                          ? Colors.green
                          : Colors.red)
                      : widget.Bill.keys.first.ghiChu != ""
                          ? Colors.green
                          : Colors.blue),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: widget.Bill.keys.first.chuyenKhoan == true
              ? Text("Chuyển Khoản",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: widget.Bill.keys.first.trangThai == true
                          ? (widget.Bill.keys.first.ghiChu != ""
                              ? Colors.green
                              : Colors.red)
                          : widget.Bill.keys.first.ghiChu != ""
                              ? Colors.green
                              : Colors.blue))
              : const SizedBox(),
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.Bill.keys.first.tongTien.toString(),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: widget.Bill.keys.first.trangThai == true
                    ? (widget.Bill.keys.first.ghiChu != ""
                        ? Colors.green
                        : Colors.red)
                    : widget.Bill.keys.first.ghiChu != ""
                        ? Colors.green
                        : Colors.blue),
          ),
        ),
      ],
    ));
  }
}
