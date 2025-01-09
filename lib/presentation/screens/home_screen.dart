import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:serenita/presentation/screens/dashboard_screen.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List screens = [
    const DashboardScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: screens[currentPageIndex],
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: greenColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.chat_outlined,
          Icons.bar_chart_outlined,
          Icons.person_outline,
        ],
        activeIndex: currentPageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32.0,
        rightCornerRadius: 32.0,
        activeColor: brownColor,
        inactiveColor: mindfulBrownColor,
        onTap: (index) => setState(() => currentPageIndex = index),
        //other params
      ),
    );
  }
}
