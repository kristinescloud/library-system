import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:library_system_frontend/models/user.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';

class LoginRegisterController {
  final WidgetRef ref;

  LoginRegisterController(this.ref);

   String validateUsername(String username) {
    final validUsername = RegExp(r'^[A-Za-z][A-Za-z0-9_]{5,29}$');

    if (username.isEmpty) {
      return 'Username cannot be empty.';
    } else if (!validUsername.hasMatch(username)) {
      return 'Username is invalid.';
    } else {
      return '';
    }
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 6 || password.length > 50) {
      return 'Password must be between 6 and 50 characters inclusive.';
    } else {
      return '';
    }  
  }

  String validateID(String id, String role) {
    final validPatronID = RegExp(r'^[0-9]{14}$');
    final validLibrarianID = RegExp(r'^L[0-9]{9}[A-Z]$');

    if (id.isEmpty) {
      return 'ID number cannot be empty';
    } else if (role == 'patron' && !validPatronID.hasMatch(id)) {
      return 'Invalid Patron ID.';
    } else if (role == 'librarian' && !validLibrarianID.hasMatch(id)) {
      return 'Invalid Librarian ID.';
    } else {
      return '';
    }
}

  String validateFields(String username, String password, {String? id, String? role}) {
    final usernameError = validateUsername(username);
    final passwordError = validatePassword(password);
    if (usernameError.isEmpty && passwordError.isEmpty) {
      if (id != null && role != null) {
        final idError = validateID(id, role);
        return idError.isNotEmpty ? 'Please ensure all fields are valid and try again.' : '';
      }
      return '';
    }
    return 'Please ensure all fields are valid and try again.';
  }

  Future<User?> handleLogin(String username, String password) async {
    final reqBody = json.encode({ 
      'username': username,
      'password': password 
      });
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/auth/login'), 
      body: reqBody, 
      headers: {'Content-Type': 'application/json'}
    );
    if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        if (token == null) throw Exception('Token not found in response.');
        log("arrived");
        final decodedToken = JwtDecoder.decode(token);
        log(decodedToken.toString());
        final user = User.fromJson(decodedToken);
        log(user.toString());
        // final userID = decodedToken['id'];
        // final userRole = decodedToken['role'];

        // update the authentication state
        ref.read(authProvider.notifier).login(token, user.role);
        log("arrived2");

        // return the authenticated user
        return user;

    } else {
          final errorMessage = json.decode(response.body)['error'] ?? 'Login failed';
          throw Exception(errorMessage);
    }
  }

  Future<bool?> handleRegistration(User user) async {
    final reqBody = json.encode(user.toJson());
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/auth/register'), 
      body: reqBody,
      headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMessage = json.decode(response.body)['error'] ?? 'Registration failed';
      throw Exception(errorMessage);
    }
  }
}