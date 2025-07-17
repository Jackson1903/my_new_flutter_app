import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/user_auth_repository_impl.dart';

part 'user_auth_view_model.g.dart';

enum UserAuthState {
  initial,
  loading,
  authenticated,
  error,
}

@riverpod
class UserAuthViewModel extends _$UserAuthViewModel {
  @override
  UserAuthState build() {
    return UserAuthState.initial;
  }

  Future<bool> isAuthenticated({required String user, required String password}) async {
    state = UserAuthState.loading;

    try {
      final userAunthRepository = ref.read(userAuthRepositoryProvider);
      final isAuthenticated = await userAunthRepository.signInWithEmailAndPassword(user, password);
      // Logic to check if the user is authenticated
      if (isAuthenticated) {
        state = UserAuthState.authenticated;
        return true;
      } else {
        state = UserAuthState.error;
        return false;
      }
    } catch (e) {
      state = UserAuthState.error;
      return false;
    }
  }

  Future<bool> isRegister({required String user, required String password}) async {
    state = UserAuthState.loading;

    try {
      final userAunthRepository = ref.read(userAuthRepositoryProvider);
      final isAuthenticated =
          await userAunthRepository.registerUserWithEmailAndPassword(user, password);
      // Logic to check if the user is authenticated
      if (isAuthenticated) {
        state = UserAuthState.authenticated;
        return true;
      } else {
        state = UserAuthState.error;
        return false;
      }
    } catch (e) {
      state = UserAuthState.error;
      return false;
    }
  }
}
