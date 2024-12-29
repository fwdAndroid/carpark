import 'dart:io';

import 'package:carpark/screens/pages/home_page.dart';
import 'package:carpark/screens/pages/navigatation_page.dart';
import 'package:carpark/screens/pages/parking_page.dart';
import 'package:carpark/screens/pages/profile.dart';
import 'package:carpark/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(), // Replace with your screen widgets
    NavigatationPage(),
    ParkingPage(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: mainBtnColor),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? Icon(
                        Icons.home_outlined,
                        size: 25,
                        color: mainBtnColor,
                      )
                    : Icon(
                        Icons.home_outlined,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? Icon(
                        Icons.explore,
                        size: 25,
                        color: mainBtnColor,
                      )
                    : Icon(
                        Icons.explore,
                      ),
                label: 'Navigations',
              ),
              BottomNavigationBarItem(
                label: "Parking",
                icon: _currentIndex == 2
                    ? Icon(
                        Icons.bookmark,
                        size: 25,
                        color: mainBtnColor,
                      )
                    : Icon(
                        Icons.bookmark,
                      ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: _currentIndex == 3
                    ? Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                        color: mainBtnColor,
                      )
                    : Icon(
                        Icons.account_circle_outlined,
                      ),
              ),
            ],
          ),
        ));
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop(); // For Android
              } else if (Platform.isIOS) {
                exit(0); // For iOS
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
