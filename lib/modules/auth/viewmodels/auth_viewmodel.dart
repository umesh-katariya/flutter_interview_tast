import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, bool>((ref) {
  return AuthViewModel();
});

class AuthResult {
  final bool success;
  final String message;
  AuthResult({required this.success, required this.message});
}

class AuthViewModel extends StateNotifier<bool> {
  AuthViewModel() : super(false); // false = not loading

  final _auth = FirebaseAuth.instance;

  Future<AuthResult> loginOrRegister(String email, String password) async {
    state = true; // set loading true
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult(success: true, message: 'Login successful');
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: e.message ?? 'Authentication error',
      );
    } catch (_) {
      return AuthResult(success: false, message: 'Something went wrong');
    } finally {
      state = false; // stop loading
    }
  }

  String? get currentUserEmail => _auth.currentUser?.email;
  Future<void> logout() => _auth.signOut();
}
