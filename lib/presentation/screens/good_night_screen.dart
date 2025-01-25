import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/home_screen.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class GoodNightScreen extends StatefulWidget {
  const GoodNightScreen({super.key});

  @override
  State<GoodNightScreen> createState() => _GoodNightScreenState();
}

class _GoodNightScreenState extends State<GoodNightScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      if (userSnapshot.exists) {
        setState(() {
          userName = userSnapshot['name'] ?? 'User'; // Fallback to 'User' if name is null
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff211710),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height,
          width: context.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/good-night.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox50(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xff702901),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: AutoSizeText(
                  'ALARM AT 10:05',
                  style: size10weight800.copyWith(color: orangeColor),
                ),
              ),
              const SizedBox24(),
              AutoSizeText(
                'Good Night, ${userName ?? 'User'}!',
                style: size24weight800.copyWith(color: whiteColor),
              ),
              const SizedBox12(),
              AutoSizeText(
                '02:15',
                style: size24weight800.copyWith(
                  color: whiteColor,
                  fontSize: 72.0,
                ),
              ),
              const SizedBox24(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.schedule,
                    color: whiteColor,
                  ),
                  const SizedBox(width: 8.0),
                  AutoSizeText(
                    'Sleep Duration',
                    style: size14weight600.copyWith(color: whiteColor),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: whiteColor),
                    ),
                    child: AutoSizeText(
                      '2h 15m',
                      style: size14weight800.copyWith(color: whiteColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () => context.pushAndRemoveUntil(const HomeScreen()),
            child: Image.asset(
              'assets/images/waved-container.png',
            ),
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () => context.pushAndRemoveUntil(const HomeScreen()),
            child: Column(
              children: [
                const Icon(Icons.arrow_upward),
                const SizedBox12(),
                AutoSizeText(
                  'Swipe to Wake Up',
                  style: size14weight700.copyWith(color: brownColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
