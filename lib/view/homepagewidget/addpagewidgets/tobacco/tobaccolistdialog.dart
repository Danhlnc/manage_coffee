import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/providerModel.dart';
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
            SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                obscureText: false,
                onChanged: (value) {
                  if (value != "") {
                    widget.listSearch.clear();
                    for (var action
                        in context.read<ProviderModel>().listAllThuoc) {
                      if (action.tobaccoName!.toLowerCase().contains(value)) {
                        widget.listSearch.add(action);
                      }
                    }
                    setState(() {
                      context.read<ProviderModel>().listAllThuocSearch = [
                        ...widget.listSearch
                      ];
                    });
                  } else {
                    setState(() {
                      context.read<ProviderModel>().listAllThuocSearch = [
                        ...context.read<ProviderModel>().listAllThuoc
                      ];
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
                    itemCount:
                        context.read<ProviderModel>().listAllThuocSearch.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ElevatedButton(
                        onPressed: () {
                          Taboccomodel newTabocco = Taboccomodel(
                              tobaccoName: context
                                  .read<ProviderModel>()
                                  .listAllThuocSearch[index]
                                  .tobaccoName,
                              countStore: context
                                  .read<ProviderModel>()
                                  .listAllThuocSearch[index]
                                  .countStore,
                              price: context
                                  .read<ProviderModel>()
                                  .listAllThuocSearch[index]
                                  .price);
                          bool add = true;

                          Taboccobillmodel newMap =
                              Taboccobillmodel(taboccomodel: newTabocco);
                          newMap.soLuongBan = 1;
                          newMap.taboccomodel = newTabocco;
                          if (widget.listThuoc.isNotEmpty) {
                            for (var item
                                in context.read<ProviderModel>().listThuoc) {
                              if (item.taboccomodel!.tobaccoName ==
                                  newTabocco.tobaccoName) {
                                add = false;
                              }
                            }
                            if (add == true) {
                              widget.listThuoc.add(newMap);
                              context.read<ProviderModel>().listThuoc =
                                  widget.listThuoc;
                            }
                          } else {
                            Taboccomodel newTabocco = Taboccomodel(
                                tobaccoName: context
                                    .read<ProviderModel>()
                                    .listAllThuocSearch[index]
                                    .tobaccoName,
                                countStore: context
                                    .read<ProviderModel>()
                                    .listAllThuocSearch[index]
                                    .countStore,
                                price: context
                                    .read<ProviderModel>()
                                    .listAllThuocSearch[index]
                                    .price);

                            newMap.taboccomodel = newTabocco;
                            newMap.soLuongBan = 1;
                            if (newMap.soLuongBan != -1) {
                              widget.listThuoc.add(newMap);
                              context.read<ProviderModel>().listThuoc =
                                  widget.listThuoc;
                            }
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "${context.read<ProviderModel>().listAllThuocSearch[index].tobaccoName} : ${context.read<ProviderModel>().listAllThuocSearch[index].price}",
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
