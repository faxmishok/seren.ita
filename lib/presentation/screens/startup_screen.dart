import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/services/notification_service.dart';
import 'package:serenita/foundation/state-logic/start-up/start_up_cubit.dart';
import 'package:serenita/presentation/screens/home_screen.dart';
import 'package:serenita/presentation/screens/landing_screen.dart';
import 'package:serenita/presentation/screens/splash_screen.dart';

class StartUpScreen extends StatelessWidget {
  StartUpScreen({super.key});

  final _startUpCubit = StartUpCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _startUpCubit..checkStartUp(),
        child: BlocConsumer<StartUpCubit, StartUpState>(
          listener: (context, state) {
            if (state is StartUpFailure) {
              getIt<NotificationService>().notify(context.tr(state.message));
            }
          },
          builder: (context, state) {
            if (state is StartUpUnauthenticated) {
              return const LandingScreen();
            } else if (state is StartUpAuthenticated) {
              return const HomeScreen();
            }

            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
