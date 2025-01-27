import 'package:flutter/material.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class MoodStatsScreen extends StatelessWidget {
  const MoodStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Image.asset('assets/images/mood-stats.png'),
    );
  }
}
