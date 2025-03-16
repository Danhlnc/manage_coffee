class Drinkmodel {
  String? _iId;
  String? _drinkName;
  int? _price;
  int? _countStore;

  Drinkmodel({String? iId, String? drinkName, int? price, int? countStore}) {
    if (iId != null) {
      _iId = iId;
    }
    if (drinkName != null) {
      _drinkName = drinkName;
    }
    if (price != null) {
      _price = price;
    }
    if (countStore != null) {
      _countStore = countStore;
    }
  }

  String? get iId => _iId;
  set iId(String? iId) => _iId = iId;
  String? get drinkName => _drinkName;
  set drinkName(String? drinkName) => _drinkName = drinkName;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get countStore => _countStore;
  set countStore(int? countStore) => _countStore = countStore;

  Drinkmodel.fromJson(Map<String, dynamic> json) {
    _iId = json['_id'];
    _drinkName = json['drinkName'];
    _price = int.parse(json['price'].toString());
    _countStore = int.parse(json['countStore'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _iId;
    data['drinkName'] = _drinkName;
    data['price'] = _price;
    data['countStore'] = _countStore;
    return data;
  }
}

class Id {
  String? _oid;

  Id({String? oid}) {
    if (oid != null) {
      _oid = oid;
    }
  }

  String? get oid => _oid;
  set oid(String? oid) => _oid = oid;

  Id.fromJson(Map<String, dynamic> json) {
    _oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
