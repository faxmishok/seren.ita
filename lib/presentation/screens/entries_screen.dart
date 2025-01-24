import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      style: size18weight500.copyWith(
                        color: const Color(0xff1F160F).withAlpha(160),
                      ),
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('journals').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final journals = snapshot.data!.docs;
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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: journals.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                  itemBuilder: (context, index) {
                    final journal = journals[index];
                    return _buildJournalItem(
                      mood: journal['mood'],
                      title: journal['title'],
                      desc: journal['description'],
                      asset: journal['iconPath'],
                      color: Color(int.parse(journal['color'].substring(1, 7), radix: 16) + 0xFF000000),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching journals.'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildJournalStats() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('stats').doc('stats').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stats = snapshot.data!.data() as Map<String, dynamic>;
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
                      color: const Color(0xff1F160F).withAlpha(80),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox12(),
                Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.description_outlined,
                      value: '${stats['completedDays']}/${stats['totalDays']}',
                      label: 'Completed',
                      iconColor: greenColor,
                      bgColor: lightGreenColor,
                    ),
                    const SizedBox(width: 16.0),
                    _buildStatCard(
                      icon: Icons.equalizer_outlined,
                      value: stats['dominantMood'],
                      label: 'Emotion',
                      iconColor: brownColor,
                      bgColor: lightBrownColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching stats.'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildJournalItem({
    required String mood,
    required String title,
    required String desc,
    required String asset,
    required Color color,
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
                  asset,
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
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: AutoSizeText(
                  mood,
                  style: size12weight700.copyWith(color: color),
                ),
              ),
              const SizedBox6(),
              AutoSizeText(
                title,
                maxLines: 1,
                minFontSize: 18.0,
                overflow: TextOverflow.ellipsis,
                style: size18weight700.copyWith(color: brownColor, letterSpacing: -1),
              ),
              const SizedBox6(),
              AutoSizeText(
                desc,
                maxLines: 1,
                minFontSize: 12.0,
                overflow: TextOverflow.ellipsis,
                style: size12weight500.copyWith(
                  color: const Color(0xff1F160F).withAlpha(160),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: whiteColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: bgColor,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  value,
                  style: size20weight800.copyWith(color: brownColor, letterSpacing: -0.5),
                ),
                AutoSizeText(
                  label,
                  style: size14weight500.copyWith(
                    color: const Color(0xff1F160F).withAlpha(120),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
