import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthState {
  final String token;
  final String role;

  AuthState({ required this.token, required this.role });

  bool get isAuthenticated => token.isNotEmpty;
  String get username => token.isNotEmpty ? JwtDecoder.decode(token)['username'] : '';
  String get password => token.isNotEmpty ? JwtDecoder.decode(token)['password'] : '';
  String get id => token.isNotEmpty ? JwtDecoder.decode(token)['id'] : '';
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(token: '', role: ''));

  void login(String token, String role) {
    state = AuthState(token: token, role: role);
  }

  void logout() {
    state = AuthState(token: '', role: '');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);