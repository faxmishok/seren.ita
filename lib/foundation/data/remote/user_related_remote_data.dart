import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

class UserRelatedRemoteData {
  final _auth = FirebaseAuth.instance;

  UserRelatedLocalData get _userRelatedLocalData => getIt<UserRelatedLocalData>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

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

      final String userId = result.user!.uid;

      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'user_id': userId,
        'name': firstName,
        'surname': lastName,
        'email': email,
        'password': password,
        'date_of_birth': null,
        'nationality': null,
        'mood': 'Neutral',
        'preferences_id': null,
        'activity_log_id': null,
      });

      return result.user;
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final result = await _facebookAuth.login();

      log('Result: ${result.accessToken?.tokenString}');

      final credential = FacebookAuthProvider.credential('${result.accessToken?.tokenString}');

      log('Credential: $credential');

      return _auth.signInWithCredential(credential);
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();

      final auth = await user?.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth?.idToken, accessToken: auth?.accessToken);

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<bool> signOutFromGoogle() async {
    try {
      if (await isSignedIn()) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
        log('*** Signed Out from Google Account ***');
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await signOutFromGoogle();
      await _facebookAuth.logOut();
      await _userRelatedLocalData.storeIsLoggedIn(false);
    } catch (e) {
      log('Something went wrong $e');
    }
  }
}
