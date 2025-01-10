// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:library_system_frontend/controllers/login_register_controller.dart';
import 'package:library_system_frontend/models/user.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';
import 'package:library_system_frontend/views/account_page.dart';
import 'package:library_system_frontend/views/widgets/success_dialog.dart';

class LoginRegisterPage extends ConsumerStatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  ConsumerState<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends ConsumerState<LoginRegisterPage> {
  bool isLoginMode = true; // Toggle for Login/Register
  String role = 'patron'; // Toggle for Role (librarian/patron)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController(); // Only for registration
  bool _isLoading = false;

  String usernameError = '';
  String passwordError = '';
  String userIDError = '';
  String loginRegistrationError = '';
  
  @override
  void initState() {
    super.initState();
    ref.read(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    final loginRegisterController = LoginRegisterController(ref);

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
                        errorText: usernameError.isNotEmpty ? usernameError : null,
                      ),
                      onChanged: (_) => {
                        setState(() {
                          usernameError = loginRegisterController.validateUsername(_usernameController.text);
                        })
                      },
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
                        errorText: passwordError.isNotEmpty ? passwordError : null,
                      ),
                      onChanged: (_) => {
                        setState(() {
                          passwordError = loginRegisterController.validatePassword(_passwordController.text);
                        })
                      }
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
                          errorText: userIDError.isNotEmpty ? userIDError : null,
                        ),
                        onChanged: (_) => {
                          setState(() {
                            userIDError = loginRegisterController.validateID(_idController.text, role);
                          })
                        }
                      ),
                    ),
                  ],
                  SizedBox(height: 16.0),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                        loginRegistrationError = loginRegisterController.validateFields(
                          _usernameController.text,
                          _passwordController.text,
                          id: isLoginMode ? null : _idController.text,
                        );
                      });

                      try {
                        if (loginRegistrationError.isEmpty) {
                          if (isLoginMode) {
                            final user = await loginRegisterController.handleLogin(
                              _usernameController.text,
                              _passwordController.text
                            );
                          } else {
                            final user = User(
                              id: _idController.text, 
                              username: _usernameController.text, 
                              password: _passwordController.text, 
                              role: role,
                            );
                            
                            final success = await loginRegisterController.handleRegistration(user);

                            if (success != null) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => SuccessDialog(),
                                );
                              }
                              setState(() {
                                isLoginMode = true; // Switch to login mode
                              });
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loginRegistrationError)),
                          );
                        }
                      } catch (error) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')),
                          );
                        }
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: Text(isLoginMode ? 'Login' : 'Register'),
                  ),
                ],
              ),
            ),
    );
  }
}
