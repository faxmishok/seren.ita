import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4F2),
      appBar: AppBarCustom(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: const Color(0xffF7F4F2),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: spacing16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AutoSizeText(
                'Notifications',
                style: size28weight700.copyWith(color: brownColor),
              ),
              const SizedBox(width: 12.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: lightOrangeColor,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: AutoSizeText(
                  '+11',
                  style: size12weight700.copyWith(color: orangeColor),
                ),
              ),
            ],
          ),
          const SizedBox24(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Earlier This Day',
                style: size18weight700.copyWith(color: brownColor),
              ),
            ],
          ),
          const SizedBox12(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox12(),
            itemBuilder: (context, index) {
              return _buildNotificaionItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificaionItem() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/notification-icon.png',
            height: 80.0,
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: context.width / 1.8,
            child: AutoSizeText(
              'Your yoga session starts in 30 minutes!',
              style: size16weight700.copyWith(color: brownColor),
            ),
          ),
        ],
      ),
    );
  }
}
