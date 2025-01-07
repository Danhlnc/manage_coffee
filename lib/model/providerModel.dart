import 'package:flutter/material.dart';
import 'package:tscoffee/model/spendmodel.dart';

class ProviderModel extends ChangeNotifier {
  List<spendmodel> _listSpend = [];
  List<spendmodel>? get listSpend => _listSpend;
  set listSpend(List<spendmodel>? listSpend) => _listSpend = listSpend!;
  update(listSpend) {
    this._listSpend = listSpend;
    notifyListeners();
  }

  removeSpend(index) {
    this._listSpend.removeAt(index);
    notifyListeners();
  }
}
