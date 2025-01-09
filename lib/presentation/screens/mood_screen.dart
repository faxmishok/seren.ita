import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
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
          _buildMoodField(),
          const SizedBox24(),
          Image.asset('assets/images/mood-statistics.png'),
        ],
      ),
    );
  }

  Widget _buildMoodField() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffE8DDD9),
        image: DecorationImage(
          image: AssetImage('assets/images/mood-pattern.png'),
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
                      color: brownColor,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  AutoSizeText(
                    'Mood',
                    style: size20weight700.copyWith(color: brownColor),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffD5C2B9),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: AutoSizeText(
                      'LEVEL 3',
                      style: size12weight700.copyWith(color: const Color(0xff926247)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox50(),
            AutoSizeText(
              'Your mood is',
              textAlign: TextAlign.center,
              style: size20weight600.copyWith(color: brownColor),
            ),
            const AutoSizeText(
              'Neutral',
              style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w800,
                color: brownColor,
                height: 1.0,
                fontFamily: 'Urbanist',
              ),
            ),
            const SizedBox24(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15.0,
                  color: brownColor,
                ),
                const SizedBox(width: 12.0),
                Image.asset(
                  'assets/images/neutral.png',
                  height: 100.0,
                ),
                const SizedBox(width: 12.0),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                  color: brownColor,
                ),
              ],
            ),
            const SizedBox70(),
          ],
        ),
      ),
    );
  }
}
