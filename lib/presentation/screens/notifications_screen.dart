import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference collection = FirebaseFirestore.instance.collection('Notifications');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: lightBrownColor,
      ),
      body: StreamBuilder(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot snapshot) {
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
                  '+${snapshot.data!.docs.length}',
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
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox12(),
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return _buildNotificaionItem(notification: documentSnapshot['content']);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificaionItem({String? notification}) {
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
              notification!,
              style: size16weight700.copyWith(color: brownColor),
            ),
          ),
        ],
      ),
    );
  }
}
