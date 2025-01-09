import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/foundation/helpers/classes/validations.dart';
import 'package:serenita/presentation/screens/home_screen.dart';
import 'package:serenita/presentation/screens/sign_up_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/presentation/widgets/common/text_field_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: context.tr('sign_in_to_serenita'),
      ),
      body: _buildBody(),
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
              TextFieldCustom(
                key: const Key('sigin_email_input'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                validator: (value) => Validations(context: context).validateEmail(value!),
                onChanged: (value) {
                  // _loginCubit.setEmailValue(value);
                },
                labelText: context.tr('email'),
                showInputTitle: true,
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
                  // _loginCubit.setPasswordValue(value);
                },
                onFieldSubmitted: (val) {
                  // _loginCubit.logIn();
                },
              ),
              const SizedBox15(),
              ButtonCustom(
                title: context.tr('sign_in').toUpperCase(),
                onPressed: () {
                  context.push(const HomeScreen());
                  // if (_formKey.currentState!.validate()) {
                  // _loginCubit.logIn();
                  // }
                },
              ),
              const SizedBox24(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: grey400Color.withValues(alpha: 0.35),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AutoSizeText(
                    context.tr('or'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: grey400Color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: grey400Color.withValues(alpha: 0.35),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox24(),
              RichText(
                text: TextSpan(
                  style: size13weight400.copyWith(color: grey800Color),
                  children: [
                    TextSpan(text: '${context.tr('dont_have_an_account')} '),
                    TextSpan(
                      text: context.tr('sign_up'),
                      style: size13weight600.copyWith(color: primaryColor),
                      recognizer: TapGestureRecognizer()..onTap = () => context.pushReplacement(const SignUpScreen()),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //  context.push(const ForgotPasswordScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: AutoSizeText(
                    context.tr('forgot_password'),
                    textAlign: TextAlign.right,
                    style: size12weight600.copyWith(color: primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
