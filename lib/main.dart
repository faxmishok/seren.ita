import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenita/app.dart';
import 'package:serenita/foundation/helpers/classes/app_bloc_observer.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  await setupLocator();

  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('it'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const App(),
    ),
  );
}
