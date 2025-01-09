import 'package:flutter/material.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class NotificationsSetup extends StatefulWidget {
  const NotificationsSetup({super.key});

  @override
  State<NotificationsSetup> createState() => _NotificationsSetupState();
}

class _NotificationsSetupState extends State<NotificationsSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        title: 'Notification Setup',
        titleColor: brownColor,
        backgroundColor: lightBrownColor,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: brownColor,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
