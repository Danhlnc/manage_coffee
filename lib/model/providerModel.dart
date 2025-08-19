import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/comboModel.dart';
import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/drinkmodel.dart';
import 'package:tscoffee/model/spendmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';
import 'package:tscoffee/model/taboccomodel.dart';

class ProviderModel extends ChangeNotifier {
  List<spendmodel> _listSpend = [];
  List<spendmodel> get listSpend => _listSpend;
  set listSpend(List<spendmodel> listSpend) => _listSpend = listSpend;

  List<Map<Billmodel, Color>> _listBillsSearch = [];
  List<Map<Billmodel, Color>> get listBillsSearch => _listBillsSearch;
  set listBillsSearch(List<Map<Billmodel, Color>> listBillsSearch) =>
      _listBillsSearch = listBillsSearch;
  updatelistBillsSearch(listBillsSearch) {
    _listBillsSearch = listBillsSearch;
    notifyListeners();
  }

  removelistBillsSearch(index) {
    _listBillsSearch.removeAt(index);
    notifyListeners();
  }

  List<Map<Billmodel, Color>> _listBillsTotal = [];
  List<Map<Billmodel, Color>> get listBillsTotal => _listBillsTotal;
  set listBillsTotal(List<Map<Billmodel, Color>> listBillsTotal) =>
      _listBillsTotal = listBillsTotal;
  updatelistBillsTotal(listBillsTotal) {
    _listBillsTotal = listBillsTotal;
    notifyListeners();
  }

  removelistBillsTotal(index) {
    _listBillsTotal.removeAt(index);
    notifyListeners();
  }

  List<Map<Billmodel, Color>> _listBillsTotalSearch = [];
  List<Map<Billmodel, Color>> get listBillsTotalSearch => _listBillsTotalSearch;
  set listBillsTotalSearch(List<Map<Billmodel, Color>> listBillsTotalSearch) =>
      _listBillsTotalSearch = listBillsTotalSearch;
  updatelistBillsTotalSearch(listBillsTotalSearch) {
    _listBillsTotalSearch = listBillsTotalSearch;
    notifyListeners();
  }

  removelistBillsTotalSearch(index) {
    _listBillsTotalSearch.removeAt(index);
    notifyListeners();
  }

  List<Map<Billmodel, Color>> _listBillsTotalDate = [];
  List<Map<Billmodel, Color>> get listBillsTotalDate => _listBillsTotalDate;
  set listBillsTotalDate(List<Map<Billmodel, Color>> listBillsTotalDate) =>
      _listBillsTotalDate = listBillsTotalDate;
  updatelistBillsTotalDate(listBillsTotalDate) {
    _listBillsTotalDate = listBillsTotalDate;
    notifyListeners();
  }

  removelistBillsTotalDate(index) {
    _listBillsTotalDate.removeAt(index);
    notifyListeners();
  }

  List<Drinkbillmodel> _listNuoc = [];
  List<Drinkbillmodel> get listNuoc => _listNuoc;
  set listNuoc(List<Drinkbillmodel> listNuoc) => _listNuoc = listNuoc;
  updatelistNuoc(listNuoc) {
    _listNuoc = listNuoc;
    notifyListeners();
  }

  removelistNuoc(index) {
    _listNuoc.removeAt(index);
    notifyListeners();
  }

  List<Taboccobillmodel> _listThuoc = [];
  List<Taboccobillmodel> get listThuoc => _listThuoc;
  set listThuoc(List<Taboccobillmodel> listSpend) => _listThuoc = listThuoc;
  updatelistThuoc(listThuoc) {
    _listThuoc = listThuoc;
    notifyListeners();
  }

  removelistThuoc(index) {
    _listThuoc.removeAt(index);
    notifyListeners();
  }

  List<Drinkmodel> _listAllNuoc = [];
  List<Drinkmodel> get listAllNuoc => _listAllNuoc;
  set listAllNuoc(List<Drinkmodel> listAllNuoc) => _listAllNuoc = listAllNuoc;
  updatelistAllNuoc(listAllNuoc) {
    _listAllNuoc = listAllNuoc;
    notifyListeners();
  }

  removelistAllNuoc(index) {
    _listAllNuoc.removeAt(index);
    notifyListeners();
  }

  List<Taboccomodel> _listAllThuoc = [];
  List<Taboccomodel> get listAllThuoc => _listAllThuoc;
  set listAllThuoc(List<Taboccomodel> listAllThuoc) =>
      _listAllThuoc = listAllThuoc;
  updatelistAllThuoc(listAllThuoc) {
    _listAllThuoc = listAllThuoc;
    notifyListeners();
  }

