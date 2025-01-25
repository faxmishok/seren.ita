part of 'profile_setup_cubit.dart';

@immutable
sealed class ProfileSetupState {}

final class ProfileSetupInitial extends ProfileSetupState {}

final class ProfileSetupBusy extends ProfileSetupState {}

final class ProfileSetupSuccess extends ProfileSetupState {}

final class ProfileSetupFailure extends ProfileSetupState {
  final String message;

  ProfileSetupFailure(this.message);
}
