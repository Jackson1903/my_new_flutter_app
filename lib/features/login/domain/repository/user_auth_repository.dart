abstract class UserAuthRepository {
  Future<bool> signInWithEmailAndPassword(String username, String password);
  Future<bool> registerUserWithEmailAndPassword(String username, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
}
