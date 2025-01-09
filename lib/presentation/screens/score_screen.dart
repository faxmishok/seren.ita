import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildScoreField(),
          _buildScoreHistoryField(),
        ],
      ),
    );
  }

  Widget _buildScoreField() {
    return Container(
      decoration: const BoxDecoration(
        color: greenColor,
        image: DecorationImage(
          image: AssetImage('assets/images/score-pattern.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: spacing16.copyWith(top: 40.0),
              width: context.width,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  AutoSizeText(
                    'Serenita Score',
                    style: size20weight700.copyWith(color: whiteColor),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: lightGreenColor,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: AutoSizeText(
                      'NORMAL',
                      style: size12weight700.copyWith(color: greenColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox100(),
            const AutoSizeText(
              '80',
              style: TextStyle(
                fontSize: 128.0,
                fontWeight: FontWeight.w800,
                color: whiteColor,
                height: 1.0,
              ),
            ),
            SizedBox(
              width: context.width / 1.2,
              child: AutoSizeText(
                'Congratulations! You are mentally healthy.',
                textAlign: TextAlign.center,
                style: size20weight600.copyWith(color: whiteColor),
              ),
            ),
            const SizedBox100(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreHistoryField() {
    return Container(
      padding: spacing16,
      width: context.width,
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Center(
          //   child: Container(
          //     height: 80.0,
          //     width: 80.0,
          //     decoration: const BoxDecoration(
          //       color: brownColor,
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey,
          //           offset: Offset(0.0, 1.0),
          //           blurRadius: 20.0,
          //         ),
          //       ],
          //     ),
          //     child: const Icon(
          //       Icons.add,
          //       color: whiteColor,
          //     ),
          //   ),
          // ),
          // const SizedBox24(),
          AutoSizeText(
            'Mental Score History',
            style: size18weight700.copyWith(color: brownColor),
          ),
          const SizedBox12(),
          const ScoreCard(
            day: '20',
            month: 'SEP',
            mood: 'Anxious, Depressed',
            recommendation: 'Please do 25m Mindfulness.',
            score: 65,
          ),
          const ScoreCard(
            day: '11',
            month: 'SEP',
            mood: 'Very Happy',
            recommendation: 'No recommendation.',
            score: 95,
          ),
          const ScoreCard(
            day: '9',
            month: 'SEP',
            mood: 'Very Happy',
            recommendation: 'No recommendation.',
            score: 90,
          ),
        ],
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String day;
  final String month;
  final String mood;
  final String recommendation;
  final int score;

  const ScoreCard({
    super.key,
    required this.day,
    required this.month,
    required this.mood,
    required this.recommendation,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightBrownColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    month,
                    style: size12weight700.copyWith(color: brownColor),
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    day,
                    style: size20weight700,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  mood,
                  style: size16weight700.copyWith(color: brownColor),
                ),
                AutoSizeText(
                  recommendation,
                  style: size14weight600.copyWith(color: brownColor.withValues(alpha: 0.6)),
                ),
              ],
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 35.0,
              lineWidth: 10.0,
              animation: true,
              percent: score / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '$score',
                    style: size12weight700.copyWith(color: brownColor),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: score >= 75
                  ? greenColor
                  : score >= 50
                      ? orangeColor
                      : redColor,
              backgroundColor: whiteColor.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
