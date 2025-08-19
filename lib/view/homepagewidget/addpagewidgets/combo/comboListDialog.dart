import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/providerModel.dart';

// ignore: must_be_immutable
class ComboListDialog extends StatefulWidget {
  Function callBackFunc;
  Billmodel customer;
  ComboListDialog(
      {super.key, required this.customer, required this.callBackFunc});

  @override
  _DrinklistdialogState createState() => _DrinklistdialogState();
}

class _DrinklistdialogState extends State<ComboListDialog> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: AlertDialog(
        title: Column(
          children: [
            SizedBox(
              width: 400,
              height: 330,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 2),
                  width: 400,
                  height: 330,
                  child: ListView.builder(
                    itemCount:
                        context.read<ProviderModel>().listAllCombo.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 2, bottom: 2),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.customer.listCombo = [];
                              widget.customer.listCombo.add(context
                                  .read<ProviderModel>()
                                  .listAllCombo[index]);
                              print(widget.customer);
                            });
                            widget.callBackFunc;
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "${context.read<ProviderModel>().listAllCombo[index].name} : ${context.read<ProviderModel>().listAllCombo[index].price}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
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
