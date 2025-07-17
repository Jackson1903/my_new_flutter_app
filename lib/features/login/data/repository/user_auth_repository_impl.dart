import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/datasource/user_auth_datasource.dart';
import '../../domain/repository/user_auth_repository.dart';
import '../datasource/user_auth_datasource_impl.dart';

part 'user_auth_repository_impl.g.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserAuthDataSource _dataSource;

  UserAuthRepositoryImpl(this._dataSource);

  @override
  Future<bool> signInWithEmailAndPassword(String username, String password) async {
    try {
      final user = await _dataSource.signInWithEmailAndPassword(username, password);
      return user != null;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<bool> registerUserWithEmailAndPassword(String username, String password) async {
    try {
      final user = await _dataSource.createUserWithEmailAndPassword(username, password);
      return user != null;
    } catch (e) {
      throw Exception('Failed to register in: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _dataSource.logout();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await _dataSource.isAuthenticated();
  }
}

@riverpod
UserAuthRepository userAuthRepository(Ref ref) {
  final dataSource = ref.watch(userAuthDataSourceProvider);
  return UserAuthRepositoryImpl(dataSource);
}
