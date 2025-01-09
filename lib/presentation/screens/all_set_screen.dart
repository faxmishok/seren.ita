import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/presentation/screens/home_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: whiteColor,
            ),
            const SizedBox12(),
            AutoSizeText(
              'You’re all Set Up.',
              style: size28weight700.copyWith(color: whiteColor),
            ),
            const SizedBox12(),
            AutoSizeText(
              'Your health score is:',
              style: size18weight500.copyWith(color: whiteColor),
            ),
            const SizedBox24(),
            Image.asset(
              'assets/images/80.png',
              height: 300.0,
            ),
            const SizedBox24(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AutoSizeText(
                'We’re redirecting you back to the home screen. Are you ready?',
                textAlign: TextAlign.center,
                style: size18weight500.copyWith(color: whiteColor),
              ),
            ),
            const SizedBox24(),
            AutoSizeText(
              'MOOD: NEUTRAL',
              style: size18weight500.copyWith(color: whiteColor),
            ),
            const SizedBox24(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ButtonCustom(
                borderRadius: 100.0,
                bgColor: greenColor,
                borderColor: whiteColor,
                outline: true,
                title: 'Let’s Be Mindful',
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                height: 60.0,
                onPressed: () => ctx?.pushAndRemoveUntil(const HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
