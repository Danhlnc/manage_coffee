library tscoffee.globals;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/drinkmodel.dart';
import 'package:tscoffee/model/taboccomodel.dart';

import '../model/billmodel.dart';
import '../model/drinkbillmodel.dart';
import '../model/taboccobillmodel.dart';
import 'package:http/http.dart' as http;
int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inDays);
  }
DateTime date = DateTime.now();
WebStorage webStorage=WebStorage();
DateTimeRange dateTimeRange = DateTime.now().hour<7? DateTimeRange(
    start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day-1,7))),
    end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day,7)))):DateTimeRange(
    start: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day,7))),
    end: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day+1,7))));
List<Map<Billmodel, Color>> listBills = [];
List<Map<Billmodel, Color>> listBillsSearch = [];
List<Map<Billmodel, Color>> listBillsTotal = [];
List<Map<Billmodel, Color>> listBillsTotalSearch = [];
List<Map<Billmodel, Color>> listBillsTotalDate = [];
List<Drinkbillmodel> listNuoc = [];
List<Taboccobillmodel> listThuoc = [];
List<Drinkmodel> listAllNuoc = [];
List<Taboccomodel> listAllThuoc = [];
List<Drinkmodel> listAllNuocSearch = [];
List<Taboccomodel> listAllThuocSearch = [];
bool loadData = true;
List<Billmodel> parsePost(String responseBody) {
  var list = json.decode(responseBody)['result'] as List<dynamic>;
  List<Billmodel> listBillModel =
      list.map((value) => Billmodel.fromJson(value)).toList();
  return listBillModel;
}

bool checkTT= false;
List<Drinkmodel> drinkParsePost(String responseBody) {
  var list = json.decode(responseBody)['result'] as List<dynamic>;
  List<Drinkmodel> listBillModel =
      list.map((value) => Drinkmodel.fromJson(value)).toList();
  return listBillModel;
}

List<Taboccomodel> taboccoParsePost(String responseBody) {
  var list = json.decode(responseBody)['result'] as List<dynamic>;
  List<Taboccomodel> listBillModel =
      list.map((value) => Taboccomodel.fromJson(value)).toList();
  return listBillModel;
}

Future<List<Billmodel>> fetch() async {
  final url = Uri.https('tscoffee-server.onrender.com','v1/boards/bills');
  final response = await http.get(url,headers: {
           "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
        });
  final listModelParse = parsePost(response.body);
  return listModelParse;
}

Future<List<Drinkmodel>> fetchDrinks() async {
  final url =
      Uri.https('tscoffee-server.onrender.com','v1/boards/drinks');
  final response = await http.get(url,headers: {
           "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
        });
  final listModelParse = drinkParsePost(response.body);
  return listModelParse;
}

Future<List<Taboccomodel>> fetchTabocco() async {
  final url =
     Uri.https('tscoffee-server.onrender.com','v1/boards/taboccos');
  final response = await http.get(url,headers: {
           "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
        });
  final listModelParse = taboccoParsePost(response.body);
  return listModelParse;
}
