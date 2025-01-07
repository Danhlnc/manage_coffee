import 'package:flutter/material.dart';
import 'package:tscoffee/model/spendmodel.dart';

class ProviderModel extends ChangeNotifier {
  List<spendmodel> _listSpend = [];
  List<spendmodel>? get listSpend => _listSpend;
  set listSpend(List<spendmodel>? listSpend) => _listSpend = listSpend!;
  List<spendmodel> _listSpendTemp = [];

  int _countTotal = 0;
  int? get countTotal => _countTotal;
  set countTotal(int? countTotal) => _countTotal = countTotal!;
  List<spendmodel>? get listSpendTemp => _listSpendTemp;
  set listSpendTemp(List<spendmodel>? listSpendTemp) =>
      _listSpendTemp = listSpendTemp!;

  update(listSpend) {
    this._listSpend = listSpend;
    notifyListeners();
  }

  getTotalCount() {
    this._countTotal = 0;
    _listSpendTemp.forEach((element) {
      this._countTotal += element.count!;
    });
    notifyListeners();
  }

  updateListTemp(DateTimeRange date) {
    this._listSpendTemp = [...this._listSpend];
    this._listSpend!.forEach((element) {
      if (element.createdOn!.isAfter(date.start) &&
          element.createdOn!.isBefore(date.end)) {
      } else {
        _listSpendTemp.remove(element);
      }
    });
    notifyListeners();
  }

  removeSpend(index) {
    this._listSpend.removeAt(index);
    notifyListeners();
  }
}
