import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/all_set_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class NotificationsSetupScreen extends StatefulWidget {
  const NotificationsSetupScreen({super.key});

  @override
  State<NotificationsSetupScreen> createState() => _NotificationsSetupScreenState();
}

class _NotificationsSetupScreenState extends State<NotificationsSetupScreen> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/notification-setup.png'),
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
                    color: brownColor,
                  ),
                ),
                const SizedBox(width: 24.0),
                AutoSizeText(
                  'Notification Setup',
                  style: size20weight700.copyWith(color: brownColor),
                ),
              ],
            ),
          ),
          SizedBox(height: context.height / 2),
          _buildNotificationItem(
            'assets/images/chatbox-notification.png',
            'Chatbox Notification',
            _value1,
            (val) {
              setState(() {
                _value1 = val;
              });
            },
          ),
          const SizedBox12(),
          _buildNotificationItem(
            'assets/images/wellness-notification.png',
            'Wellness Notification',
            _value2,
            (val) {
              setState(() {
                _value2 = val;
              });
            },
          ),
          const SizedBox12(),
          _buildNotificationItem(
            'assets/images/tea-notification.png',
            '5 Min Chai- Tea Notification',
            _value3,
            (val) {
              setState(() {
                _value3 = val;
              });
            },
          ),
          const SizedBox12(),
          _buildNotificationItem(
            'assets/images/community-notification.png',
            'Community Notification',
            _value4,
            (val) {
              setState(() {
                _value4 = val;
              });
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ButtonCustom(
              borderRadius: 100.0,
              bgColor: brownColor,
              title: 'Continue',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              height: 60.0,
              onPressed: () => context.push(const AllSetScreen()),
            ),
          ),
          const SizedBox24(),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    String asset,
    String notification,
    bool value,
    Function onChanged,
  ) {
    return Row(
      children: [
        const SizedBox(width: 12.0),
        Image.asset(
          asset,
          height: 50.0,
        ),
        const SizedBox(width: 12.0),
        AutoSizeText(
          notification,
          style: size16weight700.copyWith(color: brownColor),
        ),
        const Spacer(),
        CupertinoSwitch(
          value: value,
          activeTrackColor: greenColor,
          onChanged: (val) => onChanged(val),
        ),
        const SizedBox(width: 12.0),
      ],
    );
  }
}
