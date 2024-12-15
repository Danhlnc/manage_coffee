import 'package:tscoffee/model/drinkmodel.dart';

class Drinkbillmodel {
  String? _sId;
  Drinkmodel? _drinkmodel;
  int? _soLuongBan;

  Drinkbillmodel({String? sId, Drinkmodel? drinkmodel, int? soLuongBan}) {
    if (sId != null) {
      _sId = sId;
    }
    if (drinkmodel != null) {
      _drinkmodel = drinkmodel;
    }
    if (soLuongBan != null) {
      _soLuongBan = soLuongBan;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  Drinkmodel? get drinkmodel => _drinkmodel;
  set drinkmodel(Drinkmodel? drinkmodel) => _drinkmodel = drinkmodel;
  int? get soLuongBan => _soLuongBan;
  set soLuongBan(int? soLuongBan) => _soLuongBan = soLuongBan;

  Drinkbillmodel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _drinkmodel = json['drinkmodel'] != null
        ? Drinkmodel.fromJson(json['drinkmodel'])
        : null;
    _soLuongBan = json['soLuongBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    if (_drinkmodel != null) {
      data['drinkmodel'] = _drinkmodel!.toJson();
    }
    data['soLuongBan'] = _soLuongBan;
    return data;
  }
}
