import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/helpers/functions/messenger.dart';
import 'package:serenita/presentation/screens/startup_screen.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchData();
    });
  }

  fetchData() async {
    final result = await getIt<UserRelatedRemoteData>().fetchUserDetails();

    setState(() {
      userData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final firstName = userData?['name'] ?? 'User';
    final lastName = userData?['surname'] ?? 'User';
    final email = userData?['email'] ?? 'test@gmail.com';

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(brownColor, BlendMode.srcIn),
            image: AssetImage('assets/images/profile-setup.png'),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: spacing16.copyWith(top: 40.0),
              width: context.width,
              child: Row(
                children: [
                  AutoSizeText(
                    'Profile',
                    style: size20weight700.copyWith(color: whiteColor),
                  ),
                ],
              ),
            ),
            const SizedBox70(),
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'https://wallpapers.com/images/hd/minecraft-profile-pictures-1242-x-1235-zix8e1u4kw9zj3cj.jpg',
                height: 130.0,
                width: 130.0,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox16(),
            AutoSizeText(
              '$firstName $lastName',
              style: size24weight800.copyWith(
                color: brownColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox8(),
            AutoSizeText(
              '$email',
              style: size14weight700.copyWith(
                color: const Color(0xFF1F160F).withValues(alpha: 0.64),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox8(),
            AutoSizeText(
              'Milan, Italy',
              style: size14weight700.copyWith(
                color: const Color(0xFF1F160F).withValues(alpha: 0.64),
                letterSpacing: -0.5,
              ),
            ),
            _buildGeneralSettings(),
            const SizedBox24(),
            _buildSecurityPrivacy(),
            const SizedBox24(),
            _buildLogOut(),
            const SizedBox70(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'General Settings',
                style: size18weight800.copyWith(
                  color: brownColor,
                  letterSpacing: -0.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
        ),
        _buildSettingItem(
          name: 'Notifications',
          icon: Icons.notifications_outlined,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Personal Information',
          icon: Icons.person_outline,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Emergency Contact',
          icon: Icons.warning_rounded,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Language',
          icon: Icons.flag_outlined,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Invite Friends',
          icon: Icons.share_outlined,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Submit Feedback',
          icon: Icons.forum_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSecurityPrivacy() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Security & Privacy',
                style: size18weight800.copyWith(
                  color: brownColor,
                  letterSpacing: -0.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
        ),
        _buildSettingItem(
          name: 'Security',
          icon: Icons.lock_outline,
          onPressed: () {},
        ),
        const SizedBox8(),
        _buildSettingItem(
          name: 'Help Center',
          icon: Icons.chat_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLogOut() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Log Out',
                style: size18weight800.copyWith(
                  color: brownColor,
                  letterSpacing: -0.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: const Color(0xff1F160F).withValues(alpha: 0.32),
                onPressed: () {},
              ),
            ],
          ),
        ),
        _buildSettingItem(
          name: 'Log Out',
          icon: Icons.logout_outlined,
          onPressed: () async {
            showStyledConfirmationDialog(
              context: context,
              message: 'Do you want to log out?',
              cancelLabel: 'No',
              confirmLabel: 'Yes',
              onConfirmed: () async {
                await getIt<UserRelatedRemoteData>().signOut();

                // ignore: use_build_context_synchronously
                context.pushAndRemoveUntil(StartUpScreen());
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    String? name,
    IconData? icon,
    Function? onPressed,
  }) {
    return GestureDetector(
      onTap: () => onPressed!(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: whiteColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: lightBrownColor,
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 8.0),
            AutoSizeText(
              name!,
              style: size16weight700.copyWith(
                color: brownColor,
                letterSpacing: -0.5,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
              color: brownColor,
            ),
          ],
        ),
      ),
    );
  }
}
