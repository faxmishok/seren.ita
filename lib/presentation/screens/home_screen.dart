import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/chatbot_screen.dart';
import 'package:serenita/presentation/screens/dashboard_screen.dart';
import 'package:serenita/presentation/screens/mood_stats_screen.dart';
import 'package:serenita/presentation/screens/profile_screen.dart';
import 'package:serenita/presentation/screens/sleep_time_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List screens = [
    const DashboardScreen(),
    const ChatbotScreen(),
    const MoodStatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: screens[currentPageIndex],
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: greenColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            backgroundColor: lightBrownColor,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.65,
                child: Container(
                  padding: spacing16,
                  child: Column(
                    children: [
                      const Spacer(),
                      AutoSizeText(
                        'Which activity would you like to do?',
                        textAlign: TextAlign.center,
                        style: size32weight800.copyWith(
                          color: brownColor,
                          letterSpacing: -1,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActivityItem(
                            text: 'GAMES',
                            backgroundColor: greenColor,
                            textColor: whiteColor,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12.0),
                          _buildActivityItem(
                            text: 'WALKING',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox12(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActivityItem(
                            text: 'SLEEP',
                            backgroundColor: orangeColor,
                            textColor: whiteColor,
                            onTap: () {
                              context.push(const SleepTimeScreen());
                            },
                          ),
                          const SizedBox(width: 12.0),
                          _buildActivityItem(
                            text: 'DANCE',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12.0),
                          _buildActivityItem(
                            text: 'YOGA',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox12(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActivityItem(
                            text: 'RUNNING',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12.0),
                          _buildActivityItem(
                            text: 'MEDITATION',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox12(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActivityItem(
                            text: 'JOG',
                            backgroundColor: lightBrownColor,
                            textColor: brownColor,
                            borderColor: brownColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const Spacer(),
                      ButtonCustom(
                        borderRadius: 100.0,
                        bgColor: brownColor,
                        title: 'Continue',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        height: 60.0,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          FontAwesomeIcons.plus,
          color: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          FontAwesomeIcons.house,
          FontAwesomeIcons.message,
          FontAwesomeIcons.chartSimple,
          FontAwesomeIcons.user,
        ],
        activeIndex: currentPageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32.0,
        rightCornerRadius: 32.0,
        activeColor: brownColor,
        inactiveColor: mindfulBrownColor,
        onTap: (index) => setState(() => currentPageIndex = index),
      ),
    );
  }

  Widget _buildActivityItem({
    String? text,
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.0),
          border: borderColor != null ? Border.all(color: borderColor) : const Border(),
        ),
        child: AutoSizeText(
          text!,
          style: size16weight700.copyWith(color: textColor),
        ),
      ),
    );
  }
}
