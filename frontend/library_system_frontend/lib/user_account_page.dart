import 'package:flutter/material.dart';

class UserAccountPage extends StatelessWidget {
  final String id;
  final String username;
  final String password; // Hidden in UI
  final String role;

  const UserAccountPage({super.key, 
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Common Information
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Password: ${'*' * password.length}', // Hidden password
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'ID Number: $id',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Role: ${role[0].toUpperCase()}${role.substring(1)}', // Capitalize role
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            if (role == 'librarian') ...[
              Divider(),
              Text(
                'Librarian Functions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              LibrarianMenu(),
            ],
          ],
        ),
      ),
    );
  }
}

class LibrarianMenu extends StatelessWidget {
  void _handleMenuSelection(BuildContext context, String action) {
    // Placeholder for future functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action selected')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => _handleMenuSelection(context, 'Add Book'),
          child: Text('Add Book'),
        ),
        TextButton(
          onPressed: () => _handleMenuSelection(context, 'Edit Book Details'),
          child: Text('Edit Book Details'),
        ),
        TextButton(
          onPressed: () => _handleMenuSelection(context, 'Delete Book'),
          child: Text('Delete Book'),
        ),
      ],
    );
  }
}
