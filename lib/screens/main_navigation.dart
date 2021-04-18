import 'package:flutter/material.dart';
import 'package:kharoof_reefy/screens/cart.dart';
import 'package:kharoof_reefy/screens/home.dart';
import 'package:kharoof_reefy/screens/more.dart';
import 'package:kharoof_reefy/screens/my_orders.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';

class MainNavigation extends StatefulWidget {
  final int routeIndex;
  MainNavigation({this.routeIndex});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  void initState() {
    super.initState();
    if (widget.routeIndex != null) {
      setState(() {
        _currentIndex = widget.routeIndex;
      });
    }
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    MyOrders(),
    CartPage(),
    More(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CustomBottomBar(
        index: widget.routeIndex ?? _currentIndex,
        handler: onTabTapped,
      ),
    );
  }
}
