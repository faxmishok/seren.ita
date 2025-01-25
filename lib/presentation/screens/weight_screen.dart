import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/profile_setup_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final double min = 30;
  final double max = 200;
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        title: 'Assessment',
        titleColor: brownColor,
        backgroundColor: lightBrownColor,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: brownColor,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xffE8DDD9),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: AutoSizeText(
              '3 of 3',
              style: size12weight700.copyWith(color: const Color(0xff926247)),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: context.width,
        padding: spacing16,
        child: Column(
          children: [
            const SizedBox30(),
            AutoSizeText(
              'What’s your weight?',
              textAlign: TextAlign.center,
              style: size28weight700.copyWith(color: brownColor),
            ),
            const SizedBox150(),
            AnimatedWeightPicker(
              min: min,
              max: max,
              dialColor: greenColor,
              dialThickness: 3,
              selectedValueStyle: size28weight700.copyWith(color: brownColor),
              suffixTextColor: brownColor,
              squeeze: 1,
              onChange: (newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
            ),
            const SizedBox150(),
            ButtonCustom(
              borderRadius: 100.0,
              bgColor: brownColor,
              title: 'Continue',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              height: 60.0,
              onPressed: () => context.push(const ProfileSetupScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
