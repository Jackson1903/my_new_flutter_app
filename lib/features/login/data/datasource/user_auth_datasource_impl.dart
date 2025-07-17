import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/datasource/user_auth_datasource.dart';

part 'user_auth_datasource_impl.g.dart';

class UserAuthDataSourceImpl implements UserAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  UserAuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception('No user returned after sign in.');
      }
      return user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('No  register user returned.');
      }
      return user;
    } catch (e) {
      throw Exception('Failed to register in: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser != null;
  }
}

@riverpod
UserAuthDataSource userAuthDataSource(Ref ref) {
  final firebaseAuth = FirebaseAuth.instance;
  return UserAuthDataSourceImpl(firebaseAuth);
}
