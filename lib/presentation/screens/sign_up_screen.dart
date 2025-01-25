import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/classes/validations.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/services/notification_service.dart';
import 'package:serenita/foundation/state-logic/sign-up/sign_up_cubit.dart';
import 'package:serenita/presentation/screens/health_goal_screen.dart';
import 'package:serenita/presentation/screens/sign_in_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/presentation/widgets/common/text_field_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpCubit = SignUpCubit();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: const AppBarCustom(
        backgroundColor: lightBrownColor,
      ),
      body: BlocProvider(
        create: (context) => _signUpCubit,
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              context.pushAndRemoveUntil(const HealthGoalScreen());
            }

            if (state is SignUpFailure) {
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
                'sign_up'.tr(),
                style: size28weight800.copyWith(color: brownColor, letterSpacing: -1),
              ),
              const SizedBox24(),
              TextFieldCustom(
                key: const Key('signup_email_input'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                validator: (value) => Validations(context: context).validateEmail(value!),
                onChanged: (value) {
                  _signUpCubit.setEmailValue(value);
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
                key: const Key('login_password_input'),
                obscureText: true,
                labelText: context.tr('password'),
                showInputTitle: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                textInputAction: TextInputAction.send,
                validator: (value) => Validations(context: context).validatePassword(value!, strict: true),
                onChanged: (value) {
                  _signUpCubit.setPasswordValue(value);
                },
                labelColor: brownColor,
                labelFontSize: 14.0,
                labelFontWeight: FontWeight.w800,
                inputFillColor: whiteColor,
                borderRadius: 100.0,
                prefixIcon: const Icon(
                  Icons.password_outlined,
                  size: 20.0,
                ),
                hasBorder: false,
                cursorColor: greenColor,
              ),
              const SizedBox12(),
              TextFieldCustom(
                key: const Key('login_repeat_password_input'),
                obscureText: true,
                labelText: context.tr('repeat_password'),
                showInputTitle: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                textInputAction: TextInputAction.send,
                validator: (value) => Validations(context: context).validateConfirmPassword(value: value, password: _signUpCubit.passwordFieldValue),
                onChanged: (value) {
                  _signUpCubit.setConfirmPasswordValue(value);
                },
                onFieldSubmitted: (val) {
                  _signUpCubit.signUp();
                },
                labelColor: brownColor,
                labelFontSize: 14.0,
                labelFontWeight: FontWeight.w800,
                inputFillColor: whiteColor,
                borderRadius: 100.0,
                prefixIcon: const Icon(
                  Icons.password_outlined,
                  size: 20.0,
                ),
                hasBorder: false,
                cursorColor: greenColor,
              ),
              const SizedBox24(),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return ButtonCustom(
                    title: context.tr('sign_up'),
                    borderRadius: 100.0,
                    bgColor: brownColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    height: 60.0,
                    status: state is SignUpBusy,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _signUpCubit.signUp();
                      }
                    },
                  );
                },
              ),
              const SizedBox24(),
              RichText(
                text: TextSpan(
                  style: size13weight400.copyWith(color: grey800Color),
                  children: [
                    TextSpan(text: '${context.tr('already_have_an_account')} '),
                    TextSpan(
                      text: context.tr('sign_in'),
                      style: size13weight600.copyWith(color: orangeColor, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () => context.pushReplacement(const SignInScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
