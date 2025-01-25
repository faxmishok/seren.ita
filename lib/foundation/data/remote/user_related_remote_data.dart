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
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String userId = result.user!.uid;

      await _userRelatedLocalData.storeUserId(userId);

      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'user_id': userId,
        'name': null,
        'surname': null,
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
      // Initiate Google Sign-In
      final user = await _googleSignIn.signIn();

      // Get authentication details
      final auth = await user?.authentication;

      // Create Google credential
      final credential = GoogleAuthProvider.credential(
        idToken: auth?.idToken,
        accessToken: auth?.accessToken,
      );

      // Sign in to Firebase with Google credentials
      final userCredential = await _auth.signInWithCredential(credential);

      // Fetch the signed-in user's ID and email
      final String userId = userCredential.user?.uid ?? '';
      final String? email = userCredential.user?.email;

      // Check if user already exists in Firestore
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        // Safely handle the displayName split logic
        final displayName = user?.displayName ?? 'Default User';
        final nameParts = displayName.split(' ');
        final firstName = nameParts.isNotEmpty ? nameParts.first : 'First Name';
        final lastName = (nameParts.length > 1) ? nameParts.sublist(1).join(' ') : 'Last Name';

        // If the user doesn't exist, add them to Firestore
        await userDoc.set({
          'user_id': userId,
          'name': firstName,
          'surname': lastName,
          'email': email,
          'password': null, // Password is not available with Google sign-in
          'date_of_birth': null,
          'nationality': null,
          'mood': 'Neutral',
          'preferences_id': null,
          'activity_log_id': null,
        });

        log('New user registered in Firestore: $userId');
      } else {
        log('User already exists in Firestore: $userId');
      }

      return userCredential;
    } catch (e) {
      log('Something went wrong during Google sign-in: $e');
    }
    return null;
  }

  Future<void> setProfileDetails(
    String firstName,
    String lastName,
  ) async {
    try {
      final userId = _userRelatedLocalData.userId;

      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'name': firstName,
        'surname': lastName,
      });
    } catch (e) {
      log('Something went wrong $e');
    }
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
      await _userRelatedLocalData.storeUserId('');
    } catch (e) {
      log('Something went wrong $e');
    }
  }
}
