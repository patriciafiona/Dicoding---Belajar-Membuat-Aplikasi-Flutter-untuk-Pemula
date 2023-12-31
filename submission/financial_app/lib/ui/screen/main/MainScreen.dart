import 'package:financial_app/ui/screen/main/HomeTabScreen/HomeTabScreen.dart';
import 'package:financial_app/ui/screen/main/SettingTabScreen/SettingTabScreen.dart';
import 'package:financial_app/ui/screen/main/WalletTabScreen/WalletTabScreen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import '../../../utils/CustomColors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleHoneycreeper,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
            'My Finance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        color: purpleHoneycreeper,
        child: Center(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
            // controller: _tabController,
            controller: _motionTabBarController,
            children: <Widget>[
              HomeTabScreen(),
              const WalletTabScreen(),
              const SettingTabScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Home",
        labels: const ["Home", "Wallet", "Settings"],
        icons: const [Icons.home, Icons.wallet, Icons.settings],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.grey,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: cloudBreak,
        tabIconSelectedColor: purplishBlue,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
