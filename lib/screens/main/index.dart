import 'package:flutter/material.dart';
import 'package:logos/screens/main/pages/map.dart';
import 'package:logos/screens/main/pages/order.dart';
import 'package:logos/screens/main/pages/order_list.dart';
import 'package:logos/styles.dart';
import 'package:logos/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        drawer: MainDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: blueColor,
          unselectedItemColor: greyColor,
          elevation: 10,
          backgroundColor: Colors.white,
          currentIndex: page,
          type: BottomNavigationBarType.fixed,
          onTap: (int _page) {
            setState(() {
              page = _page;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Container(height: 0.0),
            ),
          ],
        ),
        body: [OrderPage(), MapPage(), OrderListPage()][page],
      ),
    );
  }
}
