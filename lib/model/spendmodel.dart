import 'package:flutter/material.dart';

class spendmodel extends ChangeNotifier {
  String? _sId ="";
  String? _name ="";
  int? _count =0;
  DateTime? _createdOn =DateTime.now();
  String? _createdBy ="";
  DateTime? _modifyOn =DateTime.now();
  String? _modifyBy ="";

  spendmodel(
      { String? sId,
  String? name,
  int? count,
  DateTime? createdOn,
  String? createdBy,
  DateTime? modifyOn,
  String? modifyBy,}) {
    if (sId != null) {
      _sId = sId;
    }if (name != null) {
      _name = name;
    }if (count != null) {
      _count = count;
    }if (createdOn != null) {
      _createdOn = createdOn;
    }if (createdBy != null) {
      _createdBy = createdBy;
    }if (modifyOn != null) {
      _modifyOn = modifyOn;
    }if (modifyBy != null) {
      _modifyBy = modifyBy;
    }
    
    }
String? get sId => _sId;
  set sId(String? sId) {_sId = sId;
  notifyListeners();} 
  String? get name => _name;
  set name(String? name) { _name = name; notifyListeners();}
  int? get count => _count;
  set count(int? count)  {_count = count; notifyListeners();}
  DateTime? get createdOn => _createdOn;
  set createdOn(DateTime? createdOn) { _createdOn = createdOn; notifyListeners();}
  String? get createdBy => _createdBy;
  set createdBy(String? screatedById) {_createdBy = createdBy; notifyListeners();}
  DateTime? get modifyOn => _modifyOn;
  set modifyOn(DateTime? modifyOn) { _modifyOn = modifyOn; notifyListeners();}
  String? get modifyBy => _modifyBy;
  set modifyBy(String? modifyBy) {_modifyBy = modifyBy; notifyListeners();} 
  spendmodel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _count = json['count'];
    _createdOn = json['createdOn'];
    _createdBy = json['createdBy'];
    _modifyOn = json['modifyOn'];
    _modifyBy = json['modifyBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['count'] = this._count;
    data['createdOn'] = this._createdOn;
    data['createdBy'] = this._createdBy;
    data['modifyOn'] = this._modifyOn;
    data['modifyBy'] = this._modifyBy;
    return data;
  }
}