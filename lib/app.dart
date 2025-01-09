import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/presentation/screens/startup_screen.dart';
import 'package:serenita/supplies/constants/app_constants.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appConstants.appName,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: navigatorKey,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          home: StartUpScreen(),
        ),
      ),
    );
  }
}
