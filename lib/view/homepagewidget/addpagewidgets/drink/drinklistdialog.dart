import 'package:flutter/material.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/drinkmodel.dart';

// ignore: must_be_immutable
class Drinklistdialog extends StatefulWidget {
  List<Drinkbillmodel> listNuoc;

  List<Drinkmodel> listSearch = [];
  Drinklistdialog({super.key, required this.listNuoc});

  @override
  _DrinklistdialogState createState() => _DrinklistdialogState();
}

class _DrinklistdialogState extends State<Drinklistdialog> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: AlertDialog(
        title: Column(
          children: [
            SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                obscureText: false,
                onChanged: (value) {
                  if (value != "") {
                    widget.listSearch.clear();
                    for (var action in listAllNuoc) {
                      if (action.drinkName!
                          .toString()
                          .toUpperCase()
                          .contains(value.toUpperCase())) {
                        widget.listSearch.add(action);
                      }
                    }
                    setState(() {
                      listAllNuocSearch = [...widget.listSearch];
                    });
                  } else {
                    setState(() {
                      listAllNuocSearch = [...listAllNuoc];
                    });
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Tìm kiếm",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 330,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  height: 330,
                  child: ListView.builder(
                    itemCount: listAllNuocSearch.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      if (listAllNuocSearch[index].drinkName != "Nước 18000" &&
                          listAllNuocSearch[index].drinkName != "Nước 20000" &&
                          listAllNuocSearch[index].drinkName != "Nước 15000" &&
                          listAllNuocSearch[index].drinkName != "Cà phê đen" &&
                          listAllNuocSearch[index].drinkName != "Cà phê sữa" &&
                          listAllNuocSearch[index].drinkName != "Đậu Xanh" &&
                          listAllNuocSearch[index].drinkName !=
                              "Nước ép tươi" &&
                          listAllNuocSearch[index].drinkName != "Mía" &&
                          listAllNuocSearch[index].drinkName != "Bạc xỉu" &&
                          listAllNuocSearch[index].drinkName != "Mì ly" &&
                          listAllNuocSearch[index].drinkName != "Đá me" &&
                          listAllNuocSearch[index].drinkName != "Suối" &&
                          listAllNuocSearch[index].countStore == 0) {
                        return const SizedBox();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          Drinkmodel newDrink = Drinkmodel(
                              drinkName: listAllNuocSearch[index].drinkName,
                              countStore: listAllNuocSearch[index].countStore,
                              price: listAllNuocSearch[index].price);
                          bool add = true;

                          Drinkbillmodel newMap =
                              Drinkbillmodel(drinkmodel: newDrink);
                          newMap.soLuongBan = 1;
                          newMap.drinkmodel = newDrink;
                          if (widget.listNuoc.isNotEmpty) {
                            for (var item in listNuoc) {
                              if (item.drinkmodel!.drinkName ==
                                  newDrink.drinkName) {
                                add = false;
                              }
                            }
                            if (add == true) {
                              widget.listNuoc.add(newMap);
                              listNuoc = widget.listNuoc;
                            }
                          } else {
                            Drinkmodel newDrink = Drinkmodel(
                                drinkName: listAllNuocSearch[index].drinkName,
                                countStore: listAllNuocSearch[index].countStore,
                                price: listAllNuocSearch[index].price);

                            newMap.drinkmodel = newDrink;
                            newMap.soLuongBan = 1;
                            if (newMap.soLuongBan != -1) {
                              widget.listNuoc.add(newMap);
                              listNuoc = widget.listNuoc;
                            }
                          }
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "${listAllNuocSearch[index].drinkName} : ${listAllNuocSearch[index].price}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: const [],
      ),
    );
  }
}
