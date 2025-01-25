import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:serenita/foundation/data/remote/user_related_remote_data.dart';
import 'package:serenita/foundation/helpers/functions/debugging.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit() : super(ProfileSetupInitial());

  UserRelatedRemoteData get _userRelatedRemoteData => getIt<UserRelatedRemoteData>();

  String firstNameFieldValue = '';
  String lastNameFieldValue = '';

  void setFirstNameValue(String value) {
    firstNameFieldValue = value;
  }

  void setLastNameValue(String value) {
    lastNameFieldValue = value;
  }

  Future<void> setupProfile() async {
    try {
      emit(ProfileSetupBusy());

      final firstName = firstNameFieldValue;
      final lastName = lastNameFieldValue;

      await _userRelatedRemoteData.setProfileDetails(
        firstName,
        lastName,
      );

      emit(ProfileSetupSuccess());
    } catch (e, s) {
      logError(e, s);
      emit(ProfileSetupFailure(e.toString()));
    }
  }
}
