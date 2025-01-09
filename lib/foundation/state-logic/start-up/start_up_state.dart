part of 'start_up_cubit.dart';

@immutable
sealed class StartUpState {}

final class StartUpInitial extends StartUpState {}

final class StartUpLoading extends StartUpState {}

final class StartUpAuthenticated extends StartUpState {}

final class StartUpUnauthenticated extends StartUpState {}

final class StartUpFailure extends StartUpState {
  final String message;

  StartUpFailure({
    required this.message,
  });
}
