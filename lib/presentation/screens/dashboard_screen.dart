import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/helpers/functions/messenger.dart';
import 'package:serenita/presentation/screens/health_journal_screen.dart';
import 'package:serenita/presentation/screens/mood_screen.dart';
import 'package:serenita/presentation/screens/notifications_screen.dart';
import 'package:serenita/presentation/screens/score_screen.dart';
import 'package:serenita/presentation/screens/startup_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // to ensure successful data fetch from firestore
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (userId != null) {
      final userSnapshot = await usersCollection.doc(userId).get();
      if (userSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        title: 'Dashboard',
        actions: [
          ButtonCustom(
            title: context.tr('log_out').toUpperCase(),
            width: 100.0,
            height: 40.0,
            bgColor: brownColor,
            onPressed: () async {
              showStyledConfirmationDialog(
                context: context,
                message: 'Do you want to log out?',
                cancelLabel: 'No',
                confirmLabel: 'Yes',
                onConfirmed: () async {
                  await getIt<UserRelatedRemoteData>().signOut();

                  // ignore: use_build_context_synchronously
                  context.pushAndRemoveUntil(StartUpScreen());
                },
              );
            },
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileSection(),
          _buildMentalHealthMetrics(),
          _buildActivitiesTracker(),
          const SizedBox50(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    final currentMood = userData?['currentMood'] ?? 'Happy';
    final userName = userData?['name'] ?? 'User';

    return Material(
      elevation: 4.0,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24.0),
        bottomRight: Radius.circular(24.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Tue, 06 Feb 2025',
                  style: size12weight700.copyWith(color: grey500Color),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: brownColor),
                  ),
                  child: IconButton(
                    onPressed: () => context.push(const NotificationsScreen()),
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: brownColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: 'https://wallpapers.com/images/hd/minecraft-profile-pictures-1242-x-1235-zix8e1u4kw9zj3cj.jpg',
                    height: 60.0,
                    width: 60.0,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Hi, $userName!',
                      style: size28weight700.copyWith(color: brownColor),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: lightGreenColor,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/star.png',
                                height: 20.0,
                              ),
                              const SizedBox(width: 6.0),
                              AutoSizeText(
                                'Pro Member',
                                style: size12weight600.copyWith(color: greenColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/dots.png',
                                height: 20.0,
                              ),
                              const SizedBox(width: 6.0),
                              AutoSizeText(
                                '80%',
                                style: size12weight600.copyWith(color: brownColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/smile.png',
                                height: 20.0,
                              ),
                              const SizedBox(width: 6.0),
                              AutoSizeText(
                                currentMood,
                                style: size12weight600.copyWith(color: brownColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentalHealthMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Mental Health Metrics',
                style: size18weight700.copyWith(color: brownColor),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200.0,
          width: context.width,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 16.0),
              GestureDetector(
                onTap: () => context.push(const ScoreScreen()),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  width: 165.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite_outline,
                            color: whiteColor,
                          ),
                          const SizedBox(width: 6.0),
                          AutoSizeText(
                            'Score',
                            style: size16weight700.copyWith(color: whiteColor),
                          ),
                        ],
                      ),
                      const SizedBox24(),
                      CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: 0.8,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              '80',
                              style: size24weight700.copyWith(color: whiteColor),
                            ),
                            AutoSizeText(
                              'Healty',
                              style: size14weight600.copyWith(color: lighterGreenColor),
                            ),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: whiteColor,
                        backgroundColor: whiteColor.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              GestureDetector(
                onTap: () => context.push(const MoodScreen()),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  width: 165.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: orangeColor,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/sad.png',
                            height: 26.0,
                          ),
                          const SizedBox(width: 6.0),
                          AutoSizeText(
                            'Mood',
                            style: size16weight700.copyWith(color: whiteColor),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        'Sad',
                        style: size24weight700.copyWith(color: whiteColor),
                      ),
                      const SizedBox24(),
                      Center(
                        child: Image.asset(
                          'assets/images/mood-frame.png',
                          height: 80.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              GestureDetector(
                onTap: () => context.push(const HealthJournalScreen()),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  width: 165.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.note_add_outlined,
                            color: whiteColor,
                          ),
                          const SizedBox(width: 6.0),
                          AutoSizeText(
                            'Health Journal',
                            style: size14weight700.copyWith(color: whiteColor),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        '31/365',
                        style: size24weight700.copyWith(color: whiteColor),
                      ),
                      const SizedBox24(),
                      Center(
                        child: Image.asset(
                          'assets/images/journal-graph.png',
                          height: 80.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
        const SizedBox16(),
      ],
    );
  }

  Widget _buildActivitiesTracker() {
    return Container(
      padding: spacing16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Today’s Activities Tracker',
                style: size18weight700.copyWith(color: brownColor),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
          Column(
            spacing: 12.0,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/hours.png',
                      height: 70.0,
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Mindful Hours',
                          style: size18weight700.copyWith(color: brownColor),
                        ),
                        AutoSizeText(
                          '2.5h/8h',
                          style: size14weight500.copyWith(color: brownColor.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/hours-graph.png',
                      height: 70.0,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/sleep.png',
                      height: 70.0,
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Sleep Quality',
                          style: size18weight700.copyWith(color: brownColor),
                        ),
                        AutoSizeText(
                          'Insomniac (~2h Avg)',
                          style: size14weight500.copyWith(color: brownColor.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/sleep-progress.png',
                      height: 70.0,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/journal.png',
                      height: 70.0,
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Mindful Journal',
                          style: size18weight700.copyWith(color: brownColor),
                        ),
                        AutoSizeText(
                          '64 Day Streak',
                          style: size14weight500.copyWith(color: brownColor.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/journal-graph.png',
                      height: 70.0,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/stress.png',
                      height: 70.0,
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      spacing: 6.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Stress Level',
                          style: size18weight700.copyWith(color: brownColor),
                        ),
                        Row(
                          spacing: 3.0,
                          children: [
                            Container(
                              height: 8.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: yellowColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              height: 8.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: yellowColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              height: 8.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: yellowColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              height: 8.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: lightBrownColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              height: 8.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: lightBrownColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                        AutoSizeText(
                          'Level 3 (Normal)',
                          style: size14weight500.copyWith(color: brownColor.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/mood-tracker.png',
                      height: 70.0,
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Mood Tracker',
                          style: size18weight700.copyWith(color: brownColor),
                        ),
                        const SizedBox6(),
                        Image.asset(
                          'assets/images/mood-change.png',
                          height: 27.0,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
