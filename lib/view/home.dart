import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/apps/globalvariables.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/view/QLyKhoWidget/QLyKhoScreen.dart';
import 'package:tscoffee/view/login.dart';
import 'homepagewidget/addpagewidgets/khachhangSceen.dart';
import 'homepagewidget/doanhthupagewidget/doanhthuscreen.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});
  List<Map<Billmodel, Color>> listBills = [];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  bool item = true;
  final TextEditingController searchController = TextEditingController();
  Color cardBackgroundColor = Colors.white;
  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }

  List<Billmodel> list = [];
  search(List<Map<Billmodel, Color>> list) {
    setState(() {
      listBills = list;
    });
  }

  callBack(String status) {
    if (status == "update") {
      loadData = true;
      setState(() {});
      fetch().then((onValue) {
        listNuoc.clear();
        listThuoc.clear();
        widget.listBills.clear();
        listBillsTotal.clear();
        listBills.clear();
        list.clear();
        list = onValue;
        for (var item in list) {
          Map<Billmodel, Color> newmap = {item: Colors.white};
          listBillsTotal.add(newmap);
        }
        loadData = false;
        listBillsTotal.sort((b, a) => a.keys.first.createdOn!
            .compareTo(b.keys.first.createdOn as DateTime));
        listBills = [...listBillsTotal];
        var listPro = [...listBills];
        for (var action in listPro) {
          if (DateFormat('yyyy-MM-dd').format(
                  DateTime.parse(action.keys.first.createdOn.toString())) !=
              DateFormat('yyyy-MM-dd').format(date)) {
            listBills.remove(action);
          }
        }

        listBills.sort((b, a) => a.keys.first.modifyOn!
            .compareTo(b.keys.first.modifyOn as DateTime));

        listBillsTotalDate = [...listBillsTotal];
        var listProDate = [...listBillsTotalDate];
        for (var action in listProDate) {
          if (action.keys.first.createdOn!.isBefore(dateTimeRange.end) &&
              action.keys.first.createdOn!.isAfter(dateTimeRange.start)) {
          } else {
            listBillsTotalDate.remove(action);
          }
        }
        setState(() {});
      });

      fetchDrinks().then((onValue) {
        listAllNuoc = [];
        listAllNuoc = onValue;
        listAllNuocSearch = onValue;
        setState(() {});
      });
      fetchTabocco().then((onValue) {
        listAllThuoc = [];
        listAllThuoc = onValue;
        listAllThuocSearch = onValue;
        setState(() {});
      });
      fetchCombo().then((onValue) {
        listAllCombo = [];
        listAllCombo = onValue;
        listAllComboSearch = onValue;
        setState(() {});
      });
      fetchSpend().then((onValue) {
        context.read<ProviderModel>().update(onValue);
        context.read<ProviderModel>().updateListTemp(dateTimeRange);
        context.read<ProviderModel>().getTotalCount();
      });
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callBack('update');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Khách hàng',
            ),
            NavigationDestination(
              icon: Icon(Icons.area_chart),
              label: 'Doanh thu',
            ),
            NavigationDestination(
              icon: Icon(Icons.warehouse),
              label: 'Quản lí kho',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_sharp),
              label: 'Thông tin',
            ),
          ],
        ),
        body: <Widget>[
          KhachhangSceen(listBills: listBills, callBack: callBack),
          Doanhthuscreen(
              listBillsTotal: listBillsTotalDate, callBack: callBack),

          /// Notifications page
          QuanLyKhoScreen(),
          Container(
            color: Colors.blueGrey,
            child: Column(
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: () {
                      WebStorage.instance.sessionId = "";
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Center(child: Text('Đăng xuất'))),
                  ),
                ),
              ],
            ),
          ),
        ][currentPageIndex],
      ),
    );
  }
}
