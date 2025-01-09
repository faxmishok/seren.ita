import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/new_journal_entry_screen.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class HealthJournalScreen extends StatefulWidget {
  const HealthJournalScreen({super.key});

  @override
  State<HealthJournalScreen> createState() => _HealthJournalScreenState();
}

class _HealthJournalScreenState extends State<HealthJournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _buildJournalCountField(),
          Positioned(
            bottom: 0.0,
            child: _buildJournalHistoryField(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Center(
              child: GestureDetector(
                onTap: () => context.push(const NewJournalEntryScreen()),
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: const BoxDecoration(
                    color: brownColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalCountField() {
    return Container(
      height: context.height,
      decoration: const BoxDecoration(
        color: secondaryBrownColor,
        image: DecorationImage(
          image: AssetImage('assets/images/journal-pattern.png'),
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
                    'Health Journal',
                    style: size20weight700.copyWith(color: whiteColor),
                  ),
                ],
              ),
            ),
            const SizedBox100(),
            const AutoSizeText(
              '34/365',
              style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w800,
                color: whiteColor,
                height: 1.0,
                fontFamily: 'Urbanist',
              ),
            ),
            const SizedBox24(),
            SizedBox(
              width: context.width / 1.2,
              child: AutoSizeText(
                'Journals this year. Keep it Up!',
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

  Widget _buildJournalHistoryField() {
    return Container(
      padding: spacing16,
      height: context.height / 2,
      width: context.width,
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Journal History',
            style: size18weight700.copyWith(color: brownColor),
          ),
          const SizedBox12(),
          Image.asset('assets/images/journal-history.png'),
          const SizedBox24(),
          Container(
            height: 35.0,
            width: context.width,
            decoration: BoxDecoration(
              color: const Color(0xffF7F4F2),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8.0,
                      width: 8.0,
                      decoration: const BoxDecoration(
                        color: orangeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    AutoSizeText(
                      'Negative',
                      style: size14weight700.copyWith(
                        color: const Color(0xff1F160F).withValues(alpha: 0.64),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8.0,
                      width: 8.0,
                      decoration: const BoxDecoration(
                        color: secondaryBrownColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    AutoSizeText(
                      'Neutral',
                      style: size14weight700.copyWith(
                        color: const Color(0xff1F160F).withValues(alpha: 0.64),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 8.0,
                      width: 8.0,
                      decoration: const BoxDecoration(
                        color: greenColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    AutoSizeText(
                      'Positive',
                      style: size14weight700.copyWith(
                        color: const Color(0xff1F160F).withValues(alpha: 0.64),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
