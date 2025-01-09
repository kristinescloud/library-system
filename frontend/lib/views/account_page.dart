import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

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
              'Username: ${authState.username}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Password: ${'*' * authState.password.length}', // Hidden password
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'ID Number: ${authState.id}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Role: ${authState.role}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            if (authState.role == 'librarian') ...[
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
  const LibrarianMenu({super.key});

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
