import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 40.0,
      child: AutoSizeText(
        title,
        maxLines: 1,
        minFontSize: 10.0,
        style: size14weight600,
      ),
    );
  }
}
