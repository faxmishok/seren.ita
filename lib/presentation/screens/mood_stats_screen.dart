import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/widgets/common/tab_item.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class MoodStatsScreen extends StatefulWidget {
  const MoodStatsScreen({super.key});

  @override
  State<MoodStatsScreen> createState() => _MoodStatsScreenState();
}

class _MoodStatsScreenState extends State<MoodStatsScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox100(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Mood Stats',
                      style: size36weight800.copyWith(
                        color: brownColor,
                        letterSpacing: -1,
                      ),
                    ),
                    AutoSizeText(
                      'See your mood throught the day.',
                      style: size18weight500.copyWith(
                        color: const Color(0xFF1F160F).withValues(alpha: 0.64),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: brownColor,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.chartSimple,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox24(),
          _buildTabs(),
          SizedBox(
            height: 300.0,
            child: TabBarView(
              controller: tabController,
              children: [
                Image.asset('assets/images/mood-stats.png'),
                Image.asset('assets/images/mood-stats.png'),
                Image.asset('assets/images/mood-stats.png'),
                Image.asset('assets/images/mood-stats.png'),
                Image.asset('assets/images/mood-stats.png'),
              ],
            ),
          ),
          const SizedBox24(),
          Image.asset('assets/images/mood-predictions.png'),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: transparentColor,
        indicator: const BoxDecoration(
          color: brownColor,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: brownColor,
        enableFeedback: true,
        onTap: (value) {},
        tabs: const [
          TabItem(title: 'All'),
          TabItem(title: 'Days'),
          TabItem(title: 'Weeks'),
          TabItem(title: 'Months'),
          TabItem(title: 'Years'),
        ],
      ),
    );
  }
}
