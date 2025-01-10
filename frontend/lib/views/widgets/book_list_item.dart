import 'package:flutter/material.dart';
import 'package:library_system_frontend/models/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookListItem({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.grey[300], // Placeholder for book cover image
          child: Icon(Icons.book, color: Colors.grey[700]),
        ),
        title: Text(book.title),
        subtitle: Text('Author: ${book.author}\nQuantity: ${book.quantity}'),
        onTap: onTap,
      ),
    );
  }
}