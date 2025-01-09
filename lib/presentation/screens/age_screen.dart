import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/weight_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int _currentValue = 18;

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
              '2 of 3',
              style: size12weight700.copyWith(color: const Color(0xff926247)),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: context.width,
      padding: spacing16,
      child: Column(
        children: [
          const SizedBox30(),
          AutoSizeText(
            'What’s your age?',
            textAlign: TextAlign.center,
            style: size28weight700.copyWith(color: brownColor),
          ),
          NumberPicker(
            value: _currentValue,
            minValue: 0,
            maxValue: 100,
            haptics: true,
            itemHeight: 180.0,
            itemWidth: context.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: const Color(0xffDFE3CF), width: 4.0),
            ),
            selectedTextStyle: const TextStyle(
              fontSize: 128.0,
              fontWeight: FontWeight.w800,
              color: greenColor,
            ),
            textStyle: const TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.w800,
              color: Color(0xffACA9A5),
            ),
            onChanged: (value) => setState(() => _currentValue = value),
          ),
          ButtonCustom(
            borderRadius: 100.0,
            bgColor: brownColor,
            title: 'Continue',
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            height: 60.0,
            onPressed: () => context.push(const WeightScreen()),
          ),
        ],
      ),
    );
  }
}
