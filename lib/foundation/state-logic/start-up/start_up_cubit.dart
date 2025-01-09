import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serenita/foundation/data/local/user_related_local_data.dart';
import 'package:serenita/foundation/helpers/functions/locator.dart';

part 'start_up_state.dart';

class StartUpCubit extends Cubit<StartUpState> {
  StartUpCubit() : super(StartUpInitial());

  UserRelatedLocalData get _userRelatedLocalData => getIt<UserRelatedLocalData>();

  Future<void> checkStartUp({bool delay = false}) async {
    emit(StartUpInitial());

    await checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    emit(StartUpLoading());

    final isLoggedIn = _userRelatedLocalData.isLoggedIn;

    if (isLoggedIn) {
      emit(StartUpAuthenticated());
    } else {
      emit(StartUpUnauthenticated());
    }
  }
}
