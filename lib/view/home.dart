import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/billmodel.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/view/QLyKhoWidget/QLyKhoScreen.dart';
import 'package:tscoffee/view/login.dart';
import 'homepagewidget/doanhthupagewidget/doanhthuscreen.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});
  List<Map<Billmodel, Color>> listBills = [];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool item = true;
  final TextEditingController searchController = TextEditingController();
  Color cardBackgroundColor = Colors.white;
  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }

  List<Map<Billmodel, Color>> list = [];
  search(List<Map<Billmodel, Color>> list) {
    context.read<ProviderModel>().updateListBill(list);
  }

  callBack(String status) {}

  loading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderModel>().updateloadData(true);
      context.read<ProviderModel>().loadDataTotal();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loading();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        key: context.read<ProviderModel>().scaffoldKey,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              context.read<ProviderModel>().currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: context.read<ProviderModel>().currentPageIndex,
          destinations: const <Widget>[
            // NavigationDestination(
            //   selectedIcon: Icon(Icons.home),
            //   icon: Icon(Icons.home_outlined),
            //   label: 'Khách hàng',
            // ),
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
          // KhachhangSceen(
          //     listBills: context.read<ProviderModel>().listBills,
          //     callBack: callBack),
          Doanhthuscreen(
              listBillsTotal: context.read<ProviderModel>().listBillsTotalDate,
              callBack: callBack),

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
                      context.read<ProviderModel>().currentPageIndex = 0;
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
        ][context.read<ProviderModel>().currentPageIndex],
      ),
    );
  }
}
