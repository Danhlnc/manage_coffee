import 'package:tscoffee/model/taboccomodel.dart';

class Taboccobillmodel {
  String? _sId;
  Taboccomodel? _taboccomodel;
  int? _soLuongBan;

  Taboccobillmodel({String? sId, Taboccomodel? taboccomodel, int? soLuongBan}) {
    if (sId != null) {
      _sId = sId;
    }
    if (taboccomodel != null) {
      _taboccomodel = taboccomodel;
    }
    if (soLuongBan != null) {
      _soLuongBan = soLuongBan;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  Taboccomodel? get taboccomodel => _taboccomodel;
  set taboccomodel(Taboccomodel? taboccomodel) => _taboccomodel = taboccomodel;
  int? get soLuongBan => _soLuongBan;
  set soLuongBan(int? soLuongBan) => _soLuongBan = soLuongBan;

  Taboccobillmodel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _taboccomodel = json['taboccomodel'] != null
        ? Taboccomodel.fromJson(json['taboccomodel'])
        : null;
    _soLuongBan = json['soLuongBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    if (_taboccomodel != null) {
      data['taboccomodel'] = _taboccomodel!.toJson();
    }
    data['soLuongBan'] = _soLuongBan;
    return data;
  }
}
