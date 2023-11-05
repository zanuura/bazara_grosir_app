import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/keranjang.dart';
import 'package:product_groceries/screens/tab_screens/cart_screen.dart';
import 'package:product_groceries/screens/tab_screens/home_screens.dart';
import 'package:product_groceries/screens/tab_screens/order_screen.dart';
import 'package:product_groceries/screens/tab_screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  String iconsPath = 'assets/baz_icons';
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(controller: tabController, children: [
        HomeSreen(),
        OrderScreen(),
        // CartScreen(),
        Keranjang(
          fromTab: true,
        ),
        ProfileScreen(),
      ]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Warna.goldHalfBaz,
            blurRadius: 5,
          )
        ]),
        child: TabBar(
            controller: tabController,
            labelColor: MyTheme.accent_color,
            unselectedLabelColor: Colors.grey,
            splashBorderRadius: BorderRadius.circular(14),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              shape: BoxShape.circle,
            ),
            onTap: (value) {
              setState(() {
                currentTab = value;
              });
            },
            tabs: [
              Tab(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    currentTab == 0
                        ? '$iconsPath/baz_home_active.png'
                        : '$iconsPath/baz_home.png',
                  ),
                ),
                text: 'Beranda',
              ),
              Tab(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    currentTab == 1
                        ? '$iconsPath/baz_box_active.png'
                        : '$iconsPath/baz_box.png',
                  ),
                ),
                text: 'Pesanan',
              ),
              Tab(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    currentTab == 2
                        ? '$iconsPath/baz_cart_active.png'
                        : '$iconsPath/baz_cart.png',
                  ),
                ),
                text: 'Keranjang',
              ),
              Tab(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    currentTab == 3
                        ? '$iconsPath/baz_akun_active.png'
                        : '$iconsPath/baz_akun.png',
                  ),
                ),
                text: 'Akun',
              )
            ]),
      ),
    );
  }
}
