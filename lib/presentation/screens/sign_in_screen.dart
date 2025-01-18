import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/classes/validations.dart';
import 'package:serenita/foundation/services/notification_service.dart';
import 'package:serenita/foundation/state-logic/sign-in/sign_in_cubit.dart';
import 'package:serenita/presentation/screens/health_goal_screen.dart';
import 'package:serenita/presentation/screens/sign_up_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/presentation/widgets/common/text_field_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

import '../../foundation/helpers/functions/locator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInCubit = SignInCubit();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: const AppBarCustom(
        backgroundColor: lightBrownColor,
      ),
      body: BlocProvider(
        create: (context) => _signInCubit,
        child: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context.pushAndRemoveUntil(const HealthGoalScreen());
            }

            if (state is SignInFailure) {
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
      child: Form(
        key: _formKey,
        child: Container(
          padding: spacing16,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100.0,
              ),
              const SizedBox24(),
              AutoSizeText(
                'sign_in_to_serenita'.tr(),
                style: size28weight800.copyWith(color: brownColor, letterSpacing: -1),
              ),
              const SizedBox24(),
              TextFieldCustom(
                key: const Key('sigin_email_input'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                validator: (value) => Validations(context: context).validateEmail(value!),
                onChanged: (value) {
                  _signInCubit.setEmailValue(value);
                },
                labelText: context.tr('email'),
                showInputTitle: true,
                labelColor: brownColor,
                labelFontSize: 14.0,
                labelFontWeight: FontWeight.w800,
                inputFillColor: whiteColor,
                borderRadius: 100.0,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20.0,
                ),
                hasBorder: false,
                cursorColor: greenColor,
              ),
              const SizedBox12(),
              TextFieldCustom(
                key: const Key('signin_password_input'),
                obscureText: true,
                labelText: context.tr('password'),
                showInputTitle: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                textInputAction: TextInputAction.send,
                validator: (value) => Validations(context: context).validatePassword(value!, strict: false),
                onChanged: (value) {
                  _signInCubit.setPasswordValue(value);
                },
                onFieldSubmitted: (val) {
                  _signInCubit.logIn();
                },
                labelColor: brownColor,
                labelFontSize: 14.0,
                labelFontWeight: FontWeight.w800,
                inputFillColor: whiteColor,
                borderRadius: 100.0,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20.0,
                ),
                hasBorder: false,
                cursorColor: greenColor,
              ),
              const SizedBox24(),
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return ButtonCustom(
                    title: context.tr('sign_in'),
                    borderRadius: 100.0,
                    bgColor: brownColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    height: 60.0,
                    status: state is SignInBusy,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signInCubit.logIn();
                      }
                    },
                  );
                },
              ),
              const SizedBox50(),
              _buildSocialField(),
              const SizedBox50(),
              RichText(
                text: TextSpan(
                  style: size14weight500.copyWith(color: grey800Color),
                  children: [
                    TextSpan(text: '${context.tr('dont_have_an_account')} '),
                    TextSpan(
                      text: context.tr('sign_up'),
                      style: size13weight600.copyWith(color: orangeColor, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () => context.pushReplacement(const SignUpScreen()),
                    ),
                  ],
                ),
              ),
              const SizedBox6(),
              GestureDetector(
                onTap: () async {},
                child: AutoSizeText(
                  context.tr('forgot_password'),
                  textAlign: TextAlign.center,
                  style: size14weight700.copyWith(color: orangeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(16.0),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffE8DDD9)),
          ),
          icon: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              // if (state is SignInGoogleBusy) {
              //   return const SizedBox(
              //     height: 24.0,
              //     width: 24.0,
              //     child: CircularProgressIndicator(
              //       color: Color(0xff926247),
              //     ),
              //   );
              // }

              return const Icon(
                FontAwesomeIcons.facebookF,
                color: Color(0xff926247),
              );
            },
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () => _signInCubit.logInWithGoogle(),
          padding: const EdgeInsets.all(16.0),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffE8DDD9)),
          ),
          icon: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              if (state is SignInGoogleBusy) {
                return const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    color: Color(0xff926247),
                  ),
                );
              }

              return const Icon(
                FontAwesomeIcons.google,
                color: Color(0xff926247),
              );
            },
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(16.0),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffE8DDD9)),
          ),
          icon: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              // if (state is SignInGoogleBusy) {
              //   return const SizedBox(
              //     height: 24.0,
              //     width: 24.0,
              //     child: CircularProgressIndicator(
              //       color: Color(0xff926247),
              //     ),
              //   );
              // }

              return const Icon(
                FontAwesomeIcons.instagram,
                color: Color(0xff926247),
              );
            },
          ),
        ),
      ],
    );
  }
}
