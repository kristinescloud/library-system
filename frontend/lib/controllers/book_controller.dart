import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class BookController {
  final WidgetRef ref;
  final String authToken;

  BookController(this.ref, this.authToken);

  Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/books'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(book.toJson()),
    );

    if (response.statusCode != 200) {
      final errorMessage = json.decode(response.body)['error'] ?? 'Failed to add book.';
      throw Exception(errorMessage);
    }
  }

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/books'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> fetchBookById(String id) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/books/$id'),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book');
    }
  }

  Future<void> updateBook(Book book) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/books/${book.isbn}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(book.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update book');
    }
  }

  Future<void> deleteBook(String id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:3000/api/books/$id'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }
}