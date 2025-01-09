import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/services/hive_service.dart';
import 'package:serenita/foundation/services/notification_service.dart';
import 'package:serenita/foundation/state-logic/sign-in/sign_in_cubit.dart';
import 'package:serenita/foundation/state-logic/sign-up/sign_up_cubit.dart';
import 'package:serenita/foundation/state-logic/start-up/start_up_cubit.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();
final ctx = navigatorKey.currentContext;

Future<void> setupLocator() async {
  getIt.registerLazySingleton(() => StartUpCubit(), dispose: (StartUpCubit i) => i.close());
  getIt.registerLazySingleton(() => SignInCubit(), dispose: (SignInCubit i) => i.close());
  getIt.registerLazySingleton(() => SignUpCubit(), dispose: (SignUpCubit i) => i.close());

  getIt.registerLazySingleton(() => UserRelatedLocalData());
  getIt.registerLazySingleton(() => UserRelatedRemoteData());
  getIt.registerLazySingleton(() => NotificationService());

  getIt.registerLazySingleton(() => HiveService());
  await getIt<HiveService>().init();
}
