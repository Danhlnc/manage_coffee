class ComboModel {
  String? _iId;
  int? _id;
  String? _name;
  int? _price;

  ComboModel({String? iId, int? id, String? name, int? price}) {
    if (iId != null) {
      _iId = iId;
    }
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (price != null) {
      _price = price;
    }
  }
  String? get iId => _iId;
  set iId(String? iId) => _iId = iId;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get id => _id;
  set id(int? id) => _id = id;
  ComboModel.fromJson(Map<String, dynamic> json) {
    _iId = json['_id'];
    _id =int.parse(json['id'].toString());
    _name = json['name'];
    _price = int.parse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['price'] = this._price;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}