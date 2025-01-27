import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: const AppBarCustom(
        title: 'Mindful AI Chatbot',
        titleColor: brownColor,
        backgroundColor: lightBrownColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox70(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset('assets/images/chatbot.png'),
          ),
          const SizedBox50(),
          AutoSizeText(
            'Talk to Doctor Serenita AI',
            textAlign: TextAlign.center,
            style: size24weight800.copyWith(
              color: brownColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox16(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AutoSizeText(
              'You have no AI conversations. Get your mind healthy by starting a new one.',
              textAlign: TextAlign.center,
              style: size16weight500.copyWith(
                color: const Color(0xFF1F160F).withValues(alpha: 0.64),
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox50(),
          ButtonCustom(
            borderRadius: 100.0,
            bgColor: orangeColor,
            title: 'New Conversation',
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            height: 60.0,
            iconData: FontAwesomeIcons.plus,
            iconSize: 18.0,
            showLeftIcon: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
