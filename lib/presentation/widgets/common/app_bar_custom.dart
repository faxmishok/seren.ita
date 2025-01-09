import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? assetTitle;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;

  const AppBarCustom({
    super.key,
    this.title = '',
    this.assetTitle,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: assetTitle ?? AutoSizeText('$title'),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      leading: leading,
      elevation: 0.0,
      backgroundColor: whiteColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