  removelistAllThuoc(index) {
    _listAllThuoc.removeAt(index);
    notifyListeners();
  }

  List<Drinkmodel> _listAllNuocSearch = [];
  List<Drinkmodel> get listAllNuocSearch => _listAllNuocSearch;
  set listAllNuocSearch(List<Drinkmodel> listAllNuocSearch) =>
      _listAllNuocSearch = listAllNuocSearch;
  updatelistAllNuocSearch(listAllNuocSearch) {
    _listAllNuocSearch = listAllNuocSearch;
    notifyListeners();
  }

  removelistAllNuocSearch(index) {
    _listAllNuocSearch.removeAt(index);
    notifyListeners();
  }

  List<Taboccomodel> _listAllThuocSearch = [];
  List<Taboccomodel> get listAllThuocSearch => _listAllThuocSearch;
  set listAllThuocSearch(List<Taboccomodel> listAllThuocSearch) =>
      _listAllThuocSearch = listAllThuocSearch;
  updatelistAllThuocSearch(listAllThuocSearch) {
    _listAllThuocSearch = listAllThuocSearch;
    notifyListeners();
  }

  removelistAllThuocSearch(index) {
    _listAllThuocSearch.removeAt(index);
    notifyListeners();
  }

  List<Map<Billmodel, Color>> _listBills = [];
  List<Map<Billmodel, Color>> get listBills => _listBills;
  set listBills(List<Map<Billmodel, Color>> listBills) =>
      _listBills = listBills;
  updateListBill(listBill) {
    _listBills = listBill;
    notifyListeners();
  }

  removeListBill(index) {
    _listBills.removeAt(index);
    notifyListeners();
  }

  List<ComboModel> _listAllCombo = [];
  List<ComboModel> get listAllCombo => _listAllCombo;
  set listAllCombo(List<ComboModel> listAllCombo) =>
      _listAllCombo = listAllCombo;
  updatelistAllCombo(listAllCombo) {
    _listAllCombo = listAllCombo;
    notifyListeners();
  }

  removelistAllCombo(index) {
    _listAllCombo.removeAt(index);
    notifyListeners();
  }

  List<ComboModel> _listAllComboSearch = [];
  List<ComboModel> get listAllComboSearch => _listAllComboSearch;
  set listAllComboSearch(List<ComboModel> listAllComboSearch) =>
      _listAllComboSearch = listAllComboSearch;
  updatelistAllComboSearch(listAllComboSearch) {
    _listAllComboSearch = listAllComboSearch;
    notifyListeners();
  }

  removelistAllComboSearch(index) {
    _listAllComboSearch.removeAt(index);
    notifyListeners();
  }

  int _countTotal = 0;
  int get countTotal => _countTotal;
  set countTotal(int countTotal) => _countTotal = countTotal;

  bool _checkTT = true;
  bool get checkTT => _checkTT;
  set checkTT(bool checkTT) => _checkTT = checkTT;
  updatecheckTT(checkTT) {
    _checkTT = checkTT;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  set countsearchControllerTotal(TextEditingController searchController) =>
      _searchController = searchController;

  List<spendmodel> _listSpendTemp = [];
  List<spendmodel> get listSpendTemp => _listSpendTemp;
  set listSpendTemp(List<spendmodel> listSpendTemp) =>
      _listSpendTemp = listSpendTemp;
  List<Billmodel> parsePost(String responseBody) {
    var list = json.decode(responseBody)['result'] as List<dynamic>;
    List<Billmodel> listBillModel =
        list.map((value) => Billmodel.fromJson(value)).toList();

    return listBillModel;
  }

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  set currentPageIndex(int currentPageIndex) =>
      _currentPageIndex = currentPageIndex;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey get scaffoldKey => _scaffoldKey;

  bool _loadData = true;
  bool get loadData => _loadData;
  set loadData(bool loadData) => _loadData = loadData;
  updateloadData(loadData) {
    _loadData = loadData;
    notifyListeners();
  }

  Future<List<Billmodel>> fetch() async {
    final url =
        Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/bill');
    Map<String, dynamic> m = {};
    m['DateOne'] = DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(
            DateTime(
                dateTimeRange.start.year,
                dateTimeRange.start.month > 1
                    ? dateTimeRange.start.month - 1
                    : 12,
                dateTimeRange.start.day - 1,
                7)))
        .toString();
    m['DateTwo'] = dateTimeRange.end.toString();
    final response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: jsonEncode(m),
    );

    final listModelParse = parsePost(response.body);

