import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailsPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
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
            Text('Title: ${book['title']}', style: TextStyle(fontSize: 18)),
            Text('Author: ${book['author']}', style: TextStyle(fontSize: 18)),
            Text('Quantity: ${book['quantity']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              'Additional Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Publication Date: ${book['publicationDate'] ?? 'N/A'}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}