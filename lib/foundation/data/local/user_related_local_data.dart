import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';
import 'package:serenita/foundation/services/hive_service.dart';

class UserRelatedLocalData {
  Box<dynamic> get _preferencesBox => getIt<HiveService>().userRelatedBox;

  String get language => _get('language', defaultValue: 'en');
  Future<void> storeLanguage(String value) => _store('language', value);

  bool get isLoggedIn => _get('is_logged_in', defaultValue: false);
  Future<void> storeIsLoggedIn(bool value) => _store('is_logged_in', value);

  String get userId => _get('user_id', defaultValue: '');
  Future<void> storeUserId(String value) => _store('user_id', value);

  bool get seenEnablePushNotifications => _get('seen_enable_push_notifications', defaultValue: false);
  Future<void> storeSeenEnablePushNotifications(bool value) => _store('seen_enable_push_notifications', value);
  Future<void> markSeenEnabledPushnotificationsTrue() => storeSeenEnablePushNotifications(true);

  Future<void> _store(String key, Object value) async {
    debugPrint('[STORED] $key: $value');

    return await _preferencesBox.put(key, value);
  }

  T _get<T>(String key, {T? defaultValue}) {
    return _preferencesBox.get(key, defaultValue: defaultValue) as T;
  }
}
