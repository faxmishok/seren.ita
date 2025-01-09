import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/helpers/functions/debugging.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  UserRelatedLocalData get _userRelatedLocalData => getIt<UserRelatedLocalData>();
  UserRelatedRemoteData get _userRelatedRemoteData => getIt<UserRelatedRemoteData>();

  String emailFieldValue = '';
  String firstNameFieldValue = '';
  String lastNameFieldValue = '';
  String passwordFieldValue = '';
  String confirmPasswordFieldValue = '';

  void setEmailValue(String value) {
    emailFieldValue = value;
  }

  void setFirstNameValue(String value) {
    firstNameFieldValue = value;
  }

  void setLastNameValue(String value) {
    lastNameFieldValue = value;
  }

  void setPasswordValue(String value) {
    passwordFieldValue = value;
  }

  void setConfirmPasswordValue(String value) {
    confirmPasswordFieldValue = value;
  }

  Future<void> signUp() async {
    try {
      emit(SignUpBusy());

      final firstName = firstNameFieldValue;
      final lastName = lastNameFieldValue;
      final email = emailFieldValue;
      final password = passwordFieldValue;

      final result = await _userRelatedRemoteData.signUp(
        firstName,
        lastName,
        email,
        password,
      );

      if (result != null) {
        _userRelatedLocalData.storeIsLoggedIn(true);
        
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure('something_went_wrong'));
      }
    } catch (e, s) {
      logError(e, s);
      emit(SignUpFailure(e.toString()));
    }
  }
}
