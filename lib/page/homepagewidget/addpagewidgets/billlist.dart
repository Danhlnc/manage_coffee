import 'package:flutter/material.dart';
import 'package:tscoffee/page/home.dart';

import '../../../model/billmodel.dart';

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
              // ignore: prefer_interpolation_to_compose_strings
              "${widget.Bill.keys.first.createdOn!.hour}:${widget.Bill.keys.first.createdOn!.minute < 10 ? "0" + widget.Bill.keys.first.createdOn!.minute.toString() : widget.Bill.keys.first.createdOn!.minute}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.Bill.keys.first.bienSoXe.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }
}
