import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/age_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class HealthGoalScreen extends StatefulWidget {
  const HealthGoalScreen({super.key});

  @override
  State<HealthGoalScreen> createState() => _HealthGoalScreenState();
}

class _HealthGoalScreenState extends State<HealthGoalScreen> {
  String? selectedOption;

  final options = [
    'I wanna reduce stress',
    'I wanna try AI Therapy',
    'I want to cope with trauma',
    'I want to be a better person',
    'Just trying out the app, mate!',
  ];

  final icons = [
    'assets/images/heart.png',
    'assets/images/robot.png',
    'assets/images/flag.png',
    'assets/images/happy.png',
    'assets/images/mobile.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        title: 'Assessment',
        titleColor: brownColor,
        backgroundColor: lightBrownColor,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xffE8DDD9),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: AutoSizeText(
              '1 of 3',
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
      padding: spacing16,
      child: Column(
        children: [
          const SizedBox30(),
          AutoSizeText(
            'What’s your health goal for today?',
            textAlign: TextAlign.center,
            style: size28weight700.copyWith(color: brownColor),
          ),
          const SizedBox50(),
          _buildOptions(),
          const SizedBox50(),
          ButtonCustom(
            borderRadius: 100.0,
            bgColor: brownColor,
            title: 'Continue',
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            height: 60.0,
            onPressed: () => context.push(const AgeScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox12(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = options[index];
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: selectedOption == options[index] ? greenColor : Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: selectedOption == options[index] ? Border.all(color: const Color(0xffDFE3CF), width: 3.0) : const Border(),
            ),
            child: Row(
              children: [
                Image.asset(
                  icons[index],
                  color: selectedOption == options[index] ? whiteColor : const Color(0xffC9C7C5),
                  height: 25.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    options[index],
                    style: size16weight700.copyWith(color: selectedOption == options[index] ? whiteColor : brownColor),
                  ),
                ),
                Icon(
                  selectedOption == options[index] ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: selectedOption == options[index] ? whiteColor : brownColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
