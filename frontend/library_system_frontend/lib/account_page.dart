import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'user_account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoginMode = true; // Toggle for Login/Register
  String role = 'patron'; // Toggle for Role (librarian/patron)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController(); // Only for registration
  bool _isLoading = false;
  final validUsername = RegExp(r'^[A-Za-z][A-Za-z0-9_]{5,29}$');
  final validPatronID = RegExp(r'^[0-9]{14}$');
  final validLibrarianID = RegExp(r'^L[0-9]{9}[A-Z]$');

  String? message;
  String? usernameEmptyError;
  String? usernameInvalidError;
  String? passwordEmptyError;
  String? passwordInvalidLengthError;
  String? idError;

  void validateFields() {
    setState(() {
      usernameEmptyError = _usernameController.text.isEmpty
          ? 'Username cannot be empty'
          : null;

      usernameInvalidError = !validUsername.hasMatch(_usernameController.text)
          ? 'Invalid username.'
          : null;

      passwordEmptyError = _passwordController.text.isEmpty
          ? 'Password cannot be empty'
          : null;

      passwordInvalidLengthError = _passwordController.text.length < 6 || _passwordController.text.length > 50
          ? 'Password must be between 6 and 50 characters inclusive.'
          : null;

      if (!isLoginMode) {
        if (_idController.text.isEmpty) {
          idError = 'ID number cannot be empty';
        } else if (role == 'patron' && !validPatronID.hasMatch(_idController.text)) {
          idError = 'Invalid library card number.';
        } else if (role == 'librarian' && !validLibrarianID.hasMatch(_idController.text)) {
          idError = 'Invalid employee ID number.';
        } else {
          idError = null;
        }
      }
    });
  }

  Future<void> handleLogin() async {
    validateFields();
    if (usernameEmptyError != null || passwordEmptyError != null || 
        usernameInvalidError != null || passwordInvalidLengthError != null) {
      return; // Exit if there are validation errors
    }

    setState(() {
      _isLoading = true;
    });

    try {
        final reqBody = { 
          'username': _usernameController.text,
          'password': _passwordController.text 
          };
        final response = await http.post(
          Uri.parse('http://127.0.0.1:3000/api/auth/login'), 
          body: reqBody, 
          headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          if (token == null) throw Exception('Token not found in response.');
          final decodedToken = JwtDecoder.decode(token);
          final userID = decodedToken['id'];
          final userRole = decodedToken['role'];

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserAccountPage(
                id: userID,
                username: 'PLACEHOLDER',
                password: 'PLACEHOLDER',
                role: userRole), 
            ),
          );

        } else {
          final errorMessage = json.decode(response.body)['error'] ?? 'Login failed';
          throw Exception(errorMessage);
        }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> handleRegistration() async {
    validateFields();
    if (usernameEmptyError != null || passwordEmptyError != null ||   
        idError != null || usernameInvalidError != null || 
        passwordInvalidLengthError != null) {
      return; // Exit if there are validation errors
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final reqBody = json.encode({ 
        'id': _idController.text, 
        'username': _usernameController.text,
        'password': _passwordController.text,
        'role': role
        });
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/api/auth/register'), 
        body: reqBody,
        headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialog(),
          );
          setState(() {
            isLoginMode = true; // Switch to login mode
          });
      } else {
        final errorMessage = json.decode(response.body)['error'] ?? 'Registration failed';
        throw Exception(errorMessage);
      }

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('libro')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login/Register Toggle
                  ToggleButtons(
                    isSelected: [isLoginMode, !isLoginMode],
                    onPressed: (index) {
                      setState(() {
                        isLoginMode = index == 0;
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      minHeight: 32.0,
                      minWidth: 175.0
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Login'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Register'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Role Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I am a  '),
                      ToggleButtons(
                        isSelected: [role == 'patron', role == 'librarian'],
                        onPressed: (index) {
                          setState(() {
                            role = index == 0 ? 'patron' : 'librarian';
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Patron'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Librarian'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Form Fields
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0))
                          ),
                        labelText: 'Username',
                        errorText: usernameEmptyError,
                      ),
                      onChanged: (_) => validateFields(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0))
                          ),
                        labelText: 'Password',
                        errorText: passwordEmptyError,
                      ),
                      onChanged: (_) => validateFields(),
                    ),
                  ),
                  if (!isLoginMode) ...[
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0))
                          ),
                          labelText: (role == 'patron') ? 'Library Card Number': 'Employee ID',
                          errorText: idError,
                        ),
                        onChanged: (_) => validateFields(),
                      ),
                    ),
                  ],
                  SizedBox(height: 16.0),
                  // Submit Button
                  ElevatedButton(
                    onPressed: isLoginMode ? handleLogin : handleRegistration,
                    child: Text(isLoginMode ? 'Login' : 'Register'),
                  ),
                ],
              ),
            ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the dialog on tap
      },
      child: Center(
        child: Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64.0),
                SizedBox(height: 16.0),
                Text(
                  'Registration Successful!',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Tap anywhere to return to the login page.',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}