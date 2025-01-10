import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_system_frontend/controllers/book_controller.dart';
import 'package:library_system_frontend/models/book.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';

class BookDetailsPage extends ConsumerWidget {
  final Book book;
  final bool? withConfirm;

  const BookDetailsPage({super.key, required this.book, this.withConfirm});

  void _confirmSubmission(BuildContext context, WidgetRef ref) async {
    final authState = ref.watch(authProvider);
    final bookController = BookController(ref, authState.token);

    try {
      await bookController.addBook(book);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book added successfully')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      // Navigate to home page with book details
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add book')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: <Widget>[
          if (withConfirm != null) ...[
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(4294957782)),
              ),
              onPressed: () => _confirmSubmission(context, ref),
              child: Text('confirm'),
            ),
          ],
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 200,
                color: Colors.grey[300], // Placeholder for book cover image
                child: Icon(Icons.book, size: 100, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 16),
            Text('Title: ${book.title}', style: TextStyle(fontSize: 18)),
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            Text('Quantity: ${book.quantity}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              'Additional Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Publication Date: ${book.publicationDate ?? 'N/A'}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}