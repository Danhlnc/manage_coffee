import 'package:flutter/material.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:tscoffee/model/taboccomodel.dart';

// ignore: must_be_immutable
class Tobaccolistdialog extends StatefulWidget {
  List<Taboccobillmodel> listThuoc = [];
  List<Taboccomodel> listSearch = [];
  Tobaccolistdialog({super.key, required this.listThuoc});

  @override
  _TobaccolistdialogState createState() => _TobaccolistdialogState();
}

class _TobaccolistdialogState extends State<Tobaccolistdialog> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: AlertDialog(
        title: Column(
          children: [
            Container(
              width: 350,
              height: 50,
              child: TextField(
                obscureText: false,
                onChanged: (value) {
                  if (value != "") {
                    widget.listSearch.clear();
                    for (var action in listAllThuoc) {
                      if (action.tobaccoName!.toLowerCase().contains(value)) {
                        widget.listSearch.add(action);
                      }
                    }
                    setState(() {
                      listAllThuocSearch = [...widget.listSearch];
                    });
                  } else {
                    setState(() {
                      listAllThuocSearch = [...listAllThuoc];
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
            Container(
              width: 400,
              height: 330,
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: 330,
                  child: ListView.builder(
                    itemCount: listAllThuocSearch.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ElevatedButton(
                        onPressed: () {
                          Taboccomodel newTabocco = Taboccomodel(
                              tobaccoName:
                                  listAllThuocSearch[index].tobaccoName,
                              countStore: listAllThuocSearch[index].countStore,
                              price: listAllThuocSearch[index].price);
                          bool add = true;

                          Taboccobillmodel newMap =
                              Taboccobillmodel(taboccomodel: newTabocco);
                          newMap.soLuongBan = 1;
                          newMap.taboccomodel = newTabocco;
                          if (widget.listThuoc.length != 0) {
                            for (var item in listThuoc) {
                              if (item.taboccomodel!.tobaccoName ==
                                  newTabocco.tobaccoName) {
                                add = false;
                              }
                            }
                            if (add == true) {
                              widget.listThuoc.add(newMap);
                              listThuoc = widget.listThuoc;
                            }
                          } else {
                            Taboccomodel newTabocco = Taboccomodel(
                                tobaccoName:
                                    listAllThuocSearch[index].tobaccoName,
                                countStore:
                                    listAllThuocSearch[index].countStore,
                                price: listAllThuocSearch[index].price);

                            newMap.taboccomodel = newTabocco;
                            newMap.soLuongBan = 1;
                            if (newMap.soLuongBan != -1) {
                              widget.listThuoc.add(newMap);
                              listThuoc = widget.listThuoc;
                            }
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          listAllThuocSearch[index].tobaccoName.toString() +
                              " : " +
                              listAllThuocSearch[index].price.toString(),
                          style: TextStyle(
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
