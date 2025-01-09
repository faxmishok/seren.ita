import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

class UserRelatedRemoteData {
  final _auth = FirebaseAuth.instance;

  UserRelatedLocalData get _userRelatedLocalData => getIt<UserRelatedLocalData>();

  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<User?> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _userRelatedLocalData.storeIsLoggedIn(false);      
    } catch (e) {
      log('Something went wrong $e');
    }
  }
}
