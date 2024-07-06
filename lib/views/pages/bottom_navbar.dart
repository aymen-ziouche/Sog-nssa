import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sognssa/views/pages/cart_page.dart';
import 'package:sognssa/views/pages/home_page.dart';
import 'package:sognssa/views/pages/profile_page.dart';

class BottonNavBar extends StatefulWidget {
  const BottonNavBar({Key? key}) : super(key: key);

  @override
  State<BottonNavBar> createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      Container(),
      const CartPage(),
      Container(),
      const ProfilePage(),
    ];
  }

  List<PersistentTabConfig> _navBarsItems() {
    return [
      PersistentTabConfig(
        item: ItemConfig(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: CupertinoColors.systemGrey,
        ),
        screen: const HomePage(),
      ),
      PersistentTabConfig(
        item: ItemConfig(
          icon: const Icon(CupertinoIcons.bag),
          title: ("Shop"),
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: CupertinoColors.systemGrey,
        ),
        screen: const CartPage(),
      ),
      PersistentTabConfig(
        item: ItemConfig(
          icon: const Icon(Icons.favorite_border),
          title: ("Favorites"),
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: CupertinoColors.systemGrey,
        ),
        screen: const ProfilePage(),
      ),
      PersistentTabConfig(
        item: ItemConfig(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: ("Profile"),
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: CupertinoColors.systemGrey,
        ),
        screen: const ProfilePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: PersistentTabView(
            controller: _bottomNavbarController,
            tabs: _navBarsItems(),
            backgroundColor: Colors.transparent, // Default is Colors.white.

            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),

            navBarBuilder: (navBarConfig) => Style1BottomNavBar(
              navBarConfig: navBarConfig,
              navBarDecoration: NavBarDecoration(
                  color: Colors.black.withOpacity(0.5),
                  // backgroundBlendMode: BlendMode.overlay,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            ), // Choose the nav bar style with this property.
          )),
    );
  }
}
