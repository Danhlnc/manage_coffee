class Taboccomodel {
  String? _iId;
  String? _tobaccoName;
  int? _price;
  int? _countStore;

  Taboccomodel(
      {String? iId, String? tobaccoName, int? price, int? countStore}) {
    if (iId != null) {
      _iId = iId;
    }
    if (tobaccoName != null) {
      _tobaccoName = tobaccoName;
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
  String? get tobaccoName => _tobaccoName;
  set tobaccoName(String? tobaccoName) => _tobaccoName = tobaccoName;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get countStore => _countStore;
  set countStore(int? countStore) => _countStore = countStore;

  Taboccomodel.fromJson(Map<String, dynamic> json) {
    _iId = json['_id'];
    _tobaccoName = json['tobaccoName'];
    _price = int.parse(json['price'].toString());
    _countStore = int.parse(json['countStore'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['tobaccoName'] = _tobaccoName;
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
    data['$oid'] = _oid;
    return data;
  }
}
