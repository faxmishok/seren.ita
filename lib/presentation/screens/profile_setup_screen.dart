import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/classes/validations.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/services/notification_service.dart';
import 'package:serenita/foundation/state-logic/profile-setup/profile_setup_cubit.dart';
import 'package:serenita/presentation/screens/notifications_setup_screen.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/presentation/widgets/common/text_field_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _profileSetupCubit = ProfileSetupCubit();
  final _formKey = GlobalKey<FormState>();

  Uint8List? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      body: BlocProvider(
        create: (context) => _profileSetupCubit,
        child: BlocListener<ProfileSetupCubit, ProfileSetupState>(
          listener: (context, state) {
            if (state is ProfileSetupSuccess) {
              context.push(const NotificationsSetupScreen());
            }

            if (state is ProfileSetupFailure) {
              getIt<NotificationService>().notify(context.tr(state.message));
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
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
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  AutoSizeText(
                    'Profile Setup',
                    style: size20weight700.copyWith(color: whiteColor),
                  ),
                ],
              ),
            ),
            const SizedBox70(),
            SizedBox(
              height: 150.0,
              child: Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Userbox_creeper.svg/800px-Userbox_creeper.svg.png',
                      height: 130.0,
                      width: 130.0,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: const BoxDecoration(
                        color: brownColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: whiteColor,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  children: [
                    TextFieldCustom(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      validator: (value) => Validations(context: context).validateInputText(value!),
                      onChanged: (value) => _profileSetupCubit.setFirstNameValue(value),
                      labelText: context.tr('first_name'),
                      showInputTitle: true,
                      labelColor: brownColor,
                      labelFontSize: 14.0,
                      labelFontWeight: FontWeight.w800,
                      inputFillColor: whiteColor,
                      borderRadius: 100.0,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                      hasBorder: false,
                      cursorColor: greenColor,
                    ),
                    const SizedBox16(),
                    TextFieldCustom(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      validator: (value) => Validations(context: context).validateInputText(value!),
                      onChanged: (value) => _profileSetupCubit.setLastNameValue(value),
                      labelText: context.tr('last_name'),
                      showInputTitle: true,
                      labelColor: brownColor,
                      labelFontSize: 14.0,
                      labelFontWeight: FontWeight.w800,
                      inputFillColor: whiteColor,
                      borderRadius: 100.0,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                      hasBorder: false,
                      cursorColor: greenColor,
                    ),
                    const SizedBox16(),
                    TextFieldCustom(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      onChanged: (value) {},
                      labelText: 'Gender',
                      showInputTitle: true,
                      labelColor: brownColor,
                      labelFontSize: 14.0,
                      labelFontWeight: FontWeight.w800,
                      inputFillColor: whiteColor,
                      borderRadius: 100.0,
                      prefixIcon: const Icon(
                        Icons.transgender,
                        size: 20.0,
                      ),
                      hasBorder: false,
                      cursorColor: greenColor,
                    ),
                    const SizedBox16(),
                    TextFieldCustom(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      onChanged: (value) {},
                      labelText: 'Location',
                      showInputTitle: true,
                      labelColor: brownColor,
                      labelFontSize: 14.0,
                      labelFontWeight: FontWeight.w800,
                      inputFillColor: whiteColor,
                      borderRadius: 100.0,
                      prefixIcon: const Icon(
                        Icons.location_on,
                        size: 20.0,
                      ),
                      hasBorder: false,
                      cursorColor: greenColor,
                    ),
                    const SizedBox50(),
                    BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
                      builder: (context, state) {
                        return ButtonCustom(
                          borderRadius: 100.0,
                          bgColor: brownColor,
                          title: 'Continue',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          height: 60.0,
                          status: state is ProfileSetupBusy,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _profileSetupCubit.setupProfile();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
