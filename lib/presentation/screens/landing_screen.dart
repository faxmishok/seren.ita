import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/presentation/screens/sign_in_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: spacing16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100.0,
            ),
            const SizedBox24(),
            AutoSizeText.rich(
              TextSpan(
                text: 'Welcome to the ultimate ',
                children: [
                  TextSpan(
                    text: 'Seren.iTà!',
                    style: size28weight700.copyWith(color: const Color(0xff926247)),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: size28weight700.copyWith(color: brownColor),
            ),
            const SizedBox24(),
            AutoSizeText(
              'Your mindful mental health AI companion for everyone, anywhere. 🍃',
              textAlign: TextAlign.center,
              style: size18weight500.copyWith(color: brownColor.withValues(alpha: 0.65)),
            ),
            const SizedBox24(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 335.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                  ),
                ),
                Image.asset(
                  'assets/images/landing.png',
                  height: 350.0,
                ),
              ],
            ),
            const SizedBox12(),
            ButtonCustom(
              borderRadius: 100.0,
              bgColor: brownColor,
              title: 'Get Started',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              width: 200.0,
              height: 60.0,
              onPressed: () => ctx?.pushReplacement(const SignInScreen()),
            ),
            const SizedBox24(),
            RichText(
              text: TextSpan(
                style: size13weight400.copyWith(color: grey800Color),
                children: [
                  TextSpan(text: '${ctx?.tr('already_have_an_account')} '),
                  TextSpan(
                    text: ctx?.tr('sign_in'),
                    style: size13weight600.copyWith(color: orangeColor, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () => ctx?.pushReplacement(const SignInScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
