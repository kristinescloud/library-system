import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';
import 'package:library_system_frontend/theme/theme.dart';
import 'package:library_system_frontend/views/add_book_page.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final buttonKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      authState.username,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        authState.role,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder for icon image
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Icon(Icons.person, color: Colors.grey[700], size: 50.0,),
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(authState.username),
                      subtitle: Text('username'),
                    )),
                  Card(
                    child: ListTile(
                      title: Text('*' * authState.password.length),
                      subtitle: Text('password'),
                    )),
                  Card(
                    child: ListTile(
                      title: Text(authState.id),
                      subtitle: Text('identifier'),
                    )),
                ]
              ),
            ),
            SizedBox(height: 16.0),
            Row (
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color(0xff1c3943)),
                      ),
                      onPressed: () => ref.read(authProvider.notifier).logout(),
                      child: const Text('sign out')
                      ),
                  ),
                ),
                if (authState.role == 'librarian') ...[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      key: buttonKey,
                      onPressed: () async {
                        // Use a GlobalKey to get button position
                        
                        showPopupMenu(context, buttonKey);
                      },
                      style: ButtonStyle(),
                      child: Text('actions'),
                    ),
                  ),
                ),],
              ]
            )
          ],
        ),
      ),
    );
  }
}

  void _handleMenuSelection(BuildContext context, String action) {
    if (action == 'Add Book') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddBookPage(), // Navigate to Add Book (Page 1)
        ),
      );
    } else if (action == 'Edit Book Details') {
      // Implement navigation for editing book details
    } else if (action == 'Delete Book') {
      // Implement navigation for deleting a book
    }
  }

void showPopupMenu(BuildContext context, GlobalKey key) async {
    final RenderBox? button = key.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    if (button != null) {
      // Calculate position
      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(Offset.zero, ancestor: overlay),
          button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      );

      final value = await showMenu(
        context: context,
        position: position,
        items: [
          PopupMenuItem(
            value: 'add_book',
            onTap: () => _handleMenuSelection(context, 'Add Book'),
            child: Text('add book'),
          ),
          PopupMenuItem(
            value: 'edit_book',
            onTap: () => _handleMenuSelection(context, 'Edit Book Details'),
            child: Text('edit book details'),
          ),
          PopupMenuItem(
            value: 'delete_book',
            onTap: () => _handleMenuSelection(context, 'Delete Book'),
            child: Text('delete book'),
          ),
        ],
      );

      if (value != null) {
        _handleMenuSelection(context, value);
      }
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Unable to find button render object')),
        );
    }
  }

// class LibrarianMenu extends StatelessWidget {
//   const LibrarianMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextButton(
//           onPressed: () => _handleMenuSelection(context, 'Add Book'),
//           child: Text('Add Book'),
//         ),
//         TextButton(
//           onPressed: () => _handleMenuSelection(context, 'Edit Book Details'),
//           child: Text('Edit Book Details'),
//         ),
//         TextButton(
//           onPressed: () => _handleMenuSelection(context, 'Delete Book'),
//           child: Text('Delete Book'),
//         ),
//       ],
//     );
//   }
// }
