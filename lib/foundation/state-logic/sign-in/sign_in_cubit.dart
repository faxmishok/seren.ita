import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/helpers/functions/debugging.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  UserRelatedLocalData get _userRelatedLocalData => getIt<UserRelatedLocalData>();
  UserRelatedRemoteData get _userRelatedRemoteData => getIt<UserRelatedRemoteData>();

  String emailFieldValue = '';
  String passwordFieldValue = '';

  void setEmailValue(String value) {
    emailFieldValue = value;
  }

  void setPasswordValue(String value) {
    passwordFieldValue = value;
  }

  Future<void> logIn() async {
    try {
      emit(SignInBusy());

      final email = emailFieldValue;
      final password = passwordFieldValue;

      final result = await _userRelatedRemoteData.signIn(
        email,
        password,
      );

      if (result != null) {
        _userRelatedLocalData.storeIsLoggedIn(true);

        emit(SignInSuccess());
      } else {
        emit(SignInFailure('something_went_wrong'));
      }
    } catch (e, s) {
      logError(e, s);
      emit(SignInFailure('something_went_wrong'));
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      emit(SignInGoogleBusy());

      final result = await _userRelatedRemoteData.signInWithGoogle();

      if (result != null) {
        _userRelatedLocalData.storeIsLoggedIn(true);

        emit(SignInSuccess());
      } else {
        emit(SignInFailure('something_went_wrong'));
      }
    } catch (e, s) {
      logError(e, s);
      emit(SignInFailure('something_went_wrong'));
    }
  }
}
