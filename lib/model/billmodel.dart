import 'package:tscoffee/model/drinkbillmodel.dart';
import 'package:tscoffee/model/taboccobillmodel.dart';

class Billmodel {
  String? _sId = "";
  String? _bienSoXe = "";
  double? _sac = 0;
  bool? _muonSac = false;
  bool? _nguNgay = false;
  bool? _nguDem = false;
  bool? _tam = false;
  List<Drinkbillmodel> _listNuoc = [];
  List<Taboccobillmodel> _listThuoc = [];
  double? _comGia = 0;
  double? _giaGiatDo = 0;
  double? _giaTu = 0;
  String? _ghiChu = "";
  double? _tongTien = 0;
  bool? _trangThai = true;
  DateTime? _createdOn = DateTime.now();
  String? _createdBy = "";
  DateTime? _modifyOn = DateTime.now();
  String? _modifyBy = "";

  Billmodel(
      {String? sId,
      String? bienSoXe,
      double? sac,
      bool? muonSac,
      bool? nguNgay,
      bool? nguDem,
      bool? tam,
      List<Drinkbillmodel>? listNuoc,
      List<Taboccobillmodel>? listThuoc,
      double? comGia,
      double? giaGiatDo,
      double? giaTu,
      String? ghiChu,
      double? tongTien,
      bool? trangThai,
      DateTime? createdOn,
      String? createdBy,
      DateTime? modifyOn,
      String? modifyBy}) {
    if (sId != null) {
      _sId = sId;
    }
    if (bienSoXe != null) {
      _bienSoXe = bienSoXe;
    }
    if (sac != null) {
      _sac = sac;
    }
    if (muonSac != null) {
      _muonSac = muonSac;
    }
    if (nguNgay != null) {
      _nguNgay = nguNgay;
    }
    if (nguDem != null) {
      _nguDem = nguDem;
    }
    if (tam != null) {
      _tam = tam;
    }
    if (listNuoc != null) {
      _listNuoc = listNuoc;
    }
    if (listThuoc != null) {
      _listThuoc = listThuoc;
    }
    if (comGia != null) {
      _comGia = comGia;
    }
    if (giaGiatDo != null) {
      _giaGiatDo = giaGiatDo;
    }
    if (giaTu != null) {
      _giaTu = giaTu;
    }
    if (ghiChu != null) {
      _ghiChu = ghiChu;
    }
    if (tongTien != null) {
      _tongTien = tongTien;
    }
    if (trangThai != null) {
      _trangThai = trangThai;
    }
    if (createdOn != null) {
      _createdOn = createdOn;
    }
    if (createdBy != null) {
      _createdBy = createdBy;
    }
    if (modifyOn != null) {
      _modifyOn = modifyOn;
    }
    if (modifyBy != null) {
      _modifyBy = modifyBy;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get bienSoXe => _bienSoXe;
  set bienSoXe(String? bienSoXe) => _bienSoXe = bienSoXe;
  double? get sac => _sac;
  set sac(double? sac) => _sac = sac;
  bool? get muonSac => _muonSac;
  set muonSac(bool? muonSac) => _muonSac = muonSac;
  bool? get nguNgay => _nguNgay;
  set nguNgay(bool? nguNgay) => _nguNgay = nguNgay;
  bool? get nguDem => _nguDem;
  set nguDem(bool? nguDem) => _nguDem = nguDem;
  bool? get tam => _tam;
  set tam(bool? tam) => _tam = tam;
  List<Drinkbillmodel> get listNuoc => _listNuoc;
  set listNuoc(List<Drinkbillmodel> listNuoc) => _listNuoc = listNuoc;
  List<Taboccobillmodel> get listThuoc => _listThuoc;
  set listThuoc(List<Taboccobillmodel> listThuoc) => _listThuoc = listThuoc;
  double? get comGia => _comGia;
  set comGia(double? comGia) => _comGia = comGia;
  double? get giaGiatDo => _giaGiatDo;
  set giaGiatDo(double? giaGiatDo) => _giaGiatDo = giaGiatDo;
  double? get giaTu => _giaTu;
  set giaTu(double? giaTu) => _giaTu = giaTu;
  String? get ghiChu => _ghiChu;
  set ghiChu(String? ghiChu) => _ghiChu = ghiChu;
  double? get tongTien => _tongTien;
  set tongTien(double? tongTien) => _tongTien = tongTien;
  bool? get trangThai => _trangThai;
  set trangThai(bool? trangThai) => _trangThai = trangThai;
  DateTime? get createdOn => _createdOn;
  set createdOn(DateTime? createdOn) => _createdOn = createdOn;
  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;
  DateTime? get modifyOn => _modifyOn;
  set modifyOn(DateTime? modifyOn) => _modifyOn = modifyOn;
  String? get modifyBy => _modifyBy;
  set modifyBy(String? modifyBy) => _modifyBy = modifyBy;

  Billmodel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _bienSoXe = json['bienSoXe'];
    _sac = double.parse(json['sac'].toString());
    _muonSac = json['muonSac'];
    _nguNgay = json['nguNgay'];
    _nguDem = json['nguDem'];
    _tam = json['tam'];
    if (json['listNuoc'] != null) {
      _listNuoc = <Drinkbillmodel>[];
      json['listNuoc'].forEach((v) {
        _listNuoc.add(Drinkbillmodel.fromJson(v));
      });
    }
    if (json['listThuoc'] != null) {
      _listThuoc = <Taboccobillmodel>[];
      json['listThuoc'].forEach((v) {
        _listThuoc.add(Taboccobillmodel.fromJson(v));
      });
    }
    _comGia = double.parse(json['comGia'].toString());
    _giaGiatDo = double.parse(json['giaGiatDo'].toString().toString());
    _giaTu = double.parse(json['giaTu'].toString());
    _ghiChu = json['ghiChu'];
    _tongTien = double.parse(json['tongTien'].toString());
    _trangThai = json['trangThai'];
    _createdOn = DateTime.parse(json['createdOn'].toString());
    _createdBy = json['createdBy'];
    _modifyOn = DateTime.parse(json['modifyOn'].toString());
    _modifyBy = json['modifyBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['bienSoXe'] = _bienSoXe;
    data['sac'] = _sac;
    data['muonSac'] = _muonSac;
    data['nguNgay'] = _nguNgay;
    data['nguDem'] = _nguDem;
    data['tam'] = _tam;
    data['listNuoc'] = _listNuoc!.map((v) => v.toJson()).toList();
      data['listThuoc'] = _listThuoc!.map((v) => v.toJson()).toList();
      data['comGia'] = _comGia;
    data['giaGiatDo'] = _giaGiatDo;
    data['giaTu'] = _giaTu;
    data['ghiChu'] = _ghiChu;
    data['tongTien'] = _tongTien;
    data['trangThai'] = _trangThai;
    data['createdOn'] = _createdOn.toString();
    data['createdBy'] = _createdBy;
    data['modifyOn'] = _modifyOn.toString();
    data['modifyBy'] = _modifyBy;
    return data;
  }
}
