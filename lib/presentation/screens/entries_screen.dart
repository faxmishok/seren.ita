import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        backgroundColor: lightBrownColor,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: brownColor,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox24(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Your Entries',
                      style: size36weight800.copyWith(color: brownColor),
                    ),
                    AutoSizeText(
                      'Document your Mental Journal.',
                      style: size18weight500.copyWith(color: const Color(0xff1F160F).withValues(alpha: 64)),
                    ),
                  ],
                ),
                Container(
                  height: 64.0,
                  width: 64.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: brownColor,
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox24(),
          _buildAllJournals(),
          const SizedBox24(),
          _buildJournalStats(),
        ],
      ),
    );
  }

  Widget _buildAllJournals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AutoSizeText(
            'All Journals',
            style: size18weight800.copyWith(color: brownColor),
          ),
        ),
        const SizedBox12(),
        SizedBox(
          height: 280.0,
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 16.0),
              _buildJournalItem(
                asset: 'assets/images/happy.png',
                mood: 'MOOD: HAPPY',
                title: 'I’m grateful for my life...',
                desc: 'Today, I just had a revelation. It was...',
                color: greenColor,
              ),
              const SizedBox(width: 8.0),
              _buildJournalItem(
                asset: 'assets/images/sad.png',
                mood: 'MOOD: ANGRY',
                title: 'F*** Everyone and everything else',
                desc: 'I just don’t like the b***** at my school.',
                color: orangeColor,
              ),
              const SizedBox(width: 16.0),
              _buildJournalItem(
                asset: 'assets/images/happy.png',
                mood: 'MOOD: HAPPY',
                title: 'I’m grateful for my life...',
                desc: 'Today, I just had a revelation. It was...',
                color: greenColor,
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJournalStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Journal Stats',
                style: size18weight800.copyWith(color: brownColor),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox12(),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: lightGreenColor,
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: greenColor,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '81/365',
                            style: size20weight800.copyWith(
                              color: brownColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          AutoSizeText(
                            'Completed',
                            style: size14weight500.copyWith(
                              color: const Color(0xff1F160F).withValues(alpha: 0.48),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: lightBrownColor,
                        ),
                        child: const Icon(
                          Icons.equalizer_outlined,
                          color: brownColor,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Neutral',
                            style: size20weight800.copyWith(
                              color: brownColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          AutoSizeText(
                            'Emotion',
                            style: size14weight500.copyWith(
                              color: const Color(0xff1F160F).withValues(alpha: 0.48),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJournalItem({
    String? asset,
    String? mood,
    String? title,
    String? desc,
    Color? color,
  }) {
    return Container(
      width: 220.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: color,
                ),
                child: Image.asset(
                  asset!,
                  color: whiteColor,
                  height: 25.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12.0),
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: color == greenColor ? lightGreenColor : secondaryLightOrangeColor,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: AutoSizeText(
                  mood!,
                  style: size12weight700.copyWith(color: color),
                ),
              ),
              const SizedBox6(),
              AutoSizeText(
                title!,
                maxLines: 1,
                minFontSize: 18.0,
                overflow: TextOverflow.ellipsis,
                style: size18weight700.copyWith(color: brownColor, letterSpacing: -1),
              ),
              const SizedBox6(),
              AutoSizeText(
                desc!,
                maxLines: 1,
                minFontSize: 12.0,
                overflow: TextOverflow.ellipsis,
                style: size12weight500.copyWith(
                  color: const Color(0xff1F160F).withValues(alpha: 0.64),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
