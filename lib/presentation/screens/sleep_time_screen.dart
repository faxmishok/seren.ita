import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/good_night_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class SleepTimeScreen extends StatelessWidget {
  final double min = 0;
  final double max = 24;

  const SleepTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brownColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/sleep-time.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.6),
            BlendMode.darken,
          ),
        ),
      ),
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
              ],
            ),
          ),
          const SizedBox30(),
          AutoSizeText(
            'Select the time for sleep',
            textAlign: TextAlign.center,
            style: size32weight800.copyWith(color: whiteColor),
          ),
          const Spacer(),
          AnimatedWeightPicker(
            min: min,
            max: max,
            dialColor: orangeColor,
            dialThickness: 3,
            selectedValueStyle: size28weight700.copyWith(color: whiteColor),
            suffixTextColor: whiteColor,
            suffix: Text(
              'Hours',
              style: size16weight600.copyWith(color: whiteColor),
            ),
            squeeze: 0.5,
            onChange: (newValue) {},
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ButtonCustom(
              borderRadius: 100.0,
              bgColor: brownColor,
              title: 'Continue',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              height: 60.0,
              onPressed: () => context.push(const GoodNightScreen()),
            ),
          ),
          const SizedBox100(),
        ],
      ),
    );
  }
}
