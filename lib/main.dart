import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenita/app.dart';
import 'package:serenita/foundation/helpers/classes/app_bloc_observer.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: 'AIzaSyAd91ieAqhJhcpjHXV77v-spawJqzOtY6U',
            appId: '1:74893842062:web:6b3fb696c35e5ca6b21bdf',
            messagingSenderId: '',
            projectId: 'serenita-001',
          )
        : null,
  );
  await EasyLocalization.ensureInitialized();

  await setupLocator();

  Bloc.observer = AppBlocObserver();

  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppHeight: 915.0,
    webAppWidth: 412.0,
    app: const App(),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('it'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: runnableApp,
    ),
  );
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppHeight,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        height: webAppHeight,
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}
