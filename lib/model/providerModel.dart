import 'package:flutter/material.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/drinkmodel.dart';
import 'package:tscoffee/model/spendmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:tscoffee/model/taboccomodel.dart';

class ProviderModel extends ChangeNotifier {
  List<spendmodel> _listSpend = [];
  List<spendmodel>? get listSpend => _listSpend;
  set listSpend(List<spendmodel>? listSpend) => _listSpend = listSpend!;
  List<spendmodel> _listSpendTemp = [];

  List<Map<Billmodel, Color>> listBills = [];
  List<Map<Billmodel, Color>> listBillsSearch = [];
  List<Map<Billmodel, Color>> listBillsTotal = [];
  List<Map<Billmodel, Color>> listBillsTotalSearch = [];
  List<Map<Billmodel, Color>> listBillsTotalDate = [];
  List<Drinkbillmodel> listNuoc = [];
  List<Taboccobillmodel> listThuoc = [];
  List<Drinkmodel> listAllNuoc = [];
  List<Taboccomodel> listAllThuoc = [];
  List<Drinkmodel> listAllNuocSearch = [];
  List<Taboccomodel> listAllThuocSearch = [];
  int _countTotal = 0;
  int? get countTotal => _countTotal;
  set countTotal(int? countTotal) => _countTotal = countTotal!;
  List<spendmodel>? get listSpendTemp => _listSpendTemp;
  set listSpendTemp(List<spendmodel>? listSpendTemp) =>
      _listSpendTemp = listSpendTemp!;

  update(listSpend) {
    _listSpend = listSpend;
    notifyListeners();
  }

  getTotalCount() {
    _countTotal = 0;
    for (var element in _listSpendTemp) {
      _countTotal += element.count!;
    }
    notifyListeners();
  }

  updateListTemp(DateTimeRange date) {
    _listSpendTemp = [..._listSpend];
    for (var element in _listSpend) {
      if (element.createdOn!.isAfter(date.start) &&
          element.createdOn!.isBefore(date.end)) {
      } else {
        _listSpendTemp.remove(element);
      }
    }
    notifyListeners();
  }

  removeSpend(index) {
    _listSpend.removeAt(index);
    notifyListeners();
  }
}