    notifyListeners();
    return listModelParse;
  }

  List<spendmodel> parseSpend(String responseBody) {
    var list = json.decode(responseBody)['result'] as List<dynamic>;
    List<spendmodel> listSpend =
        list.map((value) => spendmodel.fromJson(value)).toList();

    notifyListeners();
    return listSpend;
  }

  List<Drinkmodel> drinkParsePost(String responseBody) {
    var list = json.decode(responseBody)['result'] as List<dynamic>;
    List<Drinkmodel> listBillModel =
        list.map((value) => Drinkmodel.fromJson(value)).toList();

    notifyListeners();
    return listBillModel;
  }

  List<Taboccomodel> taboccoParsePost(String responseBody) {
    var list = json.decode(responseBody)['result'] as List<dynamic>;
    List<Taboccomodel> listBillModel =
        list.map((value) => Taboccomodel.fromJson(value)).toList();

    notifyListeners();
    return listBillModel;
  }

  List<ComboModel> ComboParsePost(String responseBody) {
    var list = json.decode(responseBody)['result'] as List<dynamic>;
    List<ComboModel> listCombo =
        list.map((value) => ComboModel.fromJson(value)).toList();

    notifyListeners();
    return listCombo;
  }

  Future<List<spendmodel>> fetchSpend() async {
    final url =
        Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/spends');
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final listModelParse = parseSpend(response.body);
    for (var element in listModelParse) {
      element.createdOn =
          DateFormat("yyyy-MM-dd HH:mm").parse(element.createdOn.toString());
    }
    listModelParse
        .sort((a, b) => a.createdOn!.compareTo(b.createdOn as DateTime));

    notifyListeners();
    return listModelParse;
  }

  Future<List<Drinkmodel>> fetchDrinks() async {
    final url =
        Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/drinks');
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final listModelParse = drinkParsePost(response.body);

    notifyListeners();
    return listModelParse;
  }

  Future<List<Taboccomodel>> fetchTabocco() async {
    final url =
        Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/taboccos');
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final listModelParse = taboccoParsePost(response.body);

    notifyListeners();
    return listModelParse;
  }

  Future<List<ComboModel>> fetchCombo() async {
    final url =
        Uri.parse('https://tscoffee-server-1.onrender.com/v1/boards/combo');
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final listModelParse = ComboParsePost(response.body);

    notifyListeners();
    return listModelParse;
  }

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

  loadDataTotal() {
    fetch().then((onValue) {
      listNuoc.clear();
      listThuoc.clear();
      listBillsTotal.clear();
      listBills.clear();
      listBillsTotalDate.clear();
      for (var item in onValue) {
        Map<Billmodel, Color> newmap = {item: Colors.white};
        listBillsTotal.add(newmap);
      }
      listBillsTotal.sort((b, a) => a.keys.first.createdOn!
          .compareTo(b.keys.first.createdOn as DateTime));
      listBills = [...listBillsTotal];
      var listPro = [...listBills];
      for (var action in listPro) {
        if (DateFormat('yyyy-MM-dd').format(
                    DateTime.parse(action.keys.first.createdOn.toString())) !=
                DateFormat('yyyy-MM-dd').format(date) ||
            action.keys.first.trangThai == false) {
          listBills.remove(action);
        }
      }
      listBillsTotalDate = [...listBillsTotal];
      var listProDate = [...listBillsTotalDate];
      for (var action in listProDate) {
        if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
            action.keys.first.createdOn!.isAfter(dateTimeRange.start) &&
            action.keys.first.bienSoXe!
                .toUpperCase()
                .contains(searchController.text.toUpperCase()) &&
            (checkTT == true ? action.keys.first.trangThai == true : true)) {
        } else {
          listBillsTotalDate.remove(action);
        }
      }

      updatelistBillsTotal(listBillsTotal);
      updatelistBillsTotalDate(listBillsTotalDate);
      updateListBill(listBills);
      updateloadData(false);
    });
    fetchDrinks().then((onValue) {
      listAllNuoc = [];
      listAllNuoc = [...onValue];
      listAllNuocSearch = [...onValue];
    });
    fetchTabocco().then((onValue) {
      listAllThuoc = [];
      listAllThuoc = [...onValue];
      listAllThuocSearch = [...onValue];
    });
    fetchCombo().then((onValue) {
      listAllCombo = [];
      listAllCombo = [...onValue];
      listAllComboSearch = [...onValue];
    });
    fetchSpend().then((onValue) {
      update(onValue);
      updateListTemp(dateTimeRange);
      getTotalCount();
    });
  }
}
